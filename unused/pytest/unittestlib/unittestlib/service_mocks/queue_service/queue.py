__author__ = 'Nathan'
from unittestlib.service_from_module import ServiceFromModule
from collections import deque
from intrustcorelib.structures import *

class MockQueueModule:

    """ This module is supposed to have identical behavior to the real Queue module in the queueing service using
    """

    def __init__(self, **kwargs):
        self.queues = {}

    def __get_queue_by_topic(self, topic):
        if self.queues.get(topic) is None:
            self.queues[topic] = deque()
        return self.queues.get(topic)

    def queue(self, request):
        topic=request.data['topic']
        payload=request.data['payload']
        """ Add one item to queue specified by topic """
        queue = self.__get_queue_by_topic(topic)
        queue.appendleft(payload)
        return Response(status_code='success', data=None)

    def queue_many(self, request):
        topic=request.data['topic']
        payloads=request.data['payloads']
        """ Add many items to queue specified by topic """
        queue = self.__get_queue_by_topic(topic)
        for payload in payloads:
            queue.appendleft(payload)
        return Response(status_code='success', data=None)

    def dequeue(self, request):
        topic=request.data['topic']
        """ Get a single item from the queue specified by topic """
        queue = self.__get_queue_by_topic(topic)
        if len(queue) > 0:
            result = queue.pop()
        else:
            result = None
        return Response(status_code='success', data=result)

    def dequeue_many(self, request):
        topic=request.data['topic']
        count=request.data['count']
        queue = self.__get_queue_by_topic(topic)
        results = list()
        while (count > 0) and (len(queue) > 0):
            results.append(queue.pop())
            count -= 1
        return Response(status_code='success', data=results)

    def queue_count(self, request):
        topic=request.data['topic']
        queue = self.__get_queue_by_topic(topic)
        return Response(status_code='success', data=len(queue))
