from prometheus.pusher import Pusher
from prometheus.collectors import Counter, Gauge
from prometheus.registry import Registry


class incrementCounter(object):
    """docstring for incrementCounter"""

    def __init__(self, counter):
        super(incrementCounter, self).__init__()
        self.counterName = counter
        self.pushgatewayUrl = 'http://pushgateway:9091'
        self.c = Counter(self.counterName, 'description for counter')
        self.p = Pusher('pushgateway', self.pushgatewayUrl)
        self.registry = Registry()
        self.registry.register(self.c)

    def inc(self):
        self.counterValue = None
        #c = counter
        if self.counterName is not None:
            if self.counterValue == None:
                self.c.inc({'type': 'hit'})
            else:
                self.c.add({'type': 'hit'}, self.counterValue)
        else:
            return False

        self.p.add(self.registry)
        return True


class incrementGauge(object):
    """Docstring for incrementGauge"""

    def __init__(self, gauge):
        super(incrementGauge, self).__init__()
        self.gaugeName = gauge
        self.pushgatewayUrl = 'http://pushgateway:9091'

    def inc(self, arg=None):
        self.gaugeValue = arg
        if self.gaugeName is not None:

            p = Pusher('pushgateway', self.pushgatewayUrl)
            registry = Registry()
            c = Gauge(self.gaugeName, 'description for gauge', {})
            registry.register(c)

            if self.gaugeValue == None:
                c.inc({'type': 'hit'})
            else:
                c.add({'type': 'hit'}, self.gaugeValue)
        else:
            return False

        p.add(registry)
        return True
