require 'active_interaction'


class Api::Store::Index::SortStoreInteractor < ActiveInteraction::Base
  string :asc_or_desc, default: nil
  integer :greater_than, default: nil
  integer :less_than, default: nil

  validates :greater_than, :less_than, numericality: { only_integer: true, allow_nil: true, greater_than_or_equal_to: 0 }
  validates :asc_or_desc, inclusion: { in: %w[asc desc], allow_nil: true, message: I18n.t("error.messages.not_valid_sorting")}

  def execute
    return Store.less_and_greater_than_products(less_than, greater_than) if greater_than && less_than
    return Store.greater_than_products(greater_than) if greater_than
    return Store.less_than_products(less_than) if less_than
    return Store.all.order(asc_or_desc) if asc_or_desc

    errors.add(:params, I18n.t("error.messages.none_filters_worked"))
  end
end