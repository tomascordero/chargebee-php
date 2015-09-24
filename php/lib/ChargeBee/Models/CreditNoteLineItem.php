<?php

class ChargeBee_CreditNoteLineItem extends ChargeBee_Model
{
  protected $allowed = array('date_from', 'date_to', 'unit_amount', 'quantity', 'is_taxed', 'tax_amount', 'tax_rate', 'discount_amount', 'line_amount', 'description', 'entity_type', 'entity_id');

}

?>