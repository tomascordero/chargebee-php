module ChargeBee
  class CreditNoteEstimate < Model

    class LineItem < Model
      attr_accessor :date_from, :date_to, :unit_amount, :quantity, :tax_amount, :tax_rate, :line_amount, :discount_amount, :description, :entity_type, :entity_id
    end

    class Discount < Model
      attr_accessor :amount, :description, :entity_type, :entity_id
    end

    class Tax < Model
      attr_accessor :amount, :description
    end

  attr_accessor :reference_invoice_id, :type, :sub_total, :total, :credits_allocated, :remaining_credits,
  :line_items, :discounts, :taxes

  # OPERATIONS
  #-----------

  end # ~CreditNoteEstimate
end # ~ChargeBee