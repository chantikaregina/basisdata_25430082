# Dokumen Kebutuhan Data - Sistem Informasi Akademik (SIAKAD)

## 1. Latar Belakang dan Aktivitas Organisasi
Sistem Informasi Akademik (SIAKAD) merupakan sistem administrasi utama di perguruan tinggi yang mengelola siklus pendidikan mahasiswa. Aktivitas utama mencakup pendataan mahasiswa dan dosen, perencanaan mata kuliah melalui Kartu Rencana Studi (KRS), penilaian akhir semester, serta penerbitan Kartu Hasil Studi (KHS) dan transkrip nilai.

## 2. Aktor dan Proses Bisnis

| Kode PB | Aktor Terlibat | Nama Proses Bisnis | Deskripsi |
| :--- | :--- | :--- | :--- |
| **PB-01** | Operator Akademik | Pendataan Mahasiswa & Dosen | Mengelola data identitas mahasiswa, dosen pembimbing akademik (PA), dan status keaktifan. |
| **PB-02** | Mahasiswa, Dosen PA | Perencanaan Studi (KRS) | Memproses pengisian Rencana Studi oleh mahasiswa dan persetujuan (acc) oleh Dosen PA. |
| **PB-03** | Dosen Pengampu | Penginputan Nilai Akademik | Memasukkan nilai tugas, UTS, dan UAS mahasiswa per mata kuliah yang diampu. |
| **PB-04** | Mahasiswa, Kaprodi | Pelaporan Akademik & KHS | Menyusun dan mencetak Kartu Hasil Studi (KHS) semesteran serta rekap IPK. |

## 3. Dokumen Sumber yang Dianalisis

Dokumen sumber utama yang dianalisis adalah **Formulir Rencana Studi (FRS) Fiktif** yang diisi mahasiswa saat registrasi semester.

**Rancangan FRS / Bukti KRS Fiktif:**

```text
=================================================================
             FORMULIR RENCANA STUDI (FRS) FAKULTAS
=================================================================
NIM         : 25430082              Semester      : Ganjil 2026/2027
Nama        : Chantika R. B. P.     Dosen PA      : Dr. Eng. Heri, M.T.
Prodi       : S1 Sistem Informasi   Max SKS Boleh : 24 SKS
-----------------------------------------------------------------
[Kode MK]   [Nama Mata Kuliah]          [SKS]   [Jadwal/Kelas]
INF-101     Basis Data                    3     Senin, 08:00 (A)
INF-102     Pemrograman Web               3     Selasa, 10:00 (A)
INF-103     Algoritma & Struktur Data     4     Rabu, 13:00 (B)
INF-104     Jaringan Komputer             3     Kamis, 08:00 (A)
-----------------------------------------------------------------
Total SKS Diambil : 13 SKS
Status Persetujuan : DISETUJUI (APPROVED) oleh Dosen PA
=================================================================
```

**Tabel Bedahan Dokumen Sumber:**

| Elemen pada Dokumen FRS | Entitas Tujuan | Nama Elemen Data di Database |
| :--- | :--- | :--- |
| NIM & Nama Mahasiswa | Mahasiswa | `nim`, `nama_mahasiswa` |
| ID & Nama Dosen PA | Dosen | `nip_dosen`, `nama_dosen` |
| Kode & Nama Mata Kuliah | Mata_Kuliah | `kode_mk`, `nama_mk` |
| SKS Mata Kuliah | Mata_Kuliah | `sks` |
| Semester & Status ACC | KRS | `semester`, `status_acc` |
| Item MK yang Diambil | Detail_KRS | `id_detail_krs`, `kode_mk` |

## 4. Entitas Kandidat dan Elemen Data

1. **`Mahasiswa`**: `nim`, `nama_mahasiswa`, `prodi`, `nip_pa`, `status_aktif`, `nik_mahasiswa`
2. **`Dosen`**: `nip_dosen`, `nama_dosen`, `email_dosen`, `no_hp_dosen`
3. **`Mata_Kuliah`**: `kode_mk`, `nama_mk`, `sks`, `semester_penawaran`
4. **`KRS`**: `id_krs`, `nim`, `semester`, `tahun_ajaran`, `status_acc`, `tgl_pengajuan`
5. **`Detail_KRS`**: `id_detail_krs`, `id_krs`, `kode_mk`
6. **`Nilai`**: `id_nilai`, `id_detail_krs`, `nilai_angka`, `nilai_huruf`

## 5. Aturan Bisnis

| Kode AB | Deskripsi Aturan Bisnis |
| :--- | :--- |
| **AB-01** | Setiap mahasiswa terdaftar memiliki **NIM unik** dan tepat dibimbing oleh 1 Dosen PA. |
| **AB-02** | Pengisian KRS hanya dapat disetujui (ACC) oleh Dosen PA yang bersangkutan. |
| **AB-03** | Jumlah SKS maksimum yang dapat diambil mahasiswa ditentukan oleh IPS semester sebelumnya (maksimal 24 SKS). |
| **AB-04** | Mata kuliah yang diambil dalam satu KRS tidak boleh memiliki jadwal/jam bentrok. |
| **AB-05** | Dosen Pengampu hanya dapat menginput nilai untuk mahasiswa yang terdaftar di `Detail_KRS`. |
| **AB-06** | Bobot nilai huruf dikonversi otomatis: A=4.0, B=3.0, C=2.0, D=1.0, E=0.0. |
| **AB-07** | Mahasiswa dengan status "Cuti" atau "Non-Aktif" tidak diizinkan melakukan pengisian KRS. |
| **AB-08** | Nilai yang telah difinalisasi oleh Dosen Pengampu tidak dapat diubah tanpa persetujuan tertulis dari Kaprodi. |

## 6. Kebutuhan Informasi

| Kode KI | Deskripsi Kebutuhan Informasi | Elemen Data yang Ditampilkan |
| :--- | :--- | :--- |
| **KI-01** | Cetak Kartu Rencana Studi (KRS) | `nim`, `nama_mahasiswa`, `nama_mk`, `sks`, `status_acc` |
| **KI-02** | Cetak Kartu Hasil Studi (KHS) | `nim`, `nama_mahasiswa`, `nama_mk`, `sks`, `nilai_huruf`, `ips` |
| **KI-03** | Transkrip Nilai Kumulatif | `nim`, `nama_mahasiswa`, `total_sks`, `ipk_kumulatif` |
| **KI-04** | Daftar Bimbingan Akademik Dosen | `nip_dosen`, `nama_dosen`, `nim`, `nama_mahasiswa`, `status_acc` |
| **KI-05** | Rekapitulasi Nilai Per Mata Kuliah | `kode_mk`, `nama_mk`, `nim`, `nama_mahasiswa`, `nilai_angka`, `nilai_huruf` |

## 7. Matriks CRUD

| Kode PB | Nama Proses Bisnis | Mahasiswa | Dosen | Mata_Kuliah | KRS | Detail_KRS | Nilai |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** | Pendataan Mahasiswa & Dosen | C, R, U | C, R, U | - | - | - | - |
| **PB-02** | Perencanaan Studi (KRS) | R | R | R | C, R, U | C, R, D | - |
| **PB-03** | Penginputan Nilai Akademik | - | R | R | R | R | C, R, U |
| **PB-04** | Pelaporan Akademik & KHS | R | R | R | R | R | R |

## 8. Kamus Data Awal

| Elemen | Arti | Contoh | Aturan | Penanggung jawab |
| :--- | :--- | :--- | :--- | :--- |
| `nim` | Nomor Induk Mahasiswa | 25430082 | Unik, 8 digit angka | BAAK / Admin |
| `nama_mahasiswa` | Nama lengkap mahasiswa | Chantika R. B. P. | Teks | BAAK / Admin |
| `prodi` | Program studi mahasiswa | Sistem Informasi | Teks | BAAK / Admin |
| `nip_pa` | NIP Dosen PA | 198501xxxx | Unik | BAAK / Admin |
| `status_aktif` | Status keaktifan | Aktif | Enum (Aktif/Cuti/DO) | BAAK / Admin |
| `nik_mahasiswa` | NIK sesuai KTP | 1871xxxxxxxx | Unik, 16 digit (Privat) | BAAK / Admin |
| `nip_dosen` | NIP dosen | 197802xxxx | Unik | Kepegawaian |
| `nama_dosen` | Nama lengkap dosen | Dr. Eng. Heri | Teks | Kepegawaian |
| `email_dosen` | Email resmi kampus | dosen@univ.ac.id | Format email | Kepegawaian |
| `no_hp_dosen` | Nomor telepon dosen | 0812xxxx | Format angka | Kepegawaian |
| `kode_mk` | Kode mata kuliah | INF-101 | Unik, alphanumeric | Kaprodi |
| `nama_mk` | Nama mata kuliah | Basis Data | Teks | Kaprodi |
| `sks` | Bobot kredit SKS | 3 | Angka 1 - 6 | Kaprodi |
| `semester_penawaran` | Semester penawaran | 3 | Angka 1 - 8 | Kaprodi |
| `id_krs` | ID dokumen KRS | KRS-20261-01 | Unik | Operator |
| `semester` | Semester akademik | Ganjil 2026/2027 | Teks | Operator |
| `status_acc` | Status persetujuan PA | Disetujui | Enum (Pending/Disetujui) | Dosen PA |
| `id_detail_krs` | ID baris matkul KRS | D-1002 | Unik | Operator |
| `nilai_angka` | Nilai mentah angka | 85.5 | Angka 0 - 100 | Dosen Pengampu |
| `nilai_huruf` | Konversi nilai huruf | A | Char (A/B/C/D/E) | Dosen Pengampu |

## 9. Kebutuhan Non-Fungsional Data

* **Volume Data:** Estimasi beban sistem disiapkan untuk menangani pengisian KRS sekitar **50 transaksi per hari** pada puncak masa registrasi ($40 + 5 \times 2 = 50$).
* **Retensi Data:** Berkas riwayat KRS, KHS, dan nilai akademik disimpan permanen selama status mahasiswa masih aktif, serta minimal disimpan 7 tahun setelah lulus untuk keperluan rekap akreditasi kampus.
* **Identifikasi Data Pribadi dan Hak Akses:**

  **1. Elemen Data Pribadi / Sensitif:**
  - **Identitas Mahasiswa:** `nama_mahasiswa`, `prodi` (Data Identitas Diri)
  - **Identitas Dosen:** `nama_dosen`, `email`, `nidn` (Data Kontak & Pengajar)
  - **Data Hasil Evaluasi:** `nilai_akhir` (Data Sensitif Prestasi)

  **2. Matriks Otorisasi / Hak Akses Data:**

  | Elemen Data Pribadi | Aktor yang Boleh Mengakses | Tingkat Hak Akses | Keterangan / Batasan |
  | :--- | :--- | :--- | :--- |
  | `nama_mahasiswa`, `prodi` | Mahasiswa, Staf Akademik | **Read / Update** | Mahasiswa cuma bisa ubah data profil miliknya sendiri. |
  | | Dosen Pengajar, DPA | **Read Only** | Buat verifikasi identitas saat perkuliahan atau bimbingan. |
  | `nama_dosen`, `email`, `nidn` | Dosen, Staf Kepegawaian | **Read / Update** | Dosen cuma bisa edit profil miliknya sendiri. |
  | | Mahasiswa, Staf Akademik | **Read Only** | Informasi kontak pengajar yang dibuka untuk keperluan perkuliahan. |
  | `nilai_akhir` | Dosen Pengampu | **Create / Read / Update** | Dosen cuma bisa input atau ubah nilai pada kelas yang diampu. |
  | | Mahasiswa Bersangkutan | **Read Only** | Mahasiswa cuma bisa lihat nilai KHS miliknya sendiri. |
  | | DPA & Staf Akademik | **Read Only** | Dipakai untuk monitoring perkembangan akademik dan transparansi. |
  
## 10. Isu Kualitas Data yang Diantisipasi

- **Pencegahan SKS Overload:** Sistem menolak secara otomatis jika total SKS yang diinput di `Detail_KRS` melebihi jatah `Max SKS` mahasiswa.
- **Mata Kuliah Ganda:** Mencegah mahasiswa mengambil `kode_mk` yang sama lebih dari satu kali dalam semester yang sama.