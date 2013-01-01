# -*- coding: utf-8 -*-
require 'spec_helper'

describe "TitleTranslation Model" do
  let(:title_translation) { TitleTranslation.new }
  it 'can be created' do
    title_translation.should_not be_nil
  end

  it "対応するヘッドラインが無い場合は登録できない" do
    FactoryGirl.build(:title_translation, :headline => nil).should be_invalid
  end

  it "同じヘッドラインとアカウントの組み合わせを持つ翻訳は１つのみ" do
    title_old = FactoryGirl.create(:human_translated_title_translation, :title => "title_old")
    title_old.should be_valid

    title_new = FactoryGirl.build(:human_translated_title_translation,
                                  :title => "title_new",
                                  :headline => title_old.headline,
                                  :translator => title_old.translator)
    title_new.should be_invalid
  end

  context "翻訳されたタイトルを検証するとき" do
    it "空文字は無効" do
      FactoryGirl.build(:title_translation, :title => '').should be_invalid
    end

    it "空白のみの内容は無効" do
      FactoryGirl.build(:title_translation, :title => ' ').should be_invalid
      FactoryGirl.build(:title_translation, :title => '　').should be_invalid
      FactoryGirl.build(:title_translation, :title => '　 ').should be_invalid
    end

    it "空白を含んだ文字列は有効" do
      FactoryGirl.build(:title_translation, :title => 'Ruby はいい').should be_valid
      FactoryGirl.build(:title_translation, :title => 'Ruby　はいい').should be_valid
      FactoryGirl.build(:title_translation, :title => ' Ruby　はいい').should be_valid
    end
  end

end
