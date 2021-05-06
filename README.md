# Ecommerce Mobile

Aplikasi Versi Mobile untuk Seamless Vendor Onboarding. Hasil Kolaborasi bersama Generasi Teknik Informatika UNSRI

## Getting Started

Project ini dibuat menggunakan Flutter+Dart dengan BLOC Pattern untuk State Management dan Reactive Approach. 

### IDE Recommendation
Untuk mempermudah proses development dan cocok untuk spesifikasi hardware development yang minim, disarankan menggunakan __Visual Code__. 

#### VSCODE Extension
Beberapa extensi yang wajib dan optional untuk Flutter Development.

__Required:__
- _dart-code.dart-code_
- *dart-code.flutter*
- *felixangelov.bloc*
- *jeroen-meijer.pubspec-assist*
- *luanpotter.dart-import*

__Optional:__
- nash.awesome-flutter-snippets
- coenraads.bracket-pair-colorizer-2
- wmaurer.change-case
- circlecodesolution.ccs-flutter-color
- gruntfuggly.todo-tree
- shan.code-settings-sync


### BLOC Pattern
BLOC Pattern terdiri diri 4 layer utama dan flow yang terintegrasi:

![Bloc Pattern](https://i.imgur.com/VmvyPX0.jpeg)

#### Layer 1 : User Interface 
Pada layer ini, berisi semua Additional Widget dan User Interface Widget yang dapat dilihat oleh User. Pada layer ini juga terjadi interaksi terhadap User

#### Layer 2 : BLOC, Cubit | _Presenter_
Semua Business Logic berada pada Layer ini. Perlu diperhatikan bahwa layer ini tidak boleh mengkonsumsi UI, karena justru layer ini yang akan dikonsumsi oleh UI. 
- **BLOC**: Digunakan untuk Logic yang Kompleks dan ingin mengelola Event yang dikirimkan untuk melakukan sebuah proses
- **Cubit**: Digunakan untuk Logic yang sederhana, Cubit tidak membutuhkan event.

#### Layer 3 : Domain | _Data Handler_
Pengelolaan Data yang didapatkan dari Data Provider. Layer ini digunakan untuk membantu pengelolaan data antara server dan local storage

#### Layer 4 : Dao, Repository | _Data Provider_
Layer ini akan melakukan request dan terhubung ke Backend.
- **Dao**: Data Access Object. Bertugas untuk mengelola data pada local storage. Contoh: Sqlite atau Hive (NoSql).
- **Repository**: Helper untuk melakukan request ke Network / Restful API

### Project Architecture

![Project Architecture](https://i.imgur.com/lK5XBi9.png)
... Continue

### Layer Pattern for Test
3 Tahapan untuk Pengujian:

![Layer Test](https://i.imgur.com/CmLaY6J.jpg)

- **Widget Test:** Pengujian terhadap Widget dan User interface. Pengujian ini memungkinkan developer untuk mengotomatisasi proses pengujian terhadap User Interface

- **Integration Testing:** Pengujian antara business logic dan data handler

- **Unit Testing:** Pengujian untuk setiap fungsi yang ada pada Data Provider
