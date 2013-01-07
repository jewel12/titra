# -*- coding: utf-8 -*-
require 'spec_helper'

shared_examples_for "a valid string" do |param_name|
  it "空文字は無効" do
    FactoryGirl.build(:translator, param_name => '').should be_invalid
  end

  it "空白のみの内容は無効" do
    FactoryGirl.build(:translator, param_name => ' ').should be_invalid
    FactoryGirl.build(:translator, param_name => '　').should be_invalid
    FactoryGirl.build(:translator, param_name => '　 ').should be_invalid
  end

  it "空白を含んだ文字列は有効" do
    FactoryGirl.build(:translator, param_name => 'Ruby is good').should be_valid
    FactoryGirl.build(:translator, param_name => 'Ruby　is good').should be_valid
    FactoryGirl.build(:translator, param_name => ' Ruby　is  good').should be_valid
  end
end

describe "Translator Model" do
  let(:translator) { Translator.new }
  it 'can be created' do
    translator.should_not be_nil
  end

  describe "#name" do
    it_behaves_like "a valid string", :name
  end

  describe "#uid" do
    it_behaves_like "a valid string", :name
  end

  describe "#provider" do
    it_behaves_like "a valid string", :name
  end

  describe "#translations" do
    before do
      @translator = FactoryGirl.create(:translator)
      3.times { FactoryGirl.create(:translation, :translator => @translator) }
    end

    it "3つ翻訳を持っている" do
      @translator.translations.should have(3).items
      FactoryGirl.create(:translator).translations.should be_empty
    end
  end

  describe "#tanslate_headline" do

    context "翻訳対象のHeadlineが存在しない場合" do
      before(:each) do
        translator = FactoryGirl.create(:translator)
        h = FactoryGirl.build(:headline)
        t = FactoryGirl.build(:translation_without_headline)
        h_param = { :url => h.url, :title => h.title }
        t_param = { :title => t.title }
        @translation_proc = lambda{ translator.translate_headline(h_param, t_param) }
      end

      it "翻訳されたHeadlineを保存できる" do
        lambda { @translation_proc.call }.should_not raise_error
      end

      it "Headlineが１つ増加している" do
        lambda { @translation_proc.call }.should change(Headline, :count).by(1)
      end

      it "Translationが１つ増加している" do
        lambda { @translation_proc.call }.should change(Translation, :count).by(1)
      end
    end

    context "翻訳対象のHeadlineが存在する場合" do
      before(:each) do
        translator = FactoryGirl.create(:translator)
        h = FactoryGirl.create(:headline)
        t = FactoryGirl.build(:translation_without_headline)
        h_param = { :url => h.url, :title => h.title }
        t_param = { :title => t.title }
        @translation_proc = lambda{ translator.translate_headline(h_param, t_param) }
      end

      it "翻訳されたHeadlineを保存できる" do
        lambda { @translation_proc.call }.should_not raise_error
      end

      it "Headlineの数は変化していない" do
        lambda { @translation_proc.call }.should_not change(Headline, :count)
      end

      it "Translationが１つ増加している" do
        lambda { @translation_proc.call }.should change(Translation, :count).by(1)
      end
    end

    context "翻訳対象のHeadlineが存在し、Translatorの翻訳も既に存在する場合" do
      before(:each) do
        translator = FactoryGirl.create(:translator)
        h = FactoryGirl.create(:headline)
        t = FactoryGirl.create(:translation_without_headline, :headline => h, :translator => translator)
        h_param = { :url => h.url, :title => h.title }
        t_param = { :title => t.title }
        @translation_proc = lambda{ translator.translate_headline(h_param, t_param) }
      end

      it "翻訳されたHeadlineを保存できる" do
        lambda { @translation_proc.call }.should_not raise_error
      end

      it "Headlineの数は変化していない" do
        lambda { @translation_proc.call }.should_not change(Headline, :count)
      end

      it "Translationの数は変化していない" do
        lambda { @translation_proc.call }.should_not change(Translation, :count)
      end
    end

    context "Translationのみが不正な場合" do
      before(:each) do
        translator = FactoryGirl.create(:translator)
        h = FactoryGirl.build(:headline)
        t = FactoryGirl.build(:translation_without_headline)
        h_param = { :url => h.url, :title => h.title }
        t_param = { :title => '' }
        @translation_proc = lambda{ translator.translate_headline(h_param, t_param) }
      end

      it "Headlineは作成される" do
        lambda { @translation_proc.call }.should change(Headline, :count).by(1)
      end

      it "Translationの数は変化していない" do
          lambda { @translation_proc.call }.should_not change(Translation, :count)
      end

      it "Translationは不正である" do
        translation = @translation_proc.call.last
        translation.invalid?.should be_true
      end
    end

    context "Headlineのみが不正な場合" do
      before(:each) do
        translator = FactoryGirl.create(:translator)
        h = FactoryGirl.build(:headline)
        t = FactoryGirl.build(:translation_without_headline)
        h_param = { :url => "", :title => "" }
        t_param = { :title => t.title }
        @translation_proc = lambda{ translator.translate_headline(h_param, t_param) }
      end

      it "Headlineは作成されていない" do
        lambda { @translation_proc.call }.should_not change(Headline, :count)
      end

      it "Translationは作成されていない" do
          lambda { @translation_proc.call }.should_not change(Translation, :count)
      end

      it "TranslationもHeadlineも不正である" do
        @translation_proc.call.each do |model|
          model.invalid?.should be_true
        end
      end
    end

    context "TranslationもHeadlineも不正な場合" do
      before(:each) do
        translator = FactoryGirl.create(:translator)
        h_param = { :url => "", :title => "" }
        t_param = { :title => "" }
        @translation_proc = lambda{ translator.translate_headline(h_param, t_param) }
      end

      it "Headlineは作成されていない" do
        lambda { @translation_proc.call }.should_not change(Headline, :count)
      end

      it "Translationは作成されていない" do
          lambda { @translation_proc.call }.should_not change(Translation, :count)
      end

      it "TranslationもHeadlineも不正である" do
        @translation_proc.call.each do |model|
          model.invalid?.should be_true
        end
      end
    end

  end

  describe "#withdraw" do
    before(:each) do
      headline = FactoryGirl.create(:headline)
      @translation1 = FactoryGirl.create(:human_translated, :headline_id => headline.id)
      @translation2 = FactoryGirl.create(:translation, :translator_id => @translation1.translator.id)
      @translator = @translation1.translator
    end

    it "Translatorが削除される" do
      id = @translator.id
      Translator.where(:id => id).first.should_not be_nil
      @translator.withdraw
      Translator.where(:id => id).first.should be_nil
    end

    it "TranslatorのTranslationが削除されている" do
      translation_ids = [@translation1, @translation2].map(&:id)
      translation_ids.each { |id| Translation.where(:id => id).first.should_not be_nil }
      @translator.withdraw
      translation_ids.each { |id| Translation.where(:id => id).first.should be_nil }
    end

    it "削除されたTranslationのみが紐付いているHeadlineは削除" do
      headline = @translation1.headline
      rel = Headline.where(:id => headline.id)
      lambda { @translator.withdraw }.should change(rel, :count).from(1).to(0)
    end

    context "Headlineに削除されたTranslation以外にも紐付いているTranslationがあるとき" do
      before(:each) do
        headline = @translation1.headline
        FactoryGirl.create(:translation, :headline_id => headline.id)
      end

      it "Headlineが削除されない" do
        headline = @translation1.headline
        rel = Headline.where(:id => headline.id)
        lambda { @translator.withdraw }.should_not change(rel, :count)
      end
    end
  end

end
