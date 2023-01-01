<<<<<<< HEAD
class AppConstants {
  static AppConstants? _instance;
  static AppConstants get instance {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = AppConstants.init();
      return _instance!;
    }
  }

  AppConstants.init();

  String get appTitle => "Roplanify";
  String get Sumer_Zeytinburnu => "Sümer, Zeytinburnu";
  String get duragi_sil => "Durağı Sil";
  String get Durak_Ekle => 'Durak Ekle';
  String get Eklendi => "Eklendi";
  String get Rotayi_Optimize_Et => "Rotayı Optimize Et";
  String get Durak_eklemek_icin =>
      "Durak eklemek için üst kısımdaki arama çubuğunu kullanın";
  String get aracta_yer_elirleyin => "Araçta Yer Belirleyin";
  String get not_ekle => "Not Ekle";
  bool get debugShowCheckedModeBanner => false;
  double get deviceHeight => 0.0;
  double get mapHeight => 0.0;
}
=======
class AppConstants {
  static AppConstants? _instance;
  static AppConstants get instance {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = AppConstants.init();
      return _instance!;
    }
  }

  AppConstants.init();

  String get appTitle => "Roplanify";
  String get Sumer_Zeytinburnu => "Sümer, Zeytinburnu";
  String get duragi_sil => "Durağı Sil";
  String get Durak_Ekle => 'Durak Ekle';
  String get Eklendi => "Eklendi";
  String get Rotayi_Optimize_Et => "Rotayı Optimize Et";
  String get Durak_eklemek_icin =>
      "Durak eklemek için üst kısımdaki arama çubuğunu kullanın";
  String get aracta_yer_elirleyin => "Araçta Yer Belirleyin";
  String get not_ekle => "Not Ekle";
  bool get debugShowCheckedModeBanner => false;
  double get deviceHeight => 0.0;
  double get mapHeight => 0.0;
}
>>>>>>> origin/emre
