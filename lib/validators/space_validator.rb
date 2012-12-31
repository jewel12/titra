# -*- coding: utf-8 -*-
class SpaceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "全角空白のみを含んでいる" if value =~ /^[ 　]+$/
  end
end
