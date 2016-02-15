__author__ = 'Nathan'

from intrustcorelib.structures import *

class MockDatabaseModule():

    """ This module should behave identically to the real DatabaseModule in the database_service """

    def __init__(self):
        self.__data = []

    @property
    def data(self):
        return self.__data

    def __return(self, results):
        if len(results) == 0:
            return Response(data=None)
        if len(results) == 1:
            return Response(data=results[0])
        if len(results) > 1:
            return Response(data=results)

    def create_resource_data(self, request):
        resource = request.data['resource']
        properties = request.data['properties']
        if resource.get('identifier') is None or resource.get('identifier') == '':
            resource['identifier'] = properties.get('uuid')
        self.__data.append({
            'resource': resource,
            'properties': properties
        })
        return Response(data=resource)

    def update_resource_data(self, request):
        resource = request['data']['resource']
        properties = request['data']['properties']
        if not 'identifier' in resource:
            resource['identifier'] = properties.get('uuid')

        for data in self.__data:
            if data['resource']['identifier'] == resource['identifier']:
                self.__data.remove(data)
                self.__data.append({
                    'resource': resource,
                    'properties': properties
                })
                print "********************************************************************************************************"
                print self.__data
                return Response(status_message="Successfully updated resource", data=resource)

    def get_resource_by_property(self, request):
        resource = request['data']['resource']
        query = resource['query']

        results = []
        for data in self.__data:
            results.append(data['properties'])  # Add by default
            for key in query:
                if not data['properties'].get(key) == query[key]:
                    results.pop()  # Remove if we find any mismatch
                    break
        return self.__return(results)

    def get_resource_data(self, request):
        resource = request['data']['resource']
        if isinstance(resource['identifier'], basestring):
            resource['identifier'] = [resource['identifier']]

        results = []
        for data in self.__data:
            print "THE IDENTIFIER IS"
            print data
            print resource
            if data['resource']['identifier'] in resource['identifier'] and data['resource']['name'] == data['resource']['name']:
                results.append(data['properties'])
        return self.__return(results)

    def expire_resource(self, request):
        assert 'resource' in request.data
        resource = Resource(**request.data['resource'])
        for item in self.__data:
            if item['resource']['identifier'] == resource['identifier']:
                self.__data.remove(item)
        return Response(data=None)

