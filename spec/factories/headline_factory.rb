FactoryGirl.define do
  factory :headline do
    title "Ruby is good!"
    is_translated false
    sequence(:url) { |i| "http://ruby-example#{i}.com/" }

    factory :headline_with_translations do
      title_translations {FactoryGirl.create_list(:title_translation, 2)}
    end
  end
end
