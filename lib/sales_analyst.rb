# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'


class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    merchant_count = @engine.merchants.all.size.to_f
    item_count = @engine.items.all.size.to_f
    BigDecimal((item_count / merchant_count), 3)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    all_merchants = @engine.merchants.all

    items_per_merchant = []
    all_merchants.each do |merchant|
      items_per_merchant << @engine.items.find_all_by_merchant_id(merchant.id).size
    end
    equation = items_per_merchant.inject(0) do |sum, number_items|
      sum + (number_items - average)**2
    end
    ((Math.sqrt(equation / (items_per_merchant.size - 1)).round(2))).to_d
  end

  def merchants_with_high_item_count
    std = average_items_per_merchant + average_items_per_merchant_standard_deviation
    all_merchants = @engine.merchants.all

    all_merchants.find_all do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).size > std
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    total_items = @engine.items.find_all_by_merchant_id(merchant_id).size
    all_items = @engine.items.find_all_by_merchant_id(merchant_id)
    sum = all_items.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average_price = sum / total_items
    BigDecimal(average_price, 5)
  end

  def average_average_price_per_merchant
    merchants = @engine.merchants.all
    average_price_array = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average_price_sum = average_price_array.inject(0) do |sum, price|
      sum + price
    end
    total_average = (average_price_sum / average_price_array.size).round(2)
    BigDecimal(total_average, 5)
  end

  def golden_items
    #run above method to get the average item price for all merchants
    #see above
  end
end
