# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :account do
    name = "Yamada"
    uid = "123456"
    provider = "github"
  end

  factory :headline do
    title = "Ruby is good!"
    is_translated = false
    url = "http://ruby-example.com/"

    factory :headline_with_translations do
      after(:create) do |headline|
        headline.title_translations = FactoryGirl.create_list(:title_translation, 2)
      end
    end
  end

  factory :title_translation do
    sequence(:title) { |i| "Rubyは良い#{i}" }
    sequence(:updated_at) { |i| i.days.ago }
  end
end
