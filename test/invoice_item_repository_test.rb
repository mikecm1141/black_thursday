# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'
require 'bigdecimal'
require 'time'

require './lib/invoice_item_repository'

# InvoiceItemRepository test class
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @iir = InvoiceItemRepository.new
    @invoice_item1 = @iir.create(
      id:           1001,
      item_id:      101,
      invoice_id:   11,
      quantity:     1,
      unit_price:   BigDecimal(10.99, 4),
      created_at:   Time.now,
      updated_at:   Time.now
    )
    @invoice_item2 = @iir.create(
      id:           1002,
      item_id:      102,
      invoice_id:   12,
      quantity:     2,
      unit_price:   BigDecimal(20.99, 4),
      created_at:   Time.now,
      updated_at:   Time.now
    )
    @invoice_item3 = @iir.create(
      id:           1003,
      item_id:      103,
      invoice_id:   13,
      quantity:     3,
      unit_price:   BigDecimal(30.99, 4),
      created_at:   Time.now,
      updated_at:   Time.now
    )
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_can_create_invoice_items
    assert_instance_of InvoiceItem, @invoice_item1
  end

  def test_it_returns_array_of_all_invoice_item_instances
    expected = [@invoice_item1, @invoice_item2, @invoice_item3]
    assert_equal expected, @iir.all
  end

  def test_it_can_find_by_id
    assert_equal @invoice_item1, @iir.find_by_id(1001)
  end

  def test_it_can_find_all_by_item_id
    assert_equal [@invoice_item2], @iir.find_all_by_item_id(102)
    assert_equal [], @iir.find_all_by_item_id(107)
  end

end