# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Headline Model" do
  let(:headline) { Headline.new }
  it 'can be created' do
    headline.should_not be_nil
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

  context "タイトル翻訳がある場合" do
    let(:headline_with_translations) { FactoryGirl.create(:headline_with_translations) }

    describe "#translations" do
      subject { headline_with_translations.title_translations }
      it { should have(2).items }
    end
  end

  context "Titleを検証するとき" do
    it "空文字は無効" do
      FactoryGirl.build(:headline, :title => '').should be_invalid
    end

    it "空白のみの内容は無効" do
      FactoryGirl.build(:headline, :title => '  ').should be_invalid
      FactoryGirl.build(:headline, :title => '　　').should be_invalid
      FactoryGirl.build(:headline, :title => '　 ').should be_invalid
    end

    it "空白を含んだ文字列は有効" do
      FactoryGirl.build(:headline, :title => 'Hello World!').should be_valid
      FactoryGirl.build(:headline, :title => ' Hello World!').should be_valid
      FactoryGirl.build(:headline, :title => 'Hello　World!').should be_valid
    end
  end
end
