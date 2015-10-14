#!/bin/sh

#pip install -r /app/requirements.txt
pip3 install prometheus
pip3 install flask-restful

cd /app/app/ && python3 bootstrap.py
