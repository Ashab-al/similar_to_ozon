require 'active_interaction'


class Api::Store::Index::SortStoreInteractor < ActiveInteraction::Base
  string :asc_or_desc, default: nil
  integer :greater_than, default: 0
  integer :less_than, default: 0

  validate :range_check
  validates :asc_or_desc, inclusion: { in: %w['ASC' 'DESC'], allow_nil: true, message: I18n.t("error.messages.not_valid_sorting")}
  validate :comparison_gthen_lthen

  def execute
    return Store.less_and_greater_than_products(less_than, greater_than) if greater_than && less_than
    return Store.greater_than_products(greater_than) if greater_than
    return Store.less_than_products(less_than) if less_than
    return Store.with_product_count.order('products_count ?', asc_or_desc) if asc_or_desc

    errors.add(:params, I18n.t("error.messages.none_filters_worked"))
  end


  private

  def range_check
    if greater_than 
      errors.add(:greater_than, :invalid) unless greater_than&.is_a?(Integer) ||  greater_than <= 0
    end

    if less_than
      errors.add(:less_than, :invalid) unless greater_than&.is_a?(Integer) || greater_than <= 0 || greater_than > less_than
    end
  end

  def comparison_gthen_lthen
    errors.add(:cannot_be_more_gthen, I18n.t("error.messages.cannot_be_more_gthen")) if greater_than < less_than
  end
end