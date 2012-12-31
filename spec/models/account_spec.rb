# -*- coding: utf-8 -*-
require 'spec_helper'

shared_examples_for "a valid string" do |param_name|
  it "空文字は無効" do
    FactoryGirl.build(:account, param_name => '').should be_invalid
  end

  it "空白のみの内容は無効" do
    FactoryGirl.build(:account, param_name => ' ').should be_invalid
    FactoryGirl.build(:account, param_name => '　').should be_invalid
    FactoryGirl.build(:account, param_name => '　 ').should be_invalid
  end

  it "空白を含んだ文字列は有効" do
    FactoryGirl.build(:account, param_name => 'Ruby is good').should be_valid
    FactoryGirl.build(:account, param_name => 'Ruby　is good').should be_valid
    FactoryGirl.build(:account, param_name => ' Ruby　is  good').should be_valid
  end
end

describe "Account Model" do
  let(:account) { Account.new }
  it 'can be created' do
    account.should_not be_nil
  end

  describe ".name" do
    it_behaves_like "a valid string", :name
  end

  describe ".uid" do
    it_behaves_like "a valid string", :name
  end

  describe ".provider" do
    it_behaves_like "a valid string", :name
  end
end
