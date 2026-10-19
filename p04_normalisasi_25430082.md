# Dokumen Normalisasi - Sistem Informasi Akademik (SIAKAD)
**NIM:** 25430082  
**Nama:** Chantika Regina Bria Putri  

---

## 1. Bentuk Tidak Normal (UNF)
Dokumen sumber yang dianalisis adalah **Formulir Rencana Studi (FRS)**. Pada bentuk UNF, terdapat kelompok data berulang (*repeating group*) berupa daftar mata kuliah yang diambil dalam satu FRS:

`FRS_UNF(nim, nama_mahasiswa, prodi, nip_pa, nama_dosen, semester, status_acc, {kode_mk, nama_mk, sks})`

---

## 2. Bentuk Normal Pertama (1NF)
Menghilangkan grup berulang dengan memecah baris menjadi atomik (satu mata kuliah per baris).

`FRS_1NF(nim, kode_mk, semester, nama_mahasiswa, prodi, nip_pa, nama_dosen, status_acc, nama_mk, sks)`
- **Kunci Primer Komposit:** `(nim, kode_mk, semester)`

---

## 3. Dependensi Fungsional (FD)
Aturan ketergantungan antar kolom berdasarkan aturan bisnis:
- **FD1:** `nim` -> `nama_mahasiswa, prodi, nip_pa` (sesuai AB-01)
- **FD2:** `nip_dosen` -> `nama_dosen, email_dosen, no_hp_dosen`
- **FD3:** `kode_mk` -> `nama_mk, sks, semester_penawaran`
- **FD4:** `id_krs` -> `nim, semester, tahun_ajaran, status_acc`
- **FD5:** `id_detail_krs` -> `id_krs, kode_mk`
- **FD6:** `id_nilai` -> `id_detail_krs, nilai_angka, nilai_huruf` (sesuai AB-05, AB-06)

---

## 4. Bentuk Normal Kedua (2NF)
Menghilangkan ketergantungan parsial (atribut yang hanya bergantung pada sebagian kunci komposit):
1. **`Mahasiswa`**: (`nim`, `nama_mahasiswa`, `prodi`, `nip_pa`)
2. **`Dosen`**: (`nip_dosen`, `nama_dosen`)
3. **`Mata_Kuliah`**: (`kode_mk`, `nama_mk`, `sks`)
4. **`Detail_KRS_2NF`**: (`nim`, `kode_mk`, `semester`, `status_acc`)

---

## 5. Bentuk Normal Ketiga (3NF) & BCNF
Menghilangkan ketergantungan transitif (kolom non-kunci yang bergantung pada kolom non-kunci lain) dan membentuk skema relasional kanonik akhir:

1. **`dosen`**
   - **Primary Key:** `nip_dosen`
   - **Kolom:** `nama_dosen`, `email_dosen`, `no_hp_dosen`

2. **`mahasiswa`**
   - **Primary Key:** `nim`
   - **Foreign Key:** `nip_pa` (merujuk ke `dosen.nip_dosen`)
   - **Kolom:** `nama_mahasiswa`, `prodi`, `status_aktif`, `nik_mahasiswa`

3. **`mata_kuliah`**
   - **Primary Key:** `kode_mk`
   - **Kolom:** `nama_mk`, `sks`, `semester_penawaran`

4. **`krs`**
   - **Primary Key:** `id_krs`
   - **Foreign Key:** `nim` (merujuk ke `mahasiswa.nim`)
   - **Kolom:** `semester`, `tahun_ajaran`, `status_acc`, `tgl_pengajuan`

5. **`detail_krs`**
   - **Primary Key:** `id_detail_krs`
   - **Foreign Key:** `id_krs` (merujuk ke `krs.id_krs`), `kode_mk` (merujuk ke `mata_kuliah.kode_mk`)

6. **`nilai`**
   - **Primary Key:** `id_nilai`
   - **Foreign Key:** `id_detail_krs` (merujuk ke `detail_krs.id_detail_krs`)
   - **Kolom:** `nilai_angka`, `nilai_huruf`

---

## Tabel Ringkasan Tahapan Normalisasi SIAKAD

| Tahap Normalisasi | Bentuk / Relasi | Keterangan / Aturan Utama |
| :--- | :--- | :--- |
| **UNF** (Unnormalized) | `FRS_UNF(nim, nama, ..., {kode_mk, nama_mk, sks})` | Masih ada grup berulang (daftar mata kuliah numpuk jadi satu). |
| **1NF** (First Normal Form) | `FRS_1NF(nim, kode_mk, semester, ...)` | Nilai atomik, grup berulang dipecah. PK komposit: `(nim, kode_mk, semester)`. |
| **2NF** (Second Normal Form) | `Mahasiswa`, `Dosen`, `Mata_Kuliah`, `Detail_KRS` | Bebas dari ketergantungan parsial (atribut bergantung penuh pada *primary key*). |
| **3NF** (Third Normal Form) | Relasi final 6 tabel (normalisasi penuh) | Bebas dari ketergantungan transitif. Nilai turunan (IPK/IPS) dihitung dinamis. |

---

## 6. Keputusan Nilai Turunan
- **IPK / IPS:** Tidak disimpan di tabel operasional. Nilai ini dihitung dinamis menggunakan kueri agregasi SQL (`SUM(sks * bobot) / SUM(sks)`) saat cetak KHS/Transkrip untuk menghindari timbulnya data tidak konsisten saat nilai diperbarui.