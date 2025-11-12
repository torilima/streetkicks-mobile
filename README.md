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


Tugas 8 
1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
= Push ibaratnya menambahkan halaman baru ke atas tumpukan halaman yang sudah ada. pushReplacement sama fungsinya menambahkan halaman baru tapi dia langsung membuang halaman yang lama dari tumpukan navigasi
push dapat digunakan di halaman utama, misalnya ketika pengguna ingin melihat daftar produk, dengan menekan back akan langsung kembali ke halaman utama, kalau pushReplacement saat tidak mau mendirect ke halaman sebelumnya, misalnya halaman login ke homepage, setelah login berhasil dilakukan maka langsung ke home page dan tidak ada opsi back ke halaman sebelumnya 

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
= saya memanfaatkan scaffold sebagai kerangka kosong dari sebuah halaman dengan menyediakan slot slot standar, appBar untuk bagian atas, drawer untuk bagian popup dari samping, body untuk konten utama, scaffolf digunakan untuk setiap halaman memiliki struktur dasar yang sama 
AppBar digunakan sebagai header konsisten dari setiap halaman, dengan memberikan ketinggian padding yang sesuai 
Drawer ini sebagai komponen yang dapat digunakan berulang, tidak membuat baru di setiap halaman tetapi langsung satu file drawer khusus 

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
= kelebihannya adalah menciptakan desain yang rapi, mudah dikontrol, dan user experience yang baik 
Di bagian Product Form saya menerapkan padding untuk setiap field pada proses add product saya 
SingleChildScrollView ini untuk mengatasi layar yang terpotong atau tertutup keyboard (di handphone atau ipad), saya menerapkan bagian ini pada bagian child di ProductFormPage
ListView pada dasarnya sudah ada bawaan column dan singlechildscrollview yang digabung menjadi satu, dia bisa langsung membuat daftar children yang bisa discroll secara otomatis, dikode saya menerapkan SingleChildScrollView dan itu sebenarnya bisa saja diubah ke ListView

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
= Saya menggunakan warna yang cukup kontras, namun masih nyaman dipandang mata agar pengguna tetap nyaman, untuk pemilihan warna saya menggunakan Biru, Merah, Kuning (mencerminkan fasilkom ui asik) sebagai warna utama dari aplikasi saya, pemilihan warna ini menurut saya cukup oke sebagai identitas dari aplikasi saya.

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
