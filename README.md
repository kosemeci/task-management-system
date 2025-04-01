
**#[TR]**

# Task Management System - DevOps Süreci

Bu proje, **React** tabanlı bir **frontend** ve **Spring Boot** tabanlı bir **backend** içeren bir **Task Management System** uygulamasıdır. Projenin **DevOps** sürecini yönetmek için **Docker Compose**, **Jenkins** ve **ngrok** gibi araçlar kullanılmaktadır.

## 📌 Proje Yapısı
- **Backend** ve **Frontend** projeleri **submodule** olarak eklenmiştir.
- **Docker Compose** ile servislerin yönetimi sağlanmaktadır.
- **Jenkins** CI/CD süreçlerini yönetmek için kullanılmaktadır.
- **ngrok** ile Webhook tetikleyicileri için dış dünyaya erişim sağlanmaktadır.

---

## 🐳 Docker Kurulumu

### ✅ Windows İçin Docker Kurulumu
1. **Docker Desktop for Windows**'u [buradan](https://www.docker.com/products/docker-desktop/) indir.
2. İndirilen **Docker Desktop Installer.exe** dosyasını çalıştır.
3. **"Enable WSL 2 based engine"** kutusunu işaretle (Önerilir).
4. **"Install"** butonuna tıklayarak kurulumu tamamla.
5. Bilgisayarını yeniden başlat.
6. Kurulumu doğrulamak için **PowerShell** veya **Komut İstemi**'nde aşağıdaki komutu çalıştır:
   ```powershell
   docker --version
   ```
   Eğer Docker sürümünü görüyorsan kurulum başarılıdır! 🎉

### ✅ Linux İçin Docker Compose Kurulumu

```bash
curl -L "https://github.com/docker/compose/releases/download/2.32.0/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

Kurulumu doğrulamak için:
```bash
docker-compose --version
```

---

## 📄 Docker Compose Yapılandırması
Docker Compose, tüm servisleri birbirine bağlı olarak yönetmek için kullanılan bir araçtır. İşte projenin `docker-compose.yml` dosyasının temel içeriği:

```yaml
version: '3.7'

services:
  backend:
    build:
      context: ./backend
    ports:
      - "8080:8080"
    networks:
      - app-network
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://db:5432/postgres
      SPRING_DATASOURCE_USERNAME: postgres
      SPRING_DATASOURCE_PASSWORD: alpi1905
    depends_on:
      - db

  frontend:
    build:
      context: ./frontend
    ports:
      - "5173:80"
    networks:
      - app-network

  db:
    image: postgres:13
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: alpi1905
      POSTGRES_DB: postgres
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./backup.sql:/docker-entrypoint-initdb.d/backup.sql
    ports:
      - "5432:5432"
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

volumes:
  postgres_data:
    driver: local
```
---

## 🚀 Jenkins ile CI/CD Süreci
Jenkins, test ve deploy işlemlerini yönetmek için kullanılan bir CI/CD aracıdır.

### ✅ Jenkins Kurulumu
```bash
docker run -d \
  --name jenkins \
  --user root \
  -p 9090:8080 \
  -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v C:/_cicd:/var/jenkins_home \
  jenkins/jenkins:lts
```

### 🔑 İlk Admin Şifresini Alma
```bash
docker logs jenkins
```
Çıktıda bulunan **"Please use the following password to proceed to installation:"** satırındaki şifreyi kopyalayarak Jenkins arayüzüne giriş yap.

### 🛠️ Gerekli Eklentiler
Jenkins UI'ya giriş yaptıktan sonra aşağıdaki eklentileri yükleyin:
- **Git Plugin**
- **Docker Plugin**
- **Docker Pipeline**
- **Webhook Trigger**

### 📌 Pipeline Konfigürasyonu
Jenkinsfile dosyası oluşturularak CI/CD süreci otomatik hale getirilmiştir:

```bash
#!/bin/bash

REPO_URL="https://github.com/kosemeci/task-management-system.git"

echo "Cloning repository with submodules..."
git clone --recurse-submodules $REPO_URL

cd task-management-system
docker-compose down || true
docker-compose up -d --build
docker ps
```

⚠️ **Jenkins ortamında Java 17 kullanılmalıdır.**

---

## 🌍 ngrok ile Localhost'u Dış Dünyaya Açma
ngrok, localhost üzerindeki bir servise dış dünyadan erişim sağlamak için kullanılır.

### ✅ Ngrok Kurulumu
1. [Ngrok resmi sitesine](https://ngrok.com/) kaydol ve exe dosyasını indir.
2. **Auth Token**'ını tanıt:
   ```bash
   ngrok config add-authtoken YOUR_AUTH_TOKEN
   ```
3. Jenkins gibi bir servisi dış dünyaya açmak için aşağıdaki komutu çalıştır:
   ```bash
   ngrok http http://localhost:9090
   ```
4. Terminalde oluşan **ngrok URL'sini** kullanarak webhook ayarlarını yapabilirsin.

---

## 🔗 Webhook ile Jenkins Entegrasyonu
Webhook, GitHub push işlemleriyle Jenkins'in otomatik olarak tetiklenmesini sağlar.

### ✅ Webhook Ayarları
1. **GitHub Repo Ayarlarına** gir ve **Webhook** sekmesine tıkla.
2. **Payload URL** kısmına **ngrok URL'ini** ekleyerek sonuna `/github-webhook/` ekle.
3. **Content Type** olarak **application/json** seç.
4. **Just the push event** seçeneğini işaretle.

Bu ayarlar sayesinde repo güncellendiğinde Jenkins pipeline otomatik olarak çalışacaktır. 🎉

---

## 🎯 Sonuç
Bu DevOps süreci ile **React Frontend**, **Spring Boot Backend** ve **PostgreSQL** veritabanını içeren **Task Management System** projesi **Docker** ile yönetilmekte ve **Jenkins CI/CD** süreci ile otomatik olarak deploy edilmektedir. 🚀

