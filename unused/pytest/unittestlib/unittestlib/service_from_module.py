__author__ = 'Nathan'
import inspect
from intrustcorelib.structures import *

class ServiceFromModule():

    """ This class creates a wrapper around a an object so that it can 'act like' a service. Example:
        company_service = ServiceFromModule(module=CompanyService())
        Observe that CompanyService() is not instantiated using Service('company'), but with this wrapper,
        we can emulate all of the RPC behavior associated with this module.
    """

    def __init__(self, module):
        self.__module = module
        self.__method_name = None
        assert isinstance(module, object), 'Must pass a module instance'

    def execute(self, **kwargs):
        print str(kwargs)
        print "DONE"
        assert getattr(self.__module, self.__method_name) is not None, 'method does not exist'
        result = getattr(self.__module, self.__method_name)(request=Request(data=kwargs))
        if result.get('status_code') is None:
            result['status_code'] = 'success'
        if result.get('status_message') is None:
            result['status_message'] = ''
        print "**** ServiceFromModule METHOD " + self.__method_name + " COMPLETE. RESPONSE:"
        print result
        return result

    def __getattr__(self, name):
        if hasattr(self.__module, name) and inspect.ismethod(getattr(self.__module, name)):
            self.__method_name = name
            return self.execute
        else:
            return getattr(self.__module, name)

