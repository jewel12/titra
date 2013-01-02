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

  context "URLを検証するとき" do
    it "URLでない場合は無効" do
      FactoryGirl.build(:headline, :url => 'kuma').should be_invalid
      FactoryGirl.build(:headline, :url => '').should be_invalid
    end

    it "http(s)のスキームである場合は有効" do
      FactoryGirl.build(:headline, :url => 'http://example.com').should be_valid
      FactoryGirl.build(:headline, :url => 'https://example.com').should be_valid
    end

    it "http(s)のスキームでない場合は無効" do
      FactoryGirl.build(:headline, :url => 'ht://kuma.com').should be_invalid
    end
  end

  describe ".create_with_title_translation" do
    context "HeadlineのURLがまだ登録されていない場合" do
      before(:each) do
        headline = FactoryGirl.build(:headline)
        @params = {
          :url => headline.url,
          :title => headline.title,
          :translation => "これは翻訳です",
          :account => FactoryGirl.create(:account)
        }
      end

      it "Headlineの数は増加していること" do
        lambda {
          Headline.create_with_title_translation(@params)
        }.should change(Headline, :count).by(1)
      end

      it "TitleTranslationsの数は増加していること" do
        lambda {
          headline = Headline.create_with_title_translation(@params)
        }.should change(TitleTranslation, :count).by(1)
      end
    end

    context "HeadlineのURLが既に登録されている場合" do
      before(:each) do
        @existing_headline = FactoryGirl.create(:headline)
        @params = {
          :url => @existing_headline.url,
          :title => @existing_headline.title,
          :translation => "これは翻訳です",
          :account => FactoryGirl.create(:account)
        }
      end

      it "Headlineの数は変化しないこと" do
        lambda {
          Headline.create_with_title_translation(@params)
        }.should_not change(Headline, :count)
      end

      it "作成したheadline_idを持つTitleTranslationsの数は増加していること" do
        counter = lambda { TitleTranslation.where(:headline_id => @existing_headline.id).all.count }
        lambda {
          headline = Headline.create_with_title_translation(@params)
        }.should change(counter, :call).by(1)
      end
    end

  end


end
