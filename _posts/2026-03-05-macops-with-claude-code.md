---
layout: post
title: MacOps with Claude Code
excerpt_separator: <!--end-of-excerpt-->
categories:
 - macos
 - sysadmin
 - claude
 - devops
---

Claude Code tracks sessions by the directory you start them from. That's not a side note — it's actually a useful design principle you can exploit deliberately.

<!--end-of-excerpt-->

I have Claude sessions scattered across different projects. A frontend repo. A backend service. Some infrastructure work. Each one has its own context, its own memory, its own thread. They don't bleed into each other because they each live in their own directory.

And just now, I realized nothing stops you from doing the same for topics that aren't code. Like my macOS administration.

So I created an empty directory — `macops.claude` — for exactly that purpose. No code in it. Just a `CLAUDE.md` describing what the space is for, and an `incidents/` folder for write-ups. The idea being that every time I want to investigate something on my Mac — a crash, a performance issue, runaway processes, whatever — I start Claude from there. The session stays in context with every previous macOS conversation. Nothing bleeds in from unrelated projects. Over time it builds up a picture of my actions, on my machine.

The directory doesn't need to contain anything functional. It just needs to exist, and to be the place you consistently return to for a given topic.

---

Right this morning, straightforward kick-off: macbook came back up after what looked like a crash. Turned out to be a clean chain of events — battery drained overnight, emergency shutdown, boot watchdog on the way back up. Below is the incident write-up from that session, included here as an example of what these look like in practice.

---

### Example: Incident Write-Up

```markdown
# Incident: Battery Drain → Boot Watchdog Crash

Date: 2026-03-05
Machine: MacBook Pro M3, macOS 15.7.2

## What Happened

Laptop came back up after an apparent crash overnight. Investigation via
system logs and diagnostic reports revealed a two-stage failure.

## Root Cause Chain

1. Battery drained to 0% overnight (not plugged in)
   - At midnight, battery was at 30%
   - Chrome (Video Wake Lock), Time Machine backup (ran 2+ hours), and
     repeated maintenance wakes kept the system from sleeping deeply
   - By 03:43, battery was at 1%
   - System woke every ~15 minutes for maintenance at 1%
   - At 04:53, battery hit critical → macOS triggered "Low Power Sleep"
     (clean emergency shutdown, TCP keepalive disabled)

2. Boot watchdog crash on first restart
   - First boot attempt after power was restored failed
   - Evidence: ResetCounter diagnostic showed:
       Boot failure count: 1
       Boot faults: rst wdog, reset_in_1 timeout, dblclick_timeout crash
   - Hardware-level SoC watchdog reset, caused by corrupted state from
     the abrupt forced power-off
   - System auto-recovered and successfully booted at 09:01

3. fileproviderd sync frenzy (aftermath, not cause)
   - After successful boot, fileproviderd wrote 2.1 GB in 104 seconds
     (20 MB/s), far exceeding its limit
   - File sync daemon (iCloud / Google Drive) catching up on pending work
   - Consequence of the overnight forced shutdown, not a cause of the crash

## Key Evidence

  Time    Event
  04:53   Low Power Sleep — clean emergency shutdown
  09:01   Successful reboot (second attempt)
  09:06   ResetCounter written — records prior boot watchdog failure
  09:06–  fileproviderd sync frenzy (2.1 GB / 104s)
  09:08

## Lessons

- Keep laptop plugged in overnight. On Apple Silicon, macOS manages
  Optimized Battery Charging automatically — there is no user toggle in
  macOS 15, and no need for one. Deep discharges to 0% are more harmful
  than staying connected.
- The forced power-off from battery death was the single root cause of
  the boot watchdog crash. The sync frenzy was cleanup noise.
```

---

Not every session will produce something this tidy. But having a consistent place to land, and a habit of writing things down, means the next time something looks wrong there's already context to work from.

ymmv
