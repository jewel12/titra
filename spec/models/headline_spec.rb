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
      subject { headline_with_translations.translations }
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

  describe ".first_or_initialize_by_url" do
    context "Headlinesに存在しないURLだった場合" do
      before(:each) do
        f = FactoryGirl.build(:headline)
        @headline = Headline.first_or_initialize_by_url({ :title => f.title, :url => f.url })
      end

      it "保存できる" do
        @headline.save.should be_true
      end

      it "Headlinesに新しく登録される" do
        lambda{ @headline.save }.should change(Headline, :count).by(1)
      end
    end

    context "Headlinesに既に存在するURLだった場合" do
      before(:each) do
        existing_headline = FactoryGirl.create(:headline)
        url = existing_headline.url
        @new_title = "updated_title"

        @headline = Headline.first_or_initialize_by_url({ :title => @new_title, :url => url })
      end

      it "保存できる" do
        @headline.save.should be_true
      end

      it "アップデートなのでHeadlineの総数は変化しない" do
        lambda{ @headline.save }.should_not change(Headline, :count)
      end

      it "タイトルが更新されている" do
        @headline.title.should == @new_title
      end
    end
  end
end
