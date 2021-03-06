# frozen_string_literal: true

require 'csv'
require_relative './invoice_repository'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './transaction_repository'
require_relative './customer_repository'
require_relative './invoice_item_repository'
require_relative './sales_analyst'

class SalesEngine
  def self.from_csv(filepaths)
    csv_data = {}
    filepaths.each do |repo, filepath|
      csv_data[repo] = CSV.open(filepath, headers: true, header_converters: :symbol)
    end
    new(csv_data)
  end

  def initialize(data)
    @data = data
  end

  def merchants
    @merchants ||= MerchantRepository.new.tap do |merchant_repo|
      merchant_repo.populate(@data[:merchants])
    end
  end

  def items
    @items ||= ItemRepository.new.tap do |item_repo|
      item_repo.populate(@data[:items])
    end
  end

  def invoices
    @invoices ||= InvoiceRepository.new.tap do |invoice_repo|
      invoice_repo.populate(@data[:invoices])
    end
  end

  def transactions
    @transactions ||= TransactionRepository.new.tap do |transaction_repo|
      transaction_repo.populate(@data[:transactions])
    end
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new.tap do |invoice_item_repo|
      invoice_item_repo.populate(@data[:invoice_items])
    end
  end

  def customers
    @customers ||= CustomerRepository.new.tap do |customer_repo|
      customer_repo.populate(@data[:customers])
    end
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
