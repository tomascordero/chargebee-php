require '../chargebee'
require 'json'
require 'pp'
def test(fileName)
  filePath = "../../../files/"+fileName+".json"
  f = File.open(filePath, "r")
  respJson = f.read
  f.close
  resp = JSON.parse(respJson)
  resp = ChargeBee::Util.symbolize_keys(resp)
  res =  ChargeBee::Result.new(resp)
  puts res.estimate.inspect
  #puts res.estimate.invoice_estimate.line_items[1].inspect
  # puts res.estimate.credit_note_estimates[0].line_items[1].inspect
end
  

begin
  test('test');
end