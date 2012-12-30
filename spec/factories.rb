# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :yamada, :class => Account do
    name = "Yamada"
    uid = "123456"
    provider = "github"
  end

  factory :ruby_article, :class => Headline do
    title = "Ruby is good!"
    is_translated = false
    url = "http://ruby-example.com/"
  end

  factory :ruby_article_transltion, :class => TitleTranslation do
    title = "Rubyは良い"
  end
end
