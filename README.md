# Prometheus environment

This repo contains a prometheus environment compsed by:
* [Prometheus server](https://github.com/prometheus/prometheus)
* [Push Gateway](https://github.com/prometheus/pushgateway) (which after the VelocityConf NYC will probably stop the use of that, for the obvious reasons pointed out by [Björn](https://github.com/beorn7))
* Incrementer (python app)

## Python app details

The app is (poorly) written in Python, uses prometheus [python3 library](https://github.com/slok/prometheus-python) but it serves the purpose it set, which is interact with Prometheus, interacting in two ways:

* Generating a random value for a gauge called "newgauge"
* Increment a counter called "newcounter"

## Dependencies

This repo highly depends on Docker, so wherever you run this environment, you'll need to have the [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/)

## Usage

### Start it!

```
make dev
```

### Stop and remove containers & incrementer image

```
make nodev
```

### Logs

```
make logs
```

### Run a gauge incrementer

Runs a curl agains the incrementer API and sets the gauge to a random value 0 to 10 every 1.2s

```
make gauge
```

### Run a counter incrementer

Runs a curl agains the incrementer API and increments the counter

```
make counter
```

## TODO

* Docker-machine host auto-discovery (really not that difficult)
* Counter name injection via API call (either GET or POST)
* Alerts
* Summary
* Historygrams
* Readme URLS for interaction (API and Prometheus)
