require 'spec_helper'

describe "Trnaslation Model" do
  let(:trnaslation) { Trnaslation.new }
  it 'can be created' do
    trnaslation.should_not be_nil
  end
end
