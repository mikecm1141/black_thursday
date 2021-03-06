# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

# Sales Analyst test class
class SalesAnalystTest < Minitest::Test

  def setup
    merchant1 = { id: 1, name: 'Bonos', created_at: '2010-12-22', updated_at: '2010-12-24' }
    merchant2 = { id: 2, name: 'General Store', created_at: '2016-04-19', updated_at: '2016-05-02' }
    merchant3 = { id: 5, name: 'Rufus Bazaar', created_at: '2017-02-02', updated_at: '2017-02-06' }
    merchant4 = { id: 4, name: 'Fluffy Land', created_at: '2018-04-02', updated_at: '2018-06-06' }
    merchant5 = { id: 3, name: 'General Depot', created_at: '2016-04-19', updated_at: '2016-05-02' }
    merchant6 = { id: 6, name: 'Kmart', created_at: '2017-02-02', updated_at: '2017-02-06' }
    merchant7 = { id: 7, name: 'GameStop', created_at: '2018-04-02', updated_at: '2018-06-06' }

    merchants = [merchant1, merchant2, merchant3, merchant4, merchant5, merchant6, merchant7]

    item1 = { id: 1, name: 'Pencil', description: 'Use me to write things', unit_price: '1000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 1 }

    item2 = { id: 2, name: 'Pen', description: 'Use me to write permanently', unit_price: '1200', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 2 }
    item3 = { id: 3, name: 'Paper', description: 'Use me to write things on', unit_price: '500', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 2 }

    item4 = { id: 4, name: 'coke', description: 'Use me to write things', unit_price: '100', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item5 = { id: 5, name: 'pepsi', description: 'Use me to write permanently', unit_price: '200', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item6 = { id: 6, name: 'sprite', description: 'Use me to write things on', unit_price: '250', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item7 = { id: 7, name: 'mac', description: 'Use me to write things', unit_price: '1000000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item8 = { id: 8, name: 'pc', description: 'Use me to write permanently', unit_price: '5000000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }
    item9 = { id: 9, name: 'linux', description: 'Use me to write things on', unit_price: '550000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 5 }

    item10 = { id: 10, name: 'fluffy bear', description: 'Use me to hug', unit_price: '4000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 6 }

    item11 = { id: 11, name: 'fluffy moose', description: 'Use me to hug', unit_price: '4000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 7 }

    item12 = { id: 12, name: 'fluffy swan', description: 'Use me to hug', unit_price: '4000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 3 }

    item13 = { id: 13, name: 'fluffy dog', description: 'Use me to hug', unit_price: '4000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 4 }


    items = [item1, item2, item3, item4, item5,item6, item7, item8, item9, item10, item11, item12, item13]

    invoice1 = { id: 1, customer_id: 2, merchant_id: 1, status: 'shipped', created_at: "2017-10-01", updated_at: Time.now}

    invoice19 = { id: 19, customer_id: 2, merchant_id: 2, status: 'shipped', created_at: "2017-10-01", updated_at: Time.now}

    invoice2 = { id: 2, customer_id: 2, merchant_id: 3, status: 'returned', created_at: "2017-10-02", updated_at: Time.now}

    invoice12 = { id: 12, customer_id: 2, merchant_id: 4, status: 'shipped', created_at: "2017-10-02", updated_at: Time.now}
    invoice16 = { id: 16, customer_id: 2, merchant_id: 4, status: 'shipped', created_at: "2017-10-02", updated_at: Time.now}
    invoice17 = { id: 17, customer_id: 2, merchant_id: 4, status: 'returned', created_at: "2017-10-03", updated_at: Time.now}

    invoice18 = { id: 18, customer_id: 2, merchant_id: 5, status: 'pending', created_at: "2017-10-03", updated_at: Time.now}
    invoice3 = { id: 3, customer_id: 3, merchant_id: 5, status: 'returned', created_at: "2017-10-04", updated_at: Time.now}
    invoice4 = { id: 4, customer_id: 2, merchant_id: 5, status: 'pending', created_at: "2017-10-04", updated_at: Time.now}

    invoice5 = { id: 5, customer_id: 2, merchant_id: 6, status: 'pending', created_at: "2017-10-05", updated_at: Time.now}
    invoice6 = { id: 6, customer_id: 3, merchant_id: 6, status: 'returned', created_at: "2017-10-05", updated_at: Time.now}
    invoice7 = { id: 7, customer_id: 2, merchant_id: 6, status: 'shipped', created_at: "2017-10-06", updated_at: Time.now}

    invoice8 = { id: 8, customer_id: 2, merchant_id: 7, status: 'shipped', created_at: "2017-10-06", updated_at: Time.now}
    invoice9 = { id: 9, customer_id: 3, merchant_id: 7, status: 'returned', created_at: "2017-10-06", updated_at: Time.now}
    invoice10 = { id: 10, customer_id: 2, merchant_id: 7, status: 'shipped', created_at: "2017-10-06", updated_at: Time.now}
    invoice11 = { id: 11, customer_id: 3, merchant_id: 7, status: 'returned', created_at: "2017-10-07", updated_at: Time.now}
    invoice13 = { id: 13, customer_id: 3, merchant_id: 7, status: 'returned', created_at: "2017-10-07", updated_at: Time.now}
    invoice14 = { id: 14, customer_id: 3, merchant_id: 7, status: 'returned', created_at: "2017-10-07", updated_at: Time.now}
    invoice15 = { id: 15, customer_id: 3, merchant_id: 7, status: 'returned', created_at: "2017-10-07", updated_at: Time.now}


    invoices = [invoice1, invoice2, invoice3, invoice4, invoice5, invoice6, invoice7, invoice8, invoice9, invoice10, invoice11, invoice12, invoice13, invoice14, invoice15, invoice16, invoice17, invoice18, invoice19]

    invoice_item1 = { id: 1, item_id: 12, invoice_id: 12, quantity: 2, unit_price: '4000', created_at: Time.now, updated_at: Time.now }
    invoice_item2 = { id: 2, item_id: 13, invoice_id: 12, quantity: 1, unit_price: '4000', created_at: Time.now, updated_at: Time.now }
    invoice_item3 = { id: 3, item_id: 6, invoice_id: 12, quantity: 1, unit_price: '250', created_at: Time.now, updated_at: Time.now }
    invoice_items = [invoice_item1, invoice_item2, invoice_item3]

    transaction1 = { id: 1, invoice_id: 1, credit_card_number: '4242424242424242', credit_card_expiration_date: '0120', result: :success, created_at: Time.now, updated_at: Time.now }
    transaction2 = { id: 2, invoice_id: 2, credit_card_number: '4274424242424242', credit_card_expiration_date: '0121', result: :success, created_at: Time.now, updated_at: Time.now }
    transaction3 = { id: 3, invoice_id: 3, credit_card_number: '4242424742424242', credit_card_expiration_date: '0128', result: :success, created_at: Time.now, updated_at: Time.now }
    transaction4 = { id: 4, invoice_id: 4, credit_card_number: '4242424242724242', credit_card_expiration_date: '0712', result: :failed, created_at: Time.now, updated_at: Time.now }
    transaction5 = { id: 5, invoice_id: 5, credit_card_number: '4242427242424242', credit_card_expiration_date: '0813', result: :failed, created_at: Time.now, updated_at: Time.now }
    transaction6 = { id: 6, invoice_id: 12, credit_card_number: '0000000000000000', credit_card_expiration_date: '0120', result: :success, created_at: Time.now, updated_at: Time.now }
    transactions = [transaction1, transaction2, transaction3, transaction4, transaction5, transaction6]

    data = { merchants: merchants, items: items, invoices: invoices, transactions: transactions, invoice_items: invoice_items }
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
    assert_equal 1.86, @sa.average_items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation
    assert_equal 1.86, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_merchants_with_high_item_count
    assert_equal [@se.merchants.find_by_id(5)], @sa.merchants_with_high_item_count
  end

  def test_it_calculates_average_item_price_for_merchant
    assert_equal 8.5, @sa.average_item_price_for_merchant(2)
  end

  def test_it_calculates_average_average_price_per_merchant
    assert_equal 1585.15, @sa.average_average_price_per_merchant
  end

  def test_it_identifies_golden_items
    assert_equal [@se.items.find_by_id(8)], @sa.golden_items
  end

  def test_it_calculates_average_invoices_per_merchant
    assert_equal 2.71, @sa.average_invoices_per_merchant
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    assert_equal 2.14, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_top_merchants_by_invoice_count
    assert_equal [@se.merchants.find_by_id(7)], @sa.top_merchants_by_invoice_count
  end

  def test_it_returns_bottom_merchants_by_invoice_count
    assert_empty @sa.bottom_merchants_by_invoice_count
  end

  def test_it_calculates_top_days_by_invoice_count
    assert_equal ["Friday", "Saturday"], @sa.top_days_by_invoice_count
  end

  def test_it_calculates_percent_status_of_invoices
    assert_equal 15.79, @sa.invoice_status(:pending)
    assert_equal 36.84, @sa.invoice_status(:shipped)
    assert_equal 47.37, @sa.invoice_status(:returned)
  end

  def test_it_returns_whether_invoice_paid_in_full
    assert @sa.invoice_paid_in_full?(1)
    refute @sa.invoice_paid_in_full?(4)
  end

  def test_it_returns_invoice_total_in_dollars
    assert_equal 122.5, @sa.invoice_total(12)
  end

  def test_it_returns_merchants_with_pending_invoices
    expected = [@se.merchants.find_by_id(2), @se.merchants.find_by_id(5), @se.merchants.find_by_id(4), @se.merchants.find_by_id(6), @se.merchants.find_by_id(7)]
    assert_equal expected, @sa.merchants_with_pending_invoices
  end

  def test_it_returns_total_revenue_by_given_date
    date = Time.parse('2017-10-02')
    assert_equal 122.5, @sa.total_revenue_by_date(date)
  end

  def test_it_returns_merchant_revenue_total
    assert_equal 122.5, @sa.revenue_by_merchant(4)
  end

  def test_it_returns_top_revenue_earners
    expected = [@se.merchants.find_by_id(4)]
    assert_equal expected, @sa.top_revenue_earners(1)
  end

  def test_it_returns_merchants_with_one_item_offered
    expected = [@se.merchants.find_by_id(1), @se.merchants.find_by_id(4), @se.merchants.find_by_id(3), @se.merchants.find_by_id(6), @se.merchants.find_by_id(7)]
    assert_equal expected, @sa.merchants_with_only_one_item
  end

  def test_it_returns_merchants_with_only_one_item_month
    assert_equal [@se.merchants.find_by_id(6)], @sa.merchants_with_only_one_item_registered_in_month('February')
  end

  def test_it_returns_most_sold_item_for_merchant
    assert_equal [@se.items.find_by_id(12)], @sa.most_sold_item_for_merchant(4)
  end

  def test_it_returns_best_item_for_a_merchant
    assert_equal @se.items.find_by_id(12), @sa.best_item_for_merchant(4)
  end
end
