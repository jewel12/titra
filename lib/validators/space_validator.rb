# -*- coding: utf-8 -*-
class SpaceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "が全角空白のみを含んでいます" if value =~ /^[ 　]+$/
  end
end
