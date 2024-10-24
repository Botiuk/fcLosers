# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.human_enum_name(enum_name, enum_value)
    enum_i18n_key = enum_name.to_s.pluralize
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_i18n_key}.#{enum_value}")
  end

  def titleize_name_surname
    self.name = name.split.map(&:capitalize).join(' ') if name.present? && name.sub('-', '').eql?(name)
    self.surname = surname.split.map(&:capitalize).join(' ') if surname.present? && surname.sub('-', '').eql?(surname)
  end
end
