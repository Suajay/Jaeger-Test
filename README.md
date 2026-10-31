# Jaeger-Test

Distributed tracing observability exercise using Jaeger and HotROD.

## What this is

A self-contained stack for practicing distributed trace analysis.  
Two services run as Docker containers:

- **Jaeger** — collects and displays traces (`http://localhost:16686`)
- **HotROD** — a demo ride-hailing app that generates traces (`http://localhost:8090`)

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

## Setup (Mac)

```bash
# 1. Clone the repo
git clone https://github.com/Suajay/Jaeger-Test.git
cd Jaeger-Test

# 2. Start the stack
docker compose up

# 3. Wait ~10 seconds, then open Jaeger UI in Safari
open http://localhost:16686

# 4. Open HotROD in Safari
open http://localhost:8090
```

## Generate traces

Either click the buttons in the HotROD UI at `http://localhost:8090`,  
or run the script:

```bash
chmod +x generate-traces.sh
./generate-traces.sh
```

Then in Jaeger:
- Service = **frontend**
- Operation = **GET /dispatch**
- Click **Find Traces**

## Task

1. Open two comparable `/dispatch` traces in Jaeger via Safari
2. Compare the end-to-end durations and span-level timings
3. Identify which service span best explains the latency difference
4. Document findings in Google Sheets and export as `latency-findings.pdf`

## Stop the stack

```bash
docker compose down
```
