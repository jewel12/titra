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
                                  :account => title_old.account)
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

  describe ".create_or_update" do
    before(:each) do
      @account = FactoryGirl.create(:account)
      @headline = FactoryGirl.create(:headline)
    end

    it "新規に登録できる" do
      lambda{
        TitleTranslation.create_or_update(:title => 'Ruby',
                                          :account => @account,
                                          :headline => @headline)
      }.should change(TitleTranslation, :count).by(1)
    end

    it "既に同じ翻訳者と記事が存在する場合は更新する" do
      old_title = 'old'
      new_title = 'updated'
      translated_title = FactoryGirl.create(:human_translated_title_translation, :title => old_title)

      TitleTranslation.find(translated_title.id).title.should == old_title

      TitleTranslation.create_or_update(:title => new_title,
                                        :account => translated_title.account,
                                        :headline => translated_title.headline)

      TitleTranslation.find(translated_title.id).title.should == new_title
    end


  end

end
