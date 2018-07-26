# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

# Sales Analyst test class
class SalesAnalystTest < Minitest::Test

  def setup
    merchant1 = { id: 1, name: 'Bonos', created_at: '2010-12-22', updated_at: '2010-12-24' }
    merchant2 = { id: 2, name: 'General Store', created_at: '2016-04-19', updated_at: '2016-05-02' }
    merchant3 = { id: 5, name: 'Rufus Bazaar', created_at: '2017-02-02', updated_at: '2017-02-06' }
    merchants = [merchant1, merchant2, merchant3]

    item1 = { id: 1, name: 'Pencil', description: 'Use me to write things', unit_price: '1000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 1 }

    item2 = { id: 2, name: 'Pen', description: 'Use me to write permanently', unit_price: '1200', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 2 }
    item3 = { id: 3, name: 'Paper', description: 'Use me to write things on', unit_price: '500', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 2 }

    item4 = { id: 4, name: 'coke', description: 'Use me to write things', unit_price: '100', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item5 = { id: 5, name: 'pepsi', description: 'Use me to write permanently', unit_price: '200', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item6 = { id: 6, name: 'sprite', description: 'Use me to write things on', unit_price: '250', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item7 = { id: 7, name: 'mac', description: 'Use me to write things', unit_price: '1000000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item8 = { id: 8, name: 'pc', description: 'Use me to write permanently', unit_price: '5000000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item9 = { id: 9, name: 'linux', description: 'Use me to write things on', unit_price: '550000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }

    items = [item1, item2, item3, item4, item5,item6, item7, item8, item9]

    invoice1 = { id: 1, customer_id: 2, merchant_id: 1, status: 'shipped', created_at: Time.now, updated_at: Time.now}

    invoice2 = { id: 2, customer_id: 2, merchant_id: 2, status: 'pending', created_at: Time.now, updated_at: Time.now}
    invoice3 = { id: 3, customer_id: 3, merchant_id: 2, status: 'returned', created_at: Time.now, updated_at: Time.now}

    invoice4 = { id: 4, customer_id: 2, merchant_id: 5, status: 'pending', created_at: Time.now, updated_at: Time.now}
    invoice5 = { id: 5, customer_id: 2, merchant_id: 5, status: 'shipped', created_at: Time.now, updated_at: Time.now}
    invoice6 = { id: 6, customer_id: 3, merchant_id: 5, status: 'returned', created_at: Time.now, updated_at: Time.now}
    invoice7 = { id: 7, customer_id: 2, merchant_id: 5, status: 'shipped', created_at: Time.now, updated_at: Time.now}
    invoice8 = { id: 8, customer_id: 2, merchant_id: 5, status: 'pending', created_at: Time.now, updated_at: Time.now}
    invoice9 = { id: 9, customer_id: 3, merchant_id: 5, status: 'returned', created_at: Time.now, updated_at: Time.now}

    invoices = [invoice1, invoice2, invoice3, invoice4, invoice5, invoice6, invoice7, invoice8, invoice9]

    data = { merchants: merchants, items: items, invoices: invoices }
    @se = SalesEngine.new(data)
    @sa = @se.analyst
  end



  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_has_sales_engine
    assert_instance_of SalesEngine, @sa.engine
  end

  def test_it_calculates_average_items_per_merchant
    assert_equal 3, @sa.average_items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_devation
    assert_equal 2.65, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_merchants_with_high_item_count
    assert_equal [@se.merchants.find_by_id(5)], @sa.merchants_with_high_item_count
  end

  def test_it_calculates_average_item_price_for_merchant
    assert_equal 8.5, @sa.average_item_price_for_merchant(2)
    #takes argument of merchant id
  end

  def test_it_calculates_average_average_price_per_merchant
    assert_equal 3645.36, @sa.average_average_price_per_merchant
  end

  def test_it_identifies_golden_items
    assert_equal [@se.items.find_by_id(8)], @sa.golden_items
  end

  def test_it_calculates_average_invoices_per_merchant
    assert_equal 3, @sa.average_invoices_per_merchant
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    assert_equal 2.65, @sa.average_invoices_per_merchant_standard_deviation
  end


end
