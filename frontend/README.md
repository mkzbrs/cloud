# ☁️ Cloud Storage

A fully self-hosted, full-stack personal cloud storage solution engineered to be a drop-in replacement for Google Drive. 

Built with a modern CI/CD pipeline, a cross-platform frontend, and a robust physical hardware backend hosted right from a home lab. Accessible globally via secure tunnels.

---

## 🏗️ Architecture & Tech Stack

This project strictly follows the **Separation of Concerns** principle with a Monorepo structure.

### 1. Frontend (The Face)
* **Framework:** Flutter (Dart) - *Cross-platform (Web & iOS)*
* **Hosting:** Cloudflare Pages
* **Domain:** `cloud.mkzbrs.com`
* **CI/CD:** GitHub Actions (Automated build & deploy on `push`)

### 2. Backend & Infrastructure (The Engine)
* **Storage Server:** Minio (S3-Compatible Object Storage)
* **Containerization:** Docker & Docker Compose
* **Management:** Portainer
* **Networking:** Cloudflare Tunnel (`cloudflared`)
* **API Endpoint:** `s3.mkzbrs.com`
* **Admin Console:** `drive.mkzbrs.com`

### 3. Hardware (The Iron)
* **Board:** Raspberry Pi 5 (8GB RAM)
* **OS:** Ubuntu Server 24.04 LTS (64-bit)
* **Storage Interface:** Penta SATA HAT 
* **Storage Drive:** 4TB HDD (Mounted as `/mnt/storage` in `ext4`)

---

## 🚀 Features
- [x] **Automated CI/CD:** Zero-touch deployment using GitHub Actions to Cloudflare Pages.
- [ ] **Cross-Platform:** Write once in Flutter, run seamlessly on Web browsers and native iOS.
- [ ] **S3 Integration:** Direct, secure file streaming to self-hosted Minio instance.
- [ ] **Isolated Environment:** Fully containerized backend ensuring high scalability and zero conflict.
- [ ] **Data Privacy:** 100% data ownership stored on physical drives at home.

---

## 🗺️ Project Roadmap

- **Phase 1:** Hardware & OS Configuration (Pi 5 + SATA HAT + 4TB HDD)
- **Phase 2:** Docker Infrastructure Setup (Portainer)
- **Phase 3:** Storage & Networking (Minio + Cloudflare Tunnels)
- **Phase 4:** Frontend Development & CI/CD Pipeline (Current Phase)
- **Phase 5:** Final Deployment (Web UI & iOS App Compilation)

---
*Developed by Muhammad Khuzaimi (CS Student)*