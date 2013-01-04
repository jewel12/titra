# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :translation do
    sequence(:title) { |i| "Rubyは良い#{i}" }
    sequence(:summary) { |i| "Rubyの要約#{i}" }
    sequence(:updated_at) { |i| i.days.ago }
    headline {FactoryGirl.create(:headline)}

    factory :human_translated do
      translator {FactoryGirl.create(:translator)}
    end
  end

  factory :translation_without_headline, :class => Translation do
    sequence(:title) { |i| "Rubyは良い#{i}" }
    sequence(:summary) { |i| "Rubyの要約#{i}" }
  end
end
