# PRAKTIKUM JARKOM MODUL 5 KELOMPOK 55 - 2025

## Angota Kelompok

| Nama                         | NRP        |
| ---------------------------- | ---------- |
| Ardhi Putra Pradana          | 5027241022 |
| M. Hikari Reiziq Rakhmadinta | 5027241079 |


# Laporan Resmi Praktikum Modul 5 - Jaringan Komputer 2025
## Misi 1: Memetakan Medan Perang

Pada modul ini, kami merancang infrastruktur jaringan "The Shadow of the East" dengan topologi yang menghubungkan berbagai faksi (Client) dengan pusat layanan (Server) melalui serangkaian Router dan Switch.

**Prefix IP Kelompok:** `10.91.0.0/16`

### I. Topologi Jaringan

Berikut adalah desain topologi jaringan yang digunakan dalam simulasi ini:

![Topologi Jaringan](/assets/Topologi.png)

---

### Soal 1: Identifikasi Perangkat

**Deskripsi Soal:**
Mengidentifikasi peran setiap node (perangkat) dalam jaringan, meliputi Server, Router/Relay, dan Client beserta jumlah host yang dibutuhkan untuk perhitungan subnetting.

**Langkah Pengerjaan:**
Kami melakukan analisis berdasarkan kebutuhan scenario:
1.  **Server:** Node yang menyediakan layanan (DNS, DHCP, Web).
2.  **Router:** Node yang mengatur lalu lintas antar-jaringan.
3.  **Client:** Node pengguna yang membutuhkan alokasi IP.

**Hasil Identifikasi:**

| Kategori | Nama Node | Peran / Spesifikasi |
| :--- | :--- | :--- |
| **Server** | **Vilya** | DHCP Server (Pusat distribusi IP) |
| | **Narya** | DNS Server (Resolusi Domain) |
| | **Palantir** | Web Server 2 |
| | **IronHills** | Web Server 1 |
| **Router** | **Osgiliath** | Router Utama (NAT Gateway) |
| | **Minastir** | DHCP Relay (Branch Kanan) |
| | **Wilderland** | DHCP Relay (Branch Kiri) |
| | **Moria** | Router & DHCP Relay |
| | **Rivendell** | Router & DHCP Relay |
| | **Pelargir** | Router |
| | **AnduinBanks** | DHCP Relay (Branch Kanan Jauh) |
| **Client** | **Elendil** | 200 Host |
| | **Gilgalad** | 100 Host |
| | **Durin** | 50 Host |
| | **Isildur** | 30 Host |
| | **Cirdan** | 20 Host |
| | **Khamul** | 5 Host |

**Validasi:**
Validasi dilakukan dengan mencocokkan posisi node pada gambar `Topologi.png` dengan deskripsi peran di atas. Posisi Server ditempatkan pada subnet terpisah, sedangkan Client ditempatkan di ujung jaringan (Leaf nodes).

---

### Soal 2: Perhitungan Subnetting (VLSM) & Pohon Subnet

**Deskripsi Soal:**
Melakukan pembagian alamat IP menggunakan metode *Variable Length Subnet Mask* (VLSM) berdasarkan Prefix IP `10.91.0.0/16` dan menggambarkan pohon subnet (Subnet Tree) yang menunjukkan hierarki pembagiannya.

**Langkah Pengerjaan:**
1.  **Sorting:** Mengurutkan kebutuhan subnet dari jumlah host terbanyak ke terkecil untuk mencegah tumpang tindih IP (*IP Overlapping*).
2.  **Subnetting:** Menentukan CIDR yang paling efisien untuk setiap kebutuhan.
3.  **Addressing:** Mengalokasikan Network ID secara berurutan (*contiguous*).

**Tabel Perhitungan VLSM:**
Berikut adalah hasil perhitungan VLSM yang telah kami susun:

![Tabel Pembagian IP VLSM](/assets/pembagian%20ip-vlsm_m1s2.png)

**Rincian Alokasi Utama:**
* **Subnet A9 (Elendil & Isildur):** 230 Host → **/24** (254 IP).
* **Subnet A13 (Gilgalad & Cirdan):** 120 Host → **/25** (126 IP).
* **Subnet A6 (Durin):** 50 Host → **/26** (62 IP).
* **Subnet Kecil (Server & Router):** Menggunakan **/29** dan **/30** sesuai kebutuhan point-to-point atau jumlah server.

**Tabel Routing (Next Hop):**
Berikut adalah rencana routing statis untuk menghubungkan subnet-subnet tersebut:

![Tabel Routing](/assets/rute_m1s2.png)

**Visualisasi Pohon Subnet (VLSM Tree):**
Untuk memvisualisasikan hierarki pembagian dari blok IP induk `10.91.0.0`, berikut adalah pohon subnet yang terbentuk:

![Pohon Subnet](/assets/pohon%20subnet%20.jpg)

**Validasi:**
1.  **Efisiensi:** Tidak ada IP yang terbuang sia-sia (contoh: A9 butuh 230 pakai /24, sangat pas).
2.  **No Overlap:** Range IP A9 (`10.91.0.0 - 10.91.0.255`) tidak menabrak range IP A13 (`10.91.1.0 - 10.91.1.127`).
3.  **Hierarki:** Pohon subnet menunjukkan pemecahan yang logis dari blok besar ke blok kecil.

Berikut adalah lingkaran subnet pada topologi
![subnet topologi](/assets/VLSM.png)


---

# Laporan Praktikum Modul 5: Jaringan Komputer - The Shadow of the East

Laporan ini mendokumentasikan penyelesaian dan validasi untuk **Misi 1 (DNS & Web Server)** serta **Misi 2 (Konektivitas & NAT)**.

---

### ⚠️ Catatan Penting: Metode Instalasi "Sandwich DNS"

Karena node Server dan Router dalam topologi ini menggunakan **IP Statis** dan tidak memiliki konfigurasi DNS default, node tersebut tidak dapat mengunduh paket dari internet saat pertama kali dijalankan. Untuk mengatasi hal ini tanpa merusak konfigurasi akhir, kami menggunakan metode **"Sandwich DNS"** pada setiap pengerjaan:

1.  **Awal:** Mengubah sementara konfigurasi DNS ke Google (`8.8.8.8`).
2.  **Proses:** Melakukan update repository dan instalasi paket yang dibutuhkan (seperti `nginx`, `bind9`, `isc-dhcp-relay`).
3.  **Akhir:** Mengembalikan konfigurasi DNS ke IP Narya (`10.91.1.195`) agar node dapat mengenali domain lokal `arda.local`.

---

## Misi 1: Membangun Infrastruktur Layanan

### Soal 3: Konfigurasi DNS Zone (Arda Local)

**Deskripsi Soal:**
Kami diminta mengonfigurasi node **Narya** sebagai DNS Server Utama (Master) untuk melayani resolusi domain lokal `arda.local`. Skema domain yang harus dibuat adalah:
* `palantir.arda.local` → Mengarah ke IP Palantir (`10.91.1.234`).
* `ironhills.arda.local` → Mengarah ke IP IronHills (`10.91.1.218`).
* `www.arda.local` → CNAME (Alias) ke `arda.local`.

**Cara Mengerjakan:**
1.  Melakukan instalasi paket `bind9` pada node Narya.
2.  Mendefinisikan Zone Master baru untuk `arda.local` pada konfigurasi Bind9.
3.  Membuat file database forward zone yang memetakan nama domain ke alamat IP server yang sesuai.
4.  Menambahkan konfigurasi *Forwarder* ke DNS Google (`8.8.8.8`) agar Narya tetap dapat melayani request ke internet luar (seperti `google.com`).

**Validasi:**
Validasi dilakukan dari sisi Client (**Elendil**) dengan melakukan `ping` ke domain `palantir.arda.local`. Hasil validasi menunjukkan bahwa DNS Resolver Narya berhasil menerjemahkan domain tersebut ke IP Address Palantir yang benar.

![Validasi DNS Domain](/assets/cek_domain.png)

---

### Soal 4: Konfigurasi Web Server

**Deskripsi Soal:**
Mengaktifkan layanan Web Server pada node **Palantir** dan **IronHills**. Kedua server ini harus dapat diakses menggunakan domain yang telah dikonfigurasi sebelumnya serta menampilkan halaman identitas diri yang unik untuk membedakan keduanya.

**Cara Mengerjakan:**
1.  Menggunakan layanan **Nginx** sebagai Web Server.
2.  Menerapkan metode *Sandwich DNS* untuk mengunduh paket Nginx dari internet.
3.  Membuat halaman `index.html` kustom pada direktori `/var/www/html/` yang berisi identitas nama server (misal: "INI ADALAH PALANTIR").
4.  Memastikan service Nginx berjalan dan port 80 terbuka.

**Validasi:**
Validasi dilakukan dengan mengecek respon HTTP server dari Client (**Elendil**) menggunakan domain `palantir.arda.local`. Server merespons dengan status `200 OK` dan menampilkan konten identitas server, membuktikan Web Server dan DNS berjalan sinkron.

![Validasi Web Server](/assets/cek_web_server.png)

---

## Misi 2: Membuka Gerbang Barat (Konektivitas & NAT)

### Soal 1: Akses Internet, Routing, dan DHCP

**Deskripsi Soal:**
Membangun konektivitas jaringan secara menyeluruh di mana seluruh node (Client, Server, dan Router) dapat mengakses internet.
* **Syarat 1 (NAT):** Router Utama (**Osgiliath**) wajib menggunakan **SNAT** (Source NAT) dan dilarang menggunakan *Masquerade*.
* **Syarat 2 (DHCP):** Client harus mendapatkan IP Address secara otomatis (Dinamis) dari **Vilya** (DHCP Server).

**Cara Mengerjakan:**
1.  **Konfigurasi NAT (Osgiliath):** Menerapkan rule `iptables` dengan target `SNAT` pada chain POSTROUTING. Kami mengubah *source IP* paket yang berasal dari subnet lokal (`10.91.0.0/16`) menjadi IP Public eth0 Osgiliath saat menuju internet.
2.  **IP Forwarding:** Mengaktifkan fitur forwarding (`net.ipv4.ip_forward=1`) pada seluruh router agar paket data dapat diteruskan antar-interface.
3.  **DHCP Server (Vilya):** Mengonfigurasi subnet dan range IP untuk setiap client pada `isc-dhcp-server`.
4.  **DHCP Relay:** Menginstall dan mengonfigurasi `isc-dhcp-relay` pada seluruh router cabang (Minastir, Moria, Rivendell, Wilderland, AnduinBanks) agar request DHCP dari client dapat diteruskan ke Vilya.

**Validasi:**

**A. Validasi Distribusi IP (DHCP)**
Pengecekan dilakukan pada Client **Cirdan**. Hasilnya, client berhasil mendapatkan IP Address dinamis dari Vilya, membuktikan jalur Relay dan Server DHCP berfungsi.

![Validasi DHCP Cirdan](/assets/ip_dibagikan_dhcp_di_cirdan.png)

**B. Validasi Koneksi Antar Node (Routing)**
Tes konektivitas dilakukan dengan melakukan `ping` dari ujung ke ujung, yaitu dari **Durin** ke **Cirdan**. Hasil reply menandakan tabel routing statis antar-subnet telah terkonfigurasi dengan benar.

![Validasi Ping Antar Node](/assets/ping_durin_ke_cirdan.png)

**C. Validasi Akses Internet (NAT)**
Tes koneksi internet dilakukan dengan melakukan `ping google.com` dari Router Cabang (**Moria**). Hasil reply membuktikan bahwa konfigurasi SNAT di Osgiliath bekerja dengan baik dan DNS Forwarding di Narya mampu menerjemahkan domain publik.

![Validasi Ping Internet](/assets/test_ping_google_di_moria.png)