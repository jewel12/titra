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
end
