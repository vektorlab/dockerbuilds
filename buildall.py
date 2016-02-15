#!/usr/bin/env python

import os
import json
import logging
from docker import Client

logging.basicConfig(level=logging.INFO)
log = logging.getLogger(__name__)

image_prefix = 'vektorlab/'

class Dockerfile(object):
    def __init__(self, path):
        self.build_dir = os.path.dirname(path)
        self.image_name = image_prefix + self.build_dir
        with open(path, 'r') as of:
            self.lines = [ l.replace('\n', ' ').replace('\\', '') for \
                           l in of.readlines() if not l.startswith('#') ]
        for l in self.lines:
            if l.startswith('FROM'):
                base = l.split(' ')[1]
                self.base_image, self.base_tag = base.split(':') 
                return

def sort_images(dockerfiles):
    # Topological sort (Cormen/Tarjan algorithm)
    unmarked = dockerfiles[:]
    temporary_marked = set()
    sorted_services = []

    def visit(df):
        if df.image_name in temporary_marked:
            if df.image_name == df.base_image:
                raise Exception('An image cannot be build on itself: %s' % df.image_name)
            else:
                raise Exception('Circular import between %s' % ' and '.join(temporary_marked))
        if df in unmarked:
            temporary_marked.add(df.image_name)
            dependents = [ d for d in dockerfiles if d.base_image == df.image_name ]
            for m in dependents:
                visit(m)
            temporary_marked.remove(df.image_name)
            unmarked.remove(df)
            sorted_services.insert(0, df)

    while unmarked:
        visit(unmarked[-1])

    return sorted_services

if __name__ == '__main__':
    client = Client(base_url=os.getenv('DOCKER_HOST'))
    dockerfiles = []

    log.info("reading dockerfiles...")
    for d in [ l for l in os.listdir('.') if os.path.isdir(l) ]:
        df_path = d + '/Dockerfile'
        if os.path.isfile(df_path):
            dockerfiles.append(Dockerfile(df_path))

    log.info("building %d images..." % len(dockerfiles))
    for df in sort_images(dockerfiles):
        b = client.build(path=df.build_dir, rm=True, stream=True,
                nocache=False, tag=df.image_name + ":latest")
        for line in b:
            log.info(line.decode("utf-8"))
    log.info("done!")
