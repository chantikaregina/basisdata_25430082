# Dokumen Kebutuhan Data - Koperasi Mahasiswa (Kopma Cendikia)

## 1. Latar Belakang dan Aktivitas Organisasi
Koperasi Mahasiswa (Kopma Cendikia) adalah unit kegiatan mahasiswa yang bergerak di bidang layanan retail ritel dan penyediaan kebutuhan harian mahasiswa. Aktivitas utama organisasi mencakup keanggotaan mahasiswa, manajemen persediaan stok barang, transaksi penjualan kasir, serta pelaporan unit usaha harian.

## 2. Aktor dan Proses Bisnis

| Kode PB | Aktor Terlibat | Nama Proses Bisnis | Deskripsi |
| :--- | :--- | :--- | :--- |
| **PB-01** | Pengurus Kopma | Pendataan Anggota & Pengurus | Mengelola pendaftaran anggota koperasi mahasiswa dan identitas petugas kasir/pengurus. |
| **PB-02** | Petugas Gudang | Pengelolaan Stok & Kategori Barang | Mengelola data persediaan barang toko, harga jual, dan kategori produk. |
| **PB-03** | Kasir, Anggota/Pembeli | Transaksi Penjualan Retail | Memproses transaksi penjualan barang di toko, pemberian diskon anggota, dan pencetakan nota. |
| **PB-04** | Pengurus Kopma | Pelaporan Keuangan & Penjualan | Menyusun rekapitulasi penjualan harian, pendapatan unit usaha, dan sisa hasil usaha. |

## 3. Dokumen Sumber yang Dianalisis

Dokumen sumber utama yang dianalisis adalah **Nota Penjualan Toko Kopma** yang diberikan kepada pembeli/anggota saat transaksi.

**Rancangan Struk / Nota Penjualan Fiktif:**

=================================================================
                    KOPMA CENDIKIA REGINA
                Jl. Universitas No. 1, Campus Area
=================================================================
No. Nota    : PJ-2026-0082          Tgl Transaksi : 05-10-2026
Kasir       : KAS-02 (Siti)         No. Anggota   : A-0457 (Chantika)
-----------------------------------------------------------------
[Kode]   [Nama Barang]        [Qty]   [Harga]       [Subtotal]
BRG-01   Buku Tulis A5          2     Rp 5.000      Rp 10.000
BRG-02   Pena Gel Black         3     Rp 4.000      Rp 12.000
BRG-03   Map Kertas             1     Rp 3.000      Rp  3.000
-----------------------------------------------------------------
Total Belanja   : Rp 25.000
Diskon Anggota  : Rp  2.000 (Diskon khusus P = Rp2.000)
Total Bayar     : Rp 23.000
Metode Bayar    : Tunai
=================================================================

**Tabel Bedahan Dokumen Sumber:**

| Elemen pada Dokumen Nota | Entitas Tujuan | Nama Elemen Data di Database |
| :--- | :--- | :--- |
| No. Anggota & Nama Anggota | Anggota | `no_anggota`, `nama_anggota` |
| ID & Nama Kasir | Kasir | `id_kasir`, `nama_kasir` |
| Kode & Nama Barang | Barang | `kode_barang`, `nama_barang` |
| Kategori Barang | Kategori | `id_kategori`, `nama_kategori` |
| No. Nota & Tgl Transaksi | Penjualan | `no_nota`, `tgl_transaksi` |
| Item Barang & Jumlah Beli | Detail_Penjualan | `id_detail`, `jumlah_beli` |

## 4. Entitas Kandidat dan Elemen Data

1. **`Anggota`**: `no_anggota`, `nim_anggota`, `nama_anggota`, `no_hp_anggota`
2. **`Kasir`**: `id_kasir`, `nama_kasir`, `jabatan`
3. **`Kategori`**: `id_kategori`, `nama_kategori`
4. **`Barang`**: `kode_barang`, `id_kategori`, `nama_barang`, `harga_satuan`, `stok_barang`
5. **`Penjualan`**: `no_nota`, `no_anggota`, `id_kasir`, `tgl_transaksi`, `total_bayar`, `diskon_anggota`
6. **`Detail_Penjualan`**: `id_detail`, `no_nota`, `kode_barang`, `jumlah_beli`, `subtotal`

## 5. Aturan Bisnis

| Kode AB | Deskripsi Aturan Bisnis |
| :--- | :--- |
| **AB-01** | Anggota terdaftar memiliki `no_anggota` unik yang terikat pada `nim_anggota`. |
| **AB-02** | Setiap transaksi penjualan ditangani oleh tepat **1 Kasir** yang bertugas. |
| **AB-03** | Jumlah barang minimum yang dapat dibeli dalam satu item detail transaksi adalah 1 unit dan stok barang berkurang otomatis ($AB\ge0$). |
| **AB-04** | Anggota aktif berhak menerima potongan harga tunai (*diskon anggota*) sebesar **Rp2.000** ($P$ dalam ribuan) untuk setiap total transaksi di atas Rp20.000. |
| **AB-05** | Setiap barang tergolong ke dalam **1 Kategori** barang toko. |
| **AB-06** | Transaksi yang sudah diterbitkan per notanya tidak dapat dihapus, hanya dapat dibatalkan melalui persetujuan Pengurus. |

## 6. Kebutuhan Informasi

| Kode KI | Deskripsi Kebutuhan Informasi | Elemen Data yang Ditampilkan |
| :--- | :--- | :--- |
| **KI-01** | Struk / Nota Penjualan Retail | `no_nota`, `tgl_transaksi`, `nama_anggota`, `nama_barang`, `jumlah_beli`, `total_bayar` |
| **KI-02** | Laporan Stok Barang Toko | `kode_barang`, `nama_barang`, `nama_kategori`, `harga_satuan`, `stok_barang` |
| **KI-03** | Rekapitulasi Penjualan Harian | `no_nota`, `tgl_transaksi`, `nama_kasir`, `total_bayar`, `diskon_anggota` |
| **KI-04** | Daftar Keanggotaan Aktif Kopma | `no_anggota`, `nim_anggota`, `nama_anggota`, `no_hp_anggota` |

## 7. Matriks CRUD

| Kode PB | Nama Proses Bisnis | Anggota | Kasir | Kategori | Barang | Penjualan | Detail_Penjualan |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** | Pendataan Anggota & Pengurus | C, R, U | C, R, U | - | - | - | - |
| **PB-02** | Pengelolaan Stok & Kategori | - | R | C, R, U, D | C, R, U, D | - | - |
| **PB-03** | Transaksi Penjualan Retail | R | R | R | R, U | C, R | C, R |
| **PB-04** | Pelaporan Keuangan & Penjualan | R | R | R | R | R | R |

## 8. Kamus Data Awal

| Elemen | Arti | Contoh | Aturan | Penanggung jawab |
| :--- | :--- | :--- | :--- | :--- |
| `no_anggota` | Nomor anggota koperasi | A-0457 | Unik, format A-4digit | Ketua |
| `nim_anggota` | NIM anggota | 25430082 | Unik, 10 digit | Ketua |
| `nama_anggota` | Nama lengkap anggota | Chantika R. B. P. | Teks | Ketua |
| `no_hp_anggota` | Nomor HP anggota | 0812xxxx | Data pribadi, akses terbatas | Ketua |
| `id_kasir` | ID petugas kasir | KAS-02 | Unik, format KAS-2digit | Kasir |
| `nama_kasir` | Nama lengkap kasir | Siti | Teks | Kasir |
| `jabatan` | Jabatan pengurus | Kasir Toko | Teks | Kasir |
| `id_kategori` | ID kategori barang | KAT-01 | Unik, format KAT-2digit | Petugas gudang |
| `nama_kategori` | Nama kelompok barang | Alat Tulis | Teks | Petugas gudang |
| `kode_barang` | Kode identifikasi barang | BRG-01 | Unik, format BRG-2digit | Petugas gudang |
| `nama_barang` | Nama produk barang toko | Buku Tulis A5 | Teks | Petugas gudang |
| `harga_satuan` | Harga jual per unit | 5000 | Bilangan bulat $\ge 0$ | Kasir |
| `stok_barang` | Jumlah sisa barang toko | 35 | Bilangan bulat $\ge 0$ (AB-03) | Petugas gudang |
| `no_nota` | Nomor nota penjualan | PJ-2609-0142 | Unik per nota | Kasir |
| `tgl_transaksi` | Tanggal waktu belanja | 2026-10-05 | Format YYYY-MM-DD | Kasir |
| `total_bayar` | Total tagihan belanja | 23000 | Bilangan bulat $\ge 0$ (rupiah) | Kasir |
| `diskon_anggota` | Nominal potongan belanja | 2000 | Bilangan bulat $\ge 0$ (AB-04) | Kasir |
| `id_detail` | ID item transaksi detail | 5001 | Unik, auto-increment | Kasir |
| `jumlah_beli` | Banyaknya unit dibeli | 2 | Bilangan bulat $\ge 1$ | Kasir |
| `subtotal` | Subtotal harga item | 10000 | Bilangan bulat $\ge 0$ (rupiah) | Kasir |

## 9. Kebutuhan Non-Fungsional Data

Kebutuhan non-fungsional dicatat secara singkat sebagai berikut:
- **Volume Transaksi:** Perkiraan ±50 nota per hari pada siklus operasional normal ($40 + 5 \times 2 = 50$).
- **Retensi Data:** Data transaksi penjualan disimpan minimal lima tahun untuk keperluan audit keuangan koperasi.
- **Akses Data Pribadi:** Nomor HP anggota (`no_hp_anggota`) hanya boleh dilihat oleh ketua koperasi. Pembatasan akses data pribadi seperti ini sejalan dengan kewajiban pengendali data dalam Undang-Undang Pelindungan Data Pribadi [17].

## 10. Isu Kualitas Data yang Diantisipasi

- **Pencegahan Stok Minus:** Sistem menolak transaksi secara otomatis jika `jumlah_beli` melebihi `stok_barang` yang tersedia.
- **Integritas Referensial Detail Transaksi:** Penghapusan data induk barang (`kode_barang`) ditolak jika barang tersebut sudah tercatat di tabel `Detail_Penjualan`.