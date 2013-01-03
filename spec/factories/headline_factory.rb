FactoryGirl.define do
  factory :headline do
    title "Ruby is good!"
    sequence(:url) { |i| "http://ruby-example#{i}.com/" }

    factory :headline_with_translations do
      translations {FactoryGirl.create_list(:translation, 2)}
    end
  end
end
