# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.human_enum_name(enum_name, enum_value)
    enum_i18n_key = enum_name.to_s.pluralize
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_i18n_key}.#{enum_value}")
  end

  def titleize_name
    return if name.blank?

    self.name = if name.sub('-', '').eql?(name)
                  name.split.map(&:capitalize).join(' ')
                else
                  name.tr('-', ' ').split.map(&:capitalize).join('-')
                end
  end

  def titleize_surname
    return if surname.blank?

    self.surname = if surname.sub('-', '').eql?(surname)
                     surname.split.map(&:capitalize).join(' ')
                   else
                     surname.tr('-', ' ').split.map(&:capitalize).join('-')
                   end
  end
end
