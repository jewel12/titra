FactoryGirl.define do
  factory :headline do
    title "Ruby is good!"
    is_translated false
    url "http://ruby-example1.com/"

    factory :headline_with_translations do
      url "http://ruby-example2.com/"
      title_translations {FactoryGirl.create_list(:title_translation, 2)}
    end
  end
end
