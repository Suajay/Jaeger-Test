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

---

## 📋 Full Step-by-Step Guide (for complete beginners)

> New to terminals and Docker? Start here. This guide walks you through every single step with plain English explanations.

---

### Part 0 — Background (read this first, it takes 2 minutes)

**What is a trace?**  
When the HotROD app handles a ride request, it automatically records a detailed timeline of every step it took — which service ran, how long each step took, which step triggered the next. That recorded timeline is called a **trace**. Think of it like a receipt that shows every item and how long it took to process.

**What is a span?**  
A trace is made of smaller pieces called **spans** — one per step. For example: "look up the customer" is one span, "ask the database" is another span underneath it. Each span has a name, a start time, and a duration (how long it took).

**What are you doing in this task?**  
Two ride requests were run. One finished slower than the other. Your job is to look at both timelines, find which step took the extra time, write up what you found in a spreadsheet, and save it as a PDF.

**Key words to know:**
- **ms** = milliseconds. 1000 ms = 1 second. Spans are measured in ms.
- **Service** = one of the programs doing part of the work (customer, driver, route).
- **End-to-end** = the total time for the whole request, start to finish.
- **Parent/child** = which step triggered the next step.

---

### Part 1 — Install Docker Desktop on your Mac

Docker Desktop is a free program that runs the Jaeger and HotROD apps in the background. You install it once and it handles everything.

1. Open **Safari** on your Mac.
2. Go to: `https://www.docker.com/products/docker-desktop/`
3. Click **Download for Mac** — choose **Apple Silicon** if your Mac is from 2020 or newer (M1/M2/M3 chip), or **Intel** if it's older.
4. Open the downloaded `.dmg` file. Drag the Docker icon into your Applications folder.
5. Open Docker Desktop from your Applications folder. The first time it opens it will ask for your Mac password — enter it.
6. Wait until you see a green light or the words **"Docker Desktop is running"** in the top menu bar. That means it's ready.

> **How to check:** click the little whale icon in your Mac's top menu bar. If it says "Docker Desktop is running" — you're good.

---

### Part 2 — Install Git (if you don't have it)

Git lets you download the project files from GitHub.

1. Open **Terminal** on your Mac. (Press `Cmd + Space`, type `Terminal`, press Enter.)
2. Type this and press Enter:
   ```
   git --version
   ```
3. If you see a version number (like `git version 2.x.x`) — Git is already installed, skip to Part 3.
4. If a pop-up appears saying **"The Xcode Command Line Tools are required"** — click **Install** and wait for it to finish. That installs Git automatically.

---

### Part 3 — Download the project to your Mac

1. In Terminal, type this exactly and press Enter:
   ```bash
   git clone https://github.com/Suajay/Jaeger-Test.git
   ```
   You'll see some lines appear — that's the files downloading. Wait for it to finish.

2. Now move into the project folder by typing:
   ```bash
   cd Jaeger-Test
   ```
   > You won't see a confirmation — that's normal. Your Terminal prompt will now show `Jaeger-Test` at the end, which means you're inside the folder.

---

### Part 4 — Start the Jaeger + HotROD stack

1. Make sure Docker Desktop is running (whale icon in the menu bar, green light).
2. In Terminal (still inside the `Jaeger-Test` folder), type:
   ```bash
   docker compose up
   ```
3. Press Enter. You'll see a lot of text scrolling — Docker is downloading and starting the two apps. This takes about 1–2 minutes the first time (it's downloading the images).
4. When the scrolling slows down and you see lines containing words like `"Starting HotROD"` or `"Jaeger"` — the stack is ready.
5. **Leave this Terminal window open.** The apps run as long as this window is open. Don't close it.

---

### Part 5 — Open the apps in Safari

Open a **new Safari window** (don't close Terminal).

1. In Safari's address bar type `http://localhost:16686` and press Enter.
   - You should see the **Jaeger UI** — a dark header bar with a search panel on the left.
   - This is where all the traces (timelines) are stored and viewed.

2. Open a **new Safari tab** (`Cmd + T`), type `http://localhost:8090` and press Enter.
   - You should see the **HotROD app** — a simple page with customer names and a map.
   - This is the demo app that generates the traces.

> **If either page doesn't load:** go back to Terminal and wait another 30 seconds — the apps may still be starting. Then try again.

---

### Part 6 — Generate two traces (the ride requests)

You need to fire off some ride requests so Jaeger has traces to show you.

**Option A — Use the HotROD website (easiest):**
1. In Safari, on the HotROD page (`http://localhost:8090`), you'll see customer names with a **Request** button next to each one.
2. Click **Request** next to any customer. Wait 1–2 seconds. Click **Request** next to a different customer. Repeat 4–6 times total, mixing different customers.

**Option B — Use the script:**
1. Open a **new Terminal tab** (`Cmd + T` in Terminal).
2. Type:
   ```bash
   cd Jaeger-Test
   chmod +x generate-traces.sh
   ./generate-traces.sh
   ```
3. You'll see lines like `Dispatching customer=392...` — that means it's generating traces. Wait for it to finish.

---

### Part 7 — Open the traces in Jaeger (Step 1 of the task)

1. Go back to Safari, open the Jaeger tab (`http://localhost:16686`).
2. On the left panel, find the **Service** dropdown. Click it and select **frontend**.
3. Below that, find the **Operation** dropdown. Click it and select **GET /dispatch**.
4. Leave everything else as-is. Click the blue **Find Traces** button.
5. You'll see a list of traces appear — each one is a ride request. Each shows a trace ID and a duration (in ms).
6. Look at the durations. Find **two traces** where one is noticeably slower than the other (e.g., one is ~700ms and another is ~600ms or less).
7. Click the **slower one** first. It opens a detailed view — this is your **Trace B (slower)**.
8. Note the total duration shown at the top. Write it down.
9. Go back (click the browser back button), click the **faster one**. This is your **Trace C (faster)**.
10. Note its total duration. Write it down.
11. Subtract: slower minus faster = your **end-to-end difference**.

---

### Part 8 — Map the request path and compare spans (Steps 2 & 3)

1. Open the **slower trace**. You'll see a waterfall chart — rows of colored bars. Each row is one span (one step).
2. The top row is **GET /dispatch** — that's the whole request. Everything else is indented under it.
3. Look for these three main groups:
   - A row containing **SQL SELECT** (under GET /customer) — this is the database lookup
   - A row called **driver.DriverService/FindNearest** — this finds drivers
   - Several rows called **GET /route** — these find routes
4. **Click the SQL SELECT row.** A detail panel opens showing its duration in microseconds (µs). Divide by 1000 to get milliseconds.
5. Write down: `SQL SELECT duration in Trace B (slower) = ___ ms`
6. Now open the **faster trace** and do the same — click SQL SELECT, write down its duration.
7. Write down: `SQL SELECT duration in Trace C (faster) = ___ ms`
8. Subtract: that difference is your key finding.
9. Also note: SQL SELECT has **no rows indented under it** — it's a leaf step, meaning the time was spent purely in the database, not passed on to something else.

> **The finding you're looking for:** the SQL SELECT in the slower trace should be noticeably longer. That's the span that best explains the latency difference.

---

### Part 9 — Cross-check the timeline (Step 4)

1. In the slower trace's waterfall view, look at the **horizontal positions** of the three main groups (customer, driver, route).
2. Notice they run **one after another** — customer finishes, then driver starts, then route starts. They don't overlap.
3. If customer takes longer in the slow trace, driver starts later, and route starts even later — the whole chain shifts. That's your proof the customer SQL SELECT is the **origin** of the slowdown, not a downstream symptom.
4. Write down the start and end time of each group from both traces (Jaeger shows these in the detail panel when you click a span).

---

### Part 10 — Build the comparison table in Google Sheets (Step 5)

1. Open **Safari**, go to `https://sheets.new`. Sign into your Google account if asked.
2. In **Row 1**, type these headers across columns A to F:
   - A1: `Phase / span`
   - B1: `Service`
   - C1: `Trace B (ms)` ← your slower trace
   - D1: `Trace C (ms)` ← your faster trace
   - E1: `Δ (ms)` ← difference (B minus C)
   - F1: `% of end-to-end`
3. Select Row 1 and press `Cmd + B` to make it bold.
4. Fill in the rows with the values you wrote down from Jaeger.
5. Highlight the **SQL SELECT row** with a colour (click the row number → paint bucket icon). That's your key finding.
6. A few rows below, add a **Findings Summary** — one short paragraph explaining: which trace was slower, by how much, which span was the biggest contributor, and what percentage of the total difference it accounts for.
7. Below that, add **Limitations** — note that two traces is a small sample, and that traces show *where* time was spent but not *why*.
8. Below that, add a **Verification Procedure** — numbered steps someone else could follow to reproduce what you did (open Docker, generate traces, find the same spans in Jaeger, check the SQL SELECT duration).

---

### Part 11 — Export as latency-findings.pdf (Step 6)

1. In Google Sheets, click **File** → **Download** → **PDF document (.pdf)**.
2. In the export settings:
   - Paper size: **A4**
   - Orientation: **Portrait**
   - Scale: choose **Fit to width** so the table doesn't get cut off
3. Click **Export**. Save the file and name it exactly: `latency-findings.pdf`
4. Find the file (usually in your Downloads folder) and double-click to open it.
5. Check that the comparison table, span IDs, timing values, findings, limitations, and verification steps are all visible and nothing is cut off at the edges.
6. If anything is cut off, go back to Sheets, lower the scale percentage, and re-export.

---

### Part 12 — Stop the stack when you're done

1. Go back to the Terminal window where `docker compose up` is running.
2. Press `Ctrl + C` to stop the containers.
3. Then type:
   ```bash
   docker compose down
   ```
   This cleanly shuts everything down.

---

### Troubleshooting

| Problem | Fix |
|---|---|
| `http://localhost:16686` won't load | Docker Desktop isn't running — open it from Applications and wait for the green light |
| No traces showing in Jaeger | Go back to Step 6 and generate more traces first |
| `docker compose up` gives an error | Make sure you're inside the `Jaeger-Test` folder (`cd Jaeger-Test`) before running it |
| `git clone` says "command not found" | Go back to Part 2 and install Git first |
| PDF columns cut off | Re-export from Sheets with "Fit to width" scale selected |
| Docker says port already in use | Another program is using port 16686 or 8090 — restart Docker Desktop and try again |
