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

| Device | Local IP | Tailscale IP | Notes |
|--------|----------|--------------|-------|
| Router/Gateway | `192.168.10.1` | — | |
| Proxmox Host | `192.168.10.200` | `100.117.76.106` | Static IP, Ethernet |
| Ubuntu Docker VM | `192.168.10.119` | `100.72.135.5` | Main Docker host |
| Pi-hole LXC | `192.168.10.100` | `100.104.157.125` | DNS server |

---

## Infrastructure

### Proxmox VE
- **Type:** Type 1 Hypervisor (bare metal)
- **Version:** 8.4.0
- **Web UI:** `https://192.168.10.200:8006`
- **Remote:** `https://100.117.76.106:8006`
- **Network interface:** `enp3s0` (Ethernet)

### Ubuntu Server VM (`ubuntu-docker`)
- **OS:** Ubuntu Server 22.04 LTS
- **vCPUs:** 4
- **RAM:** 4GB
- **Disk:** 50GB
- **Local IP:** `192.168.10.119`
- **Tailscale IP:** `100.72.135.5`

### Pi-hole LXC Container
- **OS:** Debian 12
- **vCPUs:** 1
- **RAM:** 512MB
- **Disk:** 4GB
- **Local IP:** `192.168.10.100`
- **Tailscale IP:** `100.104.157.125`

---

## Services

| Service | Local URL | Remote URL | Description |
|---------|-----------|------------|-------------|
| Proxmox | `https://192.168.10.200:8006` | `https://100.117.76.106:8006` | Hypervisor management |
| Portainer | `http://192.168.10.119:9000` | `http://100.72.135.5:9000` | Docker management |
| Grafana | `http://192.168.10.119:3000` | `http://100.72.135.5:3000` | Monitoring dashboards |
| Prometheus | `http://192.168.10.119:9090` | `http://100.72.135.5:9090` | Metrics collection |
| Homepage | `http://192.168.10.119:3001` | `http://100.72.135.5:3001` | Service dashboard |
| Pi-hole | `http://192.168.10.100/admin` | `http://100.104.157.125/admin` | DNS ad blocker |

---

## Screenshots

### Proxmox — Hypervisor
![Proxmox](screenshots/proxmox.png)

### Homepage — Service Dashboard
![Homepage](screenshots/grafana_dashboard.png)

### Grafana — Monitoring Dashboard
![Grafana](screenshots/grafana_dashboard.png)

### Portainer — Docker Management
![Portainer](screenshots/potainer.png)

### Pi-hole — DNS Ad Blocker
![Pi-hole](screenshots/pi_hole.png)

### Tailscale — Remote Access
![Tailscale](screenshots/tailscale.png)

---

## Configuration Files

### `~/monitoring/docker-compose.yml`

```yaml
version: '3'
services:
  prometheus:
    image: prom/prometheus
    container_name: prometheus
    restart: always
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  node-exporter:
    image: prom/node-exporter
    container_name: node-exporter
    restart: always
    ports:
      - "9100:9100"

  grafana:
    image: grafana/grafana
    container_name: grafana
    restart: always
    ports:
      - "3000:3000"
    volumes:
      - grafana-data:/var/lib/grafana

volumes:
  grafana-data:
```

### `~/monitoring/prometheus.yml`

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'node'
    static_configs:
      - targets: ['node-exporter:9100']
```

### `~/homepage/docker-compose.yml`

```yaml
version: '3'
services:
  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: homepage
    restart: always
    ports:
      - "3001:3000"
    environment:
      - HOMEPAGE_ALLOWED_HOSTS=100.72.135.5:3001
    volumes:
      - ./config:/app/config
      - /var/run/docker.sock:/var/run/docker.sock
```

### `~/homepage/config/services.yaml`

```yaml
- Homelab:
    - Proxmox:
        href: https://192.168.10.200:8006
        description: Hypervisor
        icon: proxmox.png
    - Portainer:
        href: http://192.168.10.119:9000
        description: Docker Management
        icon: portainer.png
    - Grafana:
        href: http://192.168.10.119:3000
        description: Monitoring
        icon: grafana.png
    - Pi-hole:
        href: http://192.168.10.100/admin
        description: DNS Ad Blocker
        icon: pi-hole.png
```

---

## Remote Access

**Tailscale** is installed on Proxmox, the Ubuntu Docker VM, and the Pi-hole LXC container. This allows secure remote access from anywhere without port forwarding or exposing ports to the internet.

---

## Planned

- [ ] Nextcloud — self-hosted cloud storage
- [ ] Nginx Proxy Manager — reverse proxy with domain names
- [ ] Proxmox metrics in Grafana
- [ ] Automated backups

---

## Skills Demonstrated

- Type 1 hypervisor setup and management (Proxmox VE)
- Virtual machine provisioning and configuration
- LXC container management
- Linux server administration (Ubuntu Server, Debian)
- Containerization (Docker, Docker Compose)
- Infrastructure monitoring (Grafana, Prometheus, Node Exporter)
- DNS management and network-wide ad blocking (Pi-hole)
- VPN and secure remote access (Tailscale)
- Networking fundamentals (static IPs, subnetting, DNS, gateways)
