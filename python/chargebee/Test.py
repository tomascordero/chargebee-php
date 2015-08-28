import os,sys

sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))

import chargebee
from chargebee.environment import Environment
from chargebee.main import ChargeBee
from chargebee.util import serialize
from chargebee import APIError,PaymentError,InvalidRequestError,OperationFailedError, compat
from chargebee.result import Result


def test(file):
    fileName = '../../files/'+file+'.json'
    f = open(fileName)
    respJson = f.read()
    f.close()
    resp_json = compat.json.loads(respJson)
    
    res = Result(resp_json)    
    r = res.estimates
    
    print(r[0].invoice_estimate.line_items[0])
    print(type(r[0].invoice_estimate.line_items[0]))



test('listEst');
