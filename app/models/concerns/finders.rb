module Finders
  extend ActiveSupport::Concern

  module ClassMethods
    def find_by_attribute(attribute, attribute_value)
      if attribute_value.to_s == attribute_value.to_i.to_s
        where(attribute => attribute_value).first
      else
        where("#{attribute} ilike ?",
              "%#{attribute_value}%").first
      end
    end

    def find_all_by_attribute(attribute, attribute_value)
      if attribute_value.to_s == attribute_value.to_i.to_s
        where(attribute => attribute_value)
      else
        where("#{attribute} ilike ?",
              "%#{attribute_value}%")
      end

    end
  end
end
