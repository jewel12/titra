# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Headline Model" do
  let(:headline) { Headline.new }
  it 'can be created' do
    headline.should_not be_nil
  end

  describe "Headline#is_translated" do
    let(:is_translated) { headline.is_translated }
    it '初期値がfalseである' do
      headline[:is_translated].should be_false
      headline[:is_translated].should_not be_nil
    end
  end

  context "既に存在するURLで登録する場合" do
    before(:all) do
      @registed_headline = FactoryGirl.create(:headline)
    end

    it "登録できない" do
      headline = Headline.new(:title => "test", :url => @registed_headline.url)
      headline.should be_invalid
    end
  end

  context "Headlineのタイトル翻訳がある場合" do
    let(:headline_with_translations) { FactoryGirl.create(:headline_with_translations) }

    describe "Headline#translations" do
      subject { headline_with_translations.title_translations }
      it { should have(2).items }
    end
  end
end
