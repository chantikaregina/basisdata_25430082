# Dokumen Kebutuhan Data - Akademik Ceria RN

## 1. Latar belakang dan aktivitas organisasi

* Sistem Akademik dirancang untuk mengelola proses administrasi akademik di perguruan tinggi. 
* Aktivitas utama mencakup pendataan mahasiswa, pengelolaan mata kuliah dan kelas, proses pengisian Kartu Rencana Studi (KRS) semesteran, serta pencatatan nilai dan evaluasi akademik hasil studi mahasiswa

## 2. Aktor dan proses bisnis            (tabel PB-xx)

| Kode PB | Aktor Terlibat | Nama Proses Bisnis | Deskripsi |
| :--- | :--- | :--- | :--- |
| **PB-01** | Staf Akademik | Pendataan Mahasiswa & Dosen | Mengelola data profil mahasiswa, dosen pengajar, dan penetapan Dosen Pembimbing Akademik (DPA). |
| **PB-02** | Staf Akademik | Pengelolaan Kurikulum & Kelas | Mengelola master data mata kuliah, pembukaan kelas paralel, dan alokasi dosen pengajar. |
| **PB-03** | Mahasiswa, DPA | Pengisian & Perubahan KRS | Memproses pengajuan rencana studi, validasi prasyarat, serta persetujuan (*approval*) oleh DPA. |
| **PB-04** | Dosen Pengajar | Pencatatan Nilai & Hasil Studi | Menginput nilai akhir semester dari dosen pengajar dan menerbitkan Kartu Hasil Studi (KHS). |

## 3. Dokumen sumber yang dianalisis

=================================================================
KARTU RENCANA STUDI (KRS)
SEMESTER GANJIL 2026/2027
NIM           : 25430082            Semester    : 3
Nama Mahasiswa: Chantika R. B. P.   DPA         : DOS-002 (Dr. Aris)
Program Studi : S1 Ilmu Komputer    Tgl Cetak   : 05-10-2026
[Kode MK]   [Nama Mata Kuliah]    [SKS]  [Kelas]  [Dosen Pengajar]
IF-201      Basis Data Lanjut       3       A     Prof. Budi
IF-202      Pemrograman Web         3       B     Dr. Siti
IF-203      Struktur Data           3       A     Ir. Eko
IF-204      Etika Profesi           2       C     Dra. Ani
-----------------------------------------------------------------
Total SKS Diambil: 11 SKS (Maksimal Matakuliah Pilihan: 4)
=================================================================

**Tabel Bedahan Dokumen Sumber:**

| Elemen pada Dokumen KRS | Entitas Tujuan | Nama Elemen Data di Database |
| :--- | :--- | :--- |
| NIM & Nama Mahasiswa | Mahasiswa | `nim`, `nama_mahasiswa` |
| DPA (ID & Nama) | Dosen | `id_dosen`, `nama_dosen` |
| Kode MK & Nama Mata Kuliah | Mata_Kuliah | `kode_mk`, `nama_mk` |
| Kelas & SKS | Kelas | `id_kelas`, `sks` |
| No/ID & Tgl Pengajuan KRS | KRS | `id_krs`, `tgl_pengajuan` |
| Item Kelas yang Diambil | Detail_KRS | `id_detail_krs` |

## 4. Entitas kandidat dan elemen data

1. **`Mahasiswa`**: `nim`, `nama_mahasiswa`, `prodi`, `id_dpa`
2. **`Dosen`**: `id_dosen`, `nidn`, `nama_dosen`, `email`
3. **`Mata_Kuliah`**: `kode_mk`, `nama_mk`, `sks`
4. **`Kelas`**: `id_kelas`, `kode_mk`, `nama_kelas`, `id_dosen`
5. **`KRS`**: `id_krs`, `nim`, `tahun_ajaran`, `semester`, `tgl_pengajuan`, `status_approval`
6. **`Detail_KRS`**: `id_detail_krs`, `id_krs`, `id_kelas`, `nilai_akhir`

## 5. Aturan bisnis                       (tabel AB-xx)

| Kode AB | Deskripsi Aturan Bisnis |
| :--- | :--- |
| **AB-01** | Setiap mahasiswa dibimbing oleh tepat **1 Dosen Pembimbing Akademik (DPA)**. |
| **AB-02** | Pengisian KRS hanya dapat dilakukan jika status registrasi pembayaran mahasiswa telah aktif. |
| **AB-03** | Dalam satu transaksi pengisian KRS, mahasiswa dapat mengambil maksimal **4 mata kuliah pilihan** ($P + 2 = 4$). |
| **AB-04** | Keterlambatan pengisian KRS berakibat pada penonaktifan status mahasiswa. Mahasiswa dikenakan biaya administrasi **Rp2.000 / lembar** ($P$ dalam ribuan) untuk setiap pencetakan ulang KHS/KRS fisik. |
| **AB-05** | Satu kelas mata kuliah diselenggarakan oleh **1 Dosen Pengajar**. |
| **AB-06** | Mahasiswa tidak dapat mengambil dua kelas yang memiliki jadwal bentrok. |
| **AB-07** | Pengajuan KRS wajib mendapatkan persetujuan (*approval*) dari DPA sebelum perkuliahan dimulai. |
| **AB-08** | Nilai akhir semester diinput oleh Dosen Pengajar paling lambat 14 hari setelah masa Ujian Akhir Semester. |  

## 6. Kebutuhan informasi                 (tabel KI-xx)

| Kode KI | Deskripsi Kebutuhan Informasi | Elemen Data yang Ditampilkan |
| :--- | :--- | :--- |
| **KI-01** | Lembar Kartu Rencana Studi (KRS) | `nim`, `nama_mahasiswa`, `kode_mk`, `nama_mk`, `sks`, `nama_kelas`, `status_approval` |
| **KI-02** | Kartu Hasil Studi (KHS) Semesteran | `nim`, `nama_mahasiswa`, `semester`, `nama_mk`, `sks`, `nilai_akhir` |
| **KI-03** | Daftar Hadir dan Peserta Kelas | `id_kelas`, `nama_mk`, `nama_kelas`, `nim`, `nama_mahasiswa` |
| **KI-04** | Laporan Beban Mengajar Dosen | `id_dosen`, `nama_dosen`, `nama_mk`, `nama_kelas`, `sks` |
| **KI-05** | Rekapitulasi Pengajuan KRS per Tahun Ajaran | `id_krs`, `tahun_ajaran`, `semester`, `nim`, `nama_mahasiswa`, `tgl_pengajuan` |

## 7. Matriks CRUD

| Kode PB | Nama Proses Bisnis | Mahasiswa | Dosen | Mata_Kuliah | Kelas | KRS | Detail_KRS |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** | Pendataan Mahasiswa & Dosen | C, R, U | C, R, U | - | - | - | - |
| **PB-02** | Pengelolaan Kurikulum & Kelas | - | R | C, R, U, D | C, R, U, D | - | - |
| **PB-03** | Pengisian & Perubahan KRS | R | R, U | R | R | C, R, U, D | C, R, U, D |
| **PB-04** | Pencatatan Nilai & Hasil Studi | R | R, U | R | R | R | R, U |

## 8. Kamus data awal                     (dengan penanggung jawab)

| Elemen | Arti | Contoh | Aturan | Penanggung jawab |
| :--- | :--- | :--- | :--- | :--- |
| `nim` | NIM Mahasiswa | 25430082 | Unik, 8 digit | Staf Akademik |
| `nama_mahasiswa` | Nama lengkap mahasiswa | Chantika R. B. P. | Teks, data pribadi | Staf Akademik |
| `prodi` | Program studi mahasiswa | S1 Ilmu Komputer | Teks | Staf Akademik |
| `id_dpa` | ID Dosen Pembimbing Akademik | DOS-002 | Format ID Dosen valid | Staf Akademik |
| `id_dosen` | ID Dosen | DOS-001 | Unik, format DOS-3digit | Staf Kepegawaian |
| `nidn` | Nomor Induk Dosen Nasional | 0012038001 | Unik, 10 digit | Staf Kepegawaian |
| `nama_dosen` | Nama lengkap dosen beserta gelar | Dr. Aris, M.Kom. | Teks | Staf Kepegawaian |
| `email` | Email resmi institusi dosen | aris@kampus.ac.id | Format email valid | Staf Kepegawaian |
| `kode_mk` | Kode mata kuliah | IF-201 | Unik, format KMK-3digit | Program Studi |
| `nama_mk` | Nama mata kuliah | Basis Data Lanjut | Teks | Program Studi |
| `sks` | Jumlah SKS mata kuliah | 3 | Bilangan bulat 1-6 | Program Studi |
| `id_kelas` | ID Kelas perkuliahan | KLS-101 | Unik per semester | Staf Akademik |
| `nama_kelas` | Kode kelas paralel | A | Karakter (A/B/C) | Staf Akademik |
| `id_krs` | ID Transaksi pengajuan KRS | KRS-2026-001 | Unik per pengajuan | Staf Akademik |
| `tahun_ajaran` | Tahun ajaran perkuliahan | 2026/2027 | Format YYYY/YYYY | Staf Akademik |
| `semester` | Semester berjalan | 3 | Bilangan bulat 1-8 | Staf Akademik |
| `tgl_pengajuan` | Tanggal pengajuan KRS | 2026-10-05 | Format YYYY-MM-DD | Staf Akademik |
| `status_approval` | Status persetujuan DPA | Disetujui | Draf / Disetujui / Ditolak | DPA |
| `id_detail_krs` | ID detail pengambilan kelas | 1001 | Unik, auto-increment | Staf Akademik |
| `nilai_akhir` | Nilai mutu huruf hasil studi | A | Huruf mutu (A/B/C/D/E), data pribadi | Dosen Pengajar |

## 9. Kebutuhan Non-Fungsional Data

* **Volume Data:** Sistem dikondisikan untuk menangani lalu lintas pengisian KRS hingga **50 transaksi harian** per siklus registrasi ($40 + 5 \times 2 = 50$).
* **Retensi Data:** Data riwayat KRS, KHS, dan nilai akademik disimpan secara permanen selama mahasiswa aktif dan minimal 7 tahun setelah kelulusan untuk keperluan akreditasi institusi.
* **Identifikasi Data Pribadi dan Hak Akses:**

  **1. Elemen Data Pribadi / Sensitif:**
  - **Identitas Mahasiswa:** `nama_mahasiswa`, `prodi` (Data Identitas Diri)
  - **Identitas Dosen:** `nama_dosen`, `email`, `nidn` (Data Identitas Pengajar)
  - **Data Hasil Evaluasi:** `nilai_akhir` (Data Sensitif Prestasi Akademik)

  **2. Matriks Otorisasi / Hak Akses Data:**

  | Elemen Data Pribadi | Aktor yang Boleh Mengakses | Tingkat Hak Akses | Keterangan / Batasan |
  | :--- | :--- | :--- | :--- |
  | `nama_mahasiswa`, `prodi` | Mahasiswa, Staf Akademik | **Read / Update** | Mahasiswa hanya dapat mengubah profil milik sendiri. |
  | | Dosen Pengajar, DPA | **Read Only** | Untuk verifikasi identitas di kelas / bimbingan. |
  | `nama_dosen`, `email`, `nidn` | Dosen, Staf Kepegawaian | **Read / Update** | Dosen hanya dapat mengedit profil milik sendiri. |
  | | Mahasiswa, Staf Akademik | **Read Only** | Informasi kontak publik untuk perkuliahan. |
  | `nilai_akhir` | Dosen Pengajar | **Create / Read / Update** | Dosen hanya menginput/mengubah nilai pada kelas yang diampu. |
  | | Mahasiswa Bersangkutan | **Read Only** | Mahasiswa hanya melihat nilai miliknya sendiri (KHS). |
  | | DPA & Staf Akademik | **Read Only** | Untuk keperluan evaluasi akademik dan transparansi. |

## 10. Isu kualitas data yang diantisipasi

* **Validasi Range Nilai Mutu:** Nilai akhir diatur hanya menerima masukan huruf mutu yang valid (`A`, `B`, `C`, `D`, `E`).
* **Pencegahan SKS Melebihi Batas:** Sistem menolak otomatis pengajuan KRS jika jumlah SKS yang diambil melebihi jatah maksimum berdasarkan akumulasi SKS semester sebelumnya.
