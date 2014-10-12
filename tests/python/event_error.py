"""
Contains sample codes & functions to work with our php library.
"""
import os,sys
import traceback

"""
Require the chargebee-python library from the code base that is relative to the chargebee-app directory
"""
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))

"""
Import the necessary chargebee classes.
"""
import chargebee
from chargebee.environment import Environment
from chargebee.main import ChargeBee
from chargebee.util import serialize
import httplib
import socket


chargebee.Event.deserialize("");
