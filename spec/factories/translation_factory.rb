# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :translation do
    sequence(:title) { |i| "Rubyは良い#{i}" }
    sequence(:updated_at) { |i| i.days.ago }
    headline {FactoryGirl.create(:headline)}

    factory :human_translated do
      translator {FactoryGirl.create(:translator)}
    end
  end
end
