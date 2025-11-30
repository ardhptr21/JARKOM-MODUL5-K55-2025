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




