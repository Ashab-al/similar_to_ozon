require 'active_interaction'


class Api::Store::Index::SortStoreInteractor < ActiveInteraction::Base
  integer :greater_than, default: nil
  integer :less_than, default: nil
  string :asc_or_desc, default: nil

  validates :greater_than, numericality: { only_integer: true, allow_nil: true, greater_than_or_equal_to: 0 }
  validates :less_than, numericality: { only_integer: true, allow_nil: true, greater_than_or_equal_to: 0 }
  validates :asc_or_desc, inclusion: { in: %w[asc desc], allow_nil: true, message: "%{value} is not a valid sorting order" }

  def execute(greater_than: nil, less_than: nil, asc_or_desc: nil)
    return errors.add(:params, I18n.t("not_validated_params")) if greater_than.nil? && less_than.nil? && asc_or_desc.nil?

    if greater_than
      return Store.greater_than_products(greater_than)
    end

    if less_than
      return Store.less_than_products(less_than)
    end

    return Store.all.order(asc_or_desc) if asc_or_desc

    errors.add(:params, 'none of the filters have been activated')
  end
end