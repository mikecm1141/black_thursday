# frozen_string_literal: true

require 'time'

# Transaction class
class Transaction
  attr_reader   :id,
                :invoice_id,
                :created_at
  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(params)
    @id                          = params[:id].to_i
    @invoice_id                  = params[:invoice_id].to_i
    @credit_card_number          = params[:credit_card_number]
    @credit_card_expiration_date = params[:credit_card_expiration_date]
    @result                      = params[:result].to_sym
    @created_at                  = Time.parse(params[:created_at].to_s)
    @updated_at                  = Time.parse(params[:updated_at].to_s)
  end
end
