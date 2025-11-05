# street_kicks

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Tugas 7 
1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
= Widget Tree adalah struktur seperti pohon yang menggambarkan seluruh widget yang ditampilkan pada aplikasi Flutter. Widget itu terhubung dengan cara kerja parent-child yang dimana parent adalah widget yang membungkus dan child adalah widget yang berada dalam widget lain

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
= MaterialApp - widget akar/ widget utama yang fungsinya untuk membungkus seluruh halaman, mengatur tema, dan navigasi antar halaman
Scaffold - Menyediakan kerangka desain untuk satu halaman
StatelessWidget - Untuk widget yang tampilannya tidak akan pernah berubah setelah dibuat
StatefulWidget - Untuk widget yang tampilannya perlu diperbarui secara dinamis
Container - Widget "kotak serbaguna" yang digunakan untuk mengatur width, height, color, padding, margin, dan decoration 
Column - Menyusun daftar children secara vertikal
Row - Menyusun daftar children secara horizontal

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
= widget utama yang dipakai sebagai root aplikasi yang menyediakan struktur dasar aplikasi 

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
= Stateless Widget : widget yang tampilannya tidak berubah walau ada interaksi 
Statefull Widget : digunakan untuk widget yang tampilannya statis yang dapat berubah ubah tanpa perlu refresh 
stateless digunakan saat tampilan statis dan stateful digunakan saat ada perubahan data 

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
= BuildContext itu identitas dari posisi widget. Flutter butuh ini untuk tahu dimana posisi widget berada, agar bisa akses widget, tema, atau navigasi. Biasanya digunakan dalam method build untuk panggil widget lain

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
= Hot reload - update kode yang berubah langsung tanpa ngulang dari awal
Hot Restrat - restart dari awal aplikasi, semua data dan state balik ke kondisi awal 
digunakan saat perubahan di kode tidak bisa ke reload langsung
