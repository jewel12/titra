require 'spec_helper'

describe "TitleTranslation Model" do
  let(:title_translation) { TitleTranslation.new }
  it 'can be created' do
    title_translation.should_not be_nil
  end
end
