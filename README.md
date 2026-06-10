# 🖥️ Homelab Setup

Personal homelab built on an old desktop PC for learning IT infrastructure, networking, and DevOps skills.

---

## Hardware

| Component | Spec |
|-----------|------|
| CPU | Intel i7-4770 |
| RAM | 16GB DDR3 |
| GPU | GTX 950 (unused) |
| SSD | 128GB (OS) |
| HDD | 1TB (storage) |

---

## Network

| Device | IP Address | Notes |
|--------|-----------|-------|
| Router/Gateway | `192.168.100.1` | |
| Proxmox Host | `192.168.10.200` | Static IP, Ethernet only |
| Ubuntu Docker VM | `192.168.10.119` | DHCP |
| Proxmox (Tailscale) | `100.117.76.106` | Remote access |
| Ubuntu VM (Tailscale) | `100.72.135.5` | Remote access |

---

## Stack

### Proxmox VE
- **Type:** Type 1 Hypervisor (bare metal)
- **Version:** 8.4.0
- **Interface:** `https://192.168.10.200:8006`
- **Network interface:** `enp3s0` (Ethernet)

### Ubuntu Server VM (`ubuntu-docker`)
- **OS:** Ubuntu Server 22.04 LTS
- **vCPUs:** 4
- **RAM:** 4GB
- **Disk:** 50GB
- **IP:** `192.168.10.119`

---

## Services

| Service | URL (Local) | URL (Remote) | Description |
|---------|------------|--------------|-------------|
| Proxmox | `https://192.168.10.200:8006` | `https://100.117.76.106:8006` | Hypervisor management |
| Portainer | `http://192.168.10.119:9000` | `http://100.72.135.5:9000` | Docker management |
| Grafana | `http://192.168.10.119:3000` | `http://100.72.135.5:3000` | Monitoring dashboards |
| Prometheus | `http://192.168.10.119:9090` | `http://100.72.135.5:9090` | Metrics collection |
| Homepage | `http://192.168.10.119:3001` | `http://100.72.135.5:3001` | Service dashboard |

---

## Docker Compose Files

### Monitoring (`~/monitoring/docker-compose.yml`)
- Prometheus — metrics collection
- Node Exporter — system metrics
- Grafana — visualization (dashboard ID: 1860)

### Homepage (`~/homepage/docker-compose.yml`)
- Homepage — unified service dashboard

---

## Remote Access

**Tailscale** is installed on both Proxmox and the Ubuntu VM, allowing secure remote access from anywhere without port forwarding.

---

## Planned

- [ ] Nextcloud — self-hosted cloud storage
- [ ] Pi-hole — network-wide ad blocking
- [ ] Nginx Proxy Manager — reverse proxy
- [ ] Proxmox stats in Grafana

---

## Skills Demonstrated

- Type 1 hypervisor setup and management (Proxmox)
- Linux server administration (Ubuntu Server)
- Containerization (Docker, Docker Compose)
- Infrastructure monitoring (Grafana, Prometheus)
- VPN/remote access (Tailscale)
- Networking fundamentals (static IPs, subnetting, DNS)
