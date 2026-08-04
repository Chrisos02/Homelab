# BloodHound Analysis

## Overview

BloodHound is used to visualize relationships within Active Directory.

---

## Setup

* Neo4j started on Kali
  ```
  sudo neo4j start
  ```
* BloodHound UI accessed via:

  ```
  http://127.0.0.1:8080
  ```
  ```
  sudo bloodhound-python -u 'user1' -p '<PASSWORD>' -d homelab.local -ns 192.168.10.20 -c all --zip
  ```
  
---

## Data Import

* SharpHound `.zip` file uploaded
* Data parsed into graph database

---

## Features Used

* Search
* Pathfinding
* Pre-built queries

---

## Initial Findings

* Users and groups successfully identified
* Domain structure visualized

---

## Key Concept

BloodHound shows how permissions create attack paths, not just who is admin.

---

## Next Step

Introduce misconfigurations to simulate real-world attack scenarios.
