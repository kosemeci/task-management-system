PREPARED IN TURKISH AND ENGLISH.
Türkçe ve İngilizce olarak hazırlanmıştır.


[TR]


# Task Management System - DevOps Süreci

Bu proje, **React** tabanlı bir **frontend** ve **Spring Boot** tabanlı bir **backend** içeren bir **Task Management System** uygulamasıdır. Projenin **DevOps** sürecini yönetmek için **Docker Compose**, **Jenkins** ve **ngrok** gibi araçlar kullanılmaktadır.

## 📌 Proje Yapısı
- **Backend** ve **Frontend** projeleri **submodule** olarak eklenmiştir.
- **Docker Compose** ile servislerin yönetimi sağlanmaktadır.
- **Jenkins CI/CD** süreçlerini yönetmek için kullanılmaktadır.
- **ngrok** ile Webhook tetikleyicileri için dış dünyaya erişim sağlanmaktadır.

---

## 🐋 Docker Kurulumu

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

## 📝 **Docker Compose File Yapısı**
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

## 🚀 Jenkins ile CI/CD Pipeline
Jenkins, test ve deploy işlemlerini yönetmek için kullanılan bir CI/CD aracıdır.

### ✅ **Jenkins Kurulumu**
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

### 🔑 **Jenkins Admin Şifresini Alma**
```bash
docker logs jenkins
```

### 🛠️ **Gerekli Jenkins Plugin'leri**
- **Git Plugin**
- **Docker Plugin**
- **Docker Pipeline**
- **Webhook Trigger**

### 📂 **Jenkins Pipeline Konfigürasyonu**

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

🚨 **Jenkins ortamında Java 17 kullanılmalıdır.**

---

## 🌍 **ngrok ile Jenkins Webhook Trigger Ayarı**
ngrok, localhost üzerindeki bir servise dış dünyadan erişim sağlamak için kullanılır.

### ✅ **Ngrok Kurulumu**
1. [Ngrok resmi sitesine](https://ngrok.com/) kaydol ve exe dosyasını indir.
2. **Auth Token**'ı tanıt:
   ```bash
   ngrok config add-authtoken YOUR_AUTH_TOKEN
   ```
3. Jenkins'i dış dünyaya açmak için:
   ```bash
   ngrok http http://localhost:9090
   ```
4. Terminalde oluşan **ngrok URL'sini** Webhook için kullan.

---

## 🔗 **Webhook ile Jenkins CI/CD Tetikleme**

1. **GitHub Repo Ayarlarına** gir ve **Webhook** sekmesine tıkla.
2. **Payload URL** olarak **ngrok URL'ini** ekleyerek `/github-webhook/` son ekini kullan.
3. **Content Type** olarak **application/json** seç.
4. **Just the push event** seçeneğini işaretle.

Bu ayarlar sayesinde repo güncellendiğinde Jenkins pipeline otomatik olarak çalışacaktır. 🎉


********************************************************************************************

[ENG]

# Task Management System - DevOps Process

This project is a **Task Management System** application with a **React-based frontend** and a **Spring Boot-based backend**. The **DevOps** process is managed using **Docker Compose**, **Jenkins**, and **ngrok**.

## 📌 Project Structure
- **Backend** and **Frontend** projects are included as **submodules**.
- **Docker Compose** is used to manage services.
- **Jenkins** is used for managing CI/CD processes.
- **ngrok** is used to expose webhook triggers to the external world.

---

## 🐳 Docker Installation

### ✅ Installing Docker on Windows
1. Download **Docker Desktop for Windows** [here](https://www.docker.com/products/docker-desktop/).
2. Run the downloaded **Docker Desktop Installer.exe**.
3. Check **"Enable WSL 2 based engine"** (Recommended).
4. Click **"Install"** to complete the setup.
5. Restart your computer.
6. Verify the installation by running the following command in **PowerShell** or **Command Prompt**:
   ```powershell
   docker --version
   ```
   If you see the Docker version, the installation was successful! 🎉

### ✅ Installing Docker Compose on Linux

```bash
curl -L "https://github.com/docker/compose/releases/download/2.32.0/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

Verify the installation:
```bash
docker-compose --version
```

---

## 📄 Docker Compose Configuration
Docker Compose is used to manage all services interconnectedly. Below is the basic content of the project's `docker-compose.yml` file:

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

## 🚀 CI/CD Process with Jenkins
Jenkins is used to manage testing and deployment processes.

### ✅ Installing Jenkins
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

### 🔑 Retrieving the Initial Admin Password
```bash
docker logs jenkins
```
Copy the password from the line **"Please use the following password to proceed to installation:"** and log in to the Jenkins UI.

### 🛠️ Required Plugins
After logging into the Jenkins UI, install the following plugins:
- **Git Plugin**
- **Docker Plugin**
- **Docker Pipeline**
- **Webhook Trigger**

### 📌 Pipeline Configuration
A `Jenkinsfile` has been created to automate the CI/CD process:

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

⚠️ **Java 17 should be used in the Jenkins environment.**

---

## 🌍 Exposing Localhost to the Internet with ngrok
ngrok is used to expose a local service to the external world.

### ✅ Installing ngrok
1. Sign up on the [ngrok official site](https://ngrok.com/) and download the executable file.
2. Add the **Auth Token**:
   ```bash
   ngrok config add-authtoken YOUR_AUTH_TOKEN
   ```
3. To expose a service like Jenkins, run the following command:
   ```bash
   ngrok http http://localhost:9090
   ```
4. Use the **ngrok URL** displayed in the terminal to configure webhook settings.

---

## 🔗 Webhook Integration with Jenkins
Webhook enables Jenkins to trigger automatically upon a GitHub push event.

### ✅ Webhook Setup
1. Go to **GitHub Repository Settings** and click on the **Webhook** tab.
2. In the **Payload URL** field, enter the **ngrok URL** and append `/github-webhook/`.
3. Select **Content Type** as **application/json**.
4. Choose **Just the push event**.

With these settings, the Jenkins pipeline will automatically run whenever the repository is updated. 🎉

---

## 🎯 Conclusion
With this DevOps process, the **Task Management System** project, consisting of a **React Frontend**, **Spring Boot Backend**, and **PostgreSQL Database**, is managed using **Docker** and deployed automatically with **Jenkins CI/CD**. 🚀



