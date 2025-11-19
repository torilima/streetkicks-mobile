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

Tugas 9 
1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
= Karena model berfungsi sebagai kontrak data yang aman dan terstruktur. Kalau langsung memetakan Map<String, dynamic> kita kehilangan 
validasi tipe yang ketat, meningkatkan risiko runtime error jika tipe data dari server tidak sesuai dengan ekspektasi. Selain itu, implementasi null safety menjadi rumit dan tersebar, dan maintainability kode menurun drastis karena kita harus terus-menerus menggunakan "magic string" untuk mengakses properti, dan setiap perubahan nama kunci di backend akan sulit dilacak dan diperbaiki, berlawanan dengan model di mana kompiler dapat membantu menemukan semua tempat yang perlu diubah.

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
= Package http berfungsi sebagai fondasi utama untuk semua komunikasi jaringan, menyediakan metode dasar seperti get() dan post() untuk 
mengirim dan menerima data dari server melalui protokol HTTP. Sementara itu, CookieRequest (seringkali kelas pembantu) memiliki peran yang 
lebih spesifik, yaitu mengelola cookie, membungkus fungsionalitas dasar http untuk secara otomatis memastikan cookie sesi disertakan dalam permintaan yang dikirim dan diproses dari respons yang diterima, sehingga membedakannya sebagai alat khusus untuk otentikasi berbasis sesi.

3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
= Instance CookieRequest perlu dibagikan ke semua komponen dalam aplikasi Flutter, biasanya melalui mekanisme State Management atau Dependency 
Injection, karena tujuannya adalah untuk mempertahankan sesi pengguna secara konsisten di seluruh aplikasi. Jika setiap komponen membuat 
instance CookieRequest yang baru, cookie sesi yang berisi informasi otentikasi dari respons login tidak akan dibawa atau dibagikan secara 
efektif. Dengan membagikan instance yang sama, kita memastikan bahwa setiap permintaan HTTP yang dilakukan oleh komponen mana pun di aplikasi 
akan secara otomatis menyertakan cookie otentikasi yang sama dan terkini, memungkinkan server mengenali dan melayani pengguna sebagai pengguna
 yang sudah terotentikasi tanpa harus login berulang kali.

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
= Konfigurasi konektivitas agar Flutter dapat berkomunikasi dengan backend Django memerlukan penyesuaian di sisi server dan client. Di sisi Django, kita harus menambahkan alamat 10.0.2.2 ke dalam daftar ALLOWED_HOSTS karena alamat ini adalah IP khusus yang digunakan oleh emulator Android untuk merujuk pada localhost tempat server Django berjalan; Kita juga perlu mengaktifkan CORS (Cross-Origin Resource Sharing) karena permintaan dari Flutter/emulator dianggap sebagai origin yang berbeda, dan tanpa izin CORS, browser atau mesin runtime akan memblokir respons.
Pengaturan SameSite/cookie perlu disesuaikan agar cookie otentikasi dapat diterima dan dikirim kembali oleh aplikasi client dalam konteks cross-site. Sementara itu, di sisi Android, izin akses internet harus ditambahkan di AndroidManifest.xml agar aplikasi diizinkan menggunakan jaringan.

5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
= Mekanisme ini dimulai di Flutter ketika data dimasukkan oleh pengguna dan dikonversi dari input menjadi Model Dart, lalu diubah menjadi format JSON sebelum dikirim melalui Permintaan HTTP ke backend. Di sisi Server, permintaan diterima, data JSON diubah kembali, diproses sesuai logika, dan kemudian disimpan ke Database. Setelah pemrosesan selesai, server mengirimkan Respons HTTP yang berisi kode status sukses dan data terbaru. Aplikasi Flutter menerima respons ini, memverifikasi status, mengubah data JSON kembali menjadi Model Dart, dan menggunakan data model tersebut untuk memperbarui state aplikasi. Pembaharuan state ini secara otomatis memicu widget terkait untuk di-rebuild, sehingga data yang baru dikirim atau diperbarui dapat ditampilkan kepada pengguna.

6.  Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
= Mekanisme autentikasi (login, register, logout) dimulai di Flutter saat pengguna memasukkan data akun. Pada proses Register, data diubah menjadi JSON dan dikirim melalui Permintaan POST ke endpoint pendaftaran Django. Django memvalidasi data, membuat user baru di database, dan merespons dengan kode status sukses. Untuk Login, data kredensial dikirim via POST. Django memverifikasi kecocokan username dan password, dan jika valid, Django akan membuat dan mengirimkan Session Cookie ke Flutter dalam responsnya. Instance CookieRequest di Flutter menangkap dan menyimpan cookie ini. Setelah login berhasil, Flutter menggunakan cookie yang tersimpan ini dalam setiap permintaan selanjutnya untuk otentikasi. Akhirnya, proses Logout dilakukan dengan mengirimkan permintaan ke endpoint logout Django, server membatalkan sesi terkait dan merespons, yang kemudian memicu Flutter untuk menghapus cookie sesi yang disimpan dan mengubah state aplikasi, sehingga menu utama aplikasi ditampilkan atau beralih ke layar login, menandakan selesainya proses autentikasi.

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
= implementasi saya tidak banyak berbeda dengan tutorial, hanya saja saya sempat memiliki masalah yaitu tidak bisa menggunakan menu login dan register karena kesalahan redirect pada main.dart, lalu pada saat product list dan add product juga product tidak langsung direct ke page product list dan di product listnya tidak muncul






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
