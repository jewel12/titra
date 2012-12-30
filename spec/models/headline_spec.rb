# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Headline Model" do
  let(:headline) { Headline.new }
  it 'can be created' do
    headline.should_not be_nil
  end

  it 'is_translatedの初期値がfalseである' do
    headline[:is_translated].should be_false
    headline[:is_translated].should_not be_nil
  end
end
