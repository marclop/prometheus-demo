from flask import Flask
from flask_restful import Resource, Api
from useCases import incrementCounter, incrementGauge
import random

app = Flask(__name__)
api = Api(app)

# Define the counter globally
counter = incrementCounter('newcounter')


class getCounter(Resource):
    """docstring for getIncrement"""

    def get(self):
        # counter = incrementCounter('newcounter')
        result = counter.inc()
        if result:
            return {"ok": 200}, 201
        else:
            return {"ERROR": 500}, 500


class getGauge(Resource):
    """docstring for getIncrement"""

    def get(self):
        gauge = incrementGauge('newgauge')
        result = gauge.inc(random.random() * 10)
        if result:
            return {"ok": 200}, 201
        else:
            return {"ERROR": 500}, 500


api.add_resource(getCounter, '/counter')
api.add_resource(getGauge, '/gauge')

if __name__ == '__main__':
    app.debug = True
    app.run(host='0.0.0.0', port=5000, threaded=True)
