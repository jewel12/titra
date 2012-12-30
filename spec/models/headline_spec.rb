# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Headline Model" do
  let(:headline) { Headline.new }
  it 'can be created' do
    headline.should_not be_nil
  end

  describe "headline#is_translated" do
    let(:is_translated) { headline.is_translated }
    it '初期値がfalseである' do
      headline[:is_translated].should be_false
      headline[:is_translated].should_not be_nil
    end
  end

end
