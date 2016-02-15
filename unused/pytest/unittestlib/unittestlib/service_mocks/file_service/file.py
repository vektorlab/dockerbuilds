__author__ = 'Nathan'

from intrustcorelib.structures import *
from intrustmo.entities import *
from tempfile import NamedTemporaryFile
import urllib

class MockFileModule():

    def __init__(self, **kwargs):
        self.__files = []  # List of dictionaries of the form {'file_metadata': .., 'url': .., file_handle: ..}

    def create_file_from_url(self, request):
        file_metadata = EntityFileMetadata(**request.data['file_metadata'])
        url = request.data['url']
        f = NamedTemporaryFile(mode='w', bufsize=1)
        f.write(urllib.urlopen(url).read())
        self.__files.append(dict(
            file_metadata=file_metadata,
            url='file://' + f.name,
            file_handle=f
        ))

        return Response(status_code='success', status_message='File successfully created', data=True)

    def get_file(self, request):
        print "IN GET FILE"
        print self.__files
        for file in self.__files:
            if file['file_metadata']['uuid'] == request.data['uuid']:
                file['file_metadata'].url = file['url']
                return Response(status='success', data=file['file_metadata'])

