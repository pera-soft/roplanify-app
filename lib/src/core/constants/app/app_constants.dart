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

  String get apple => "Apple ile devam et";

  String get google => "Google ile devam et";

  String get oturumAciliyor => "Oturum Açılıyor...";
  
  String get slogan => "Verimliliğe giden rota oluşturuluyor";

  String get appTitle => "roplanify";

  String get duragiSil => "Durağı Sil";

  String get durakEkle => 'Durak Ekle';

  String get eklendi => "Eklendi";

  String get rotayiOptimizeEt => "Rotayı Optimize Et";

  String get durakEklemekIcin =>
      "Durak eklemek için üst kısımdaki arama çubuğunu kullanın";

  String get aractaYerBelirleyin => "Araçta Yer Belirleyin";

  String get notEkle => "Not Ekle";

  String get rotaOptimizeEdiliyor => "Rota Optimize Ediliyor";

  bool get debugShowCheckedModeBanner => false;

  double get deviceHeight => 0.0;

  double get mapHeight => 0.0;
}
