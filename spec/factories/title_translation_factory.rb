# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :title_translation do
    sequence(:title) { |i| "Rubyは良い#{i}" }
    sequence(:updated_at) { |i| i.days.ago }
    headline {FactoryGirl.create(:headline)}

    factory :human_translated_title_translation do
      translator {FactoryGirl.create(:account)}
    end
  end
end
