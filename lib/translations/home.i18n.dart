import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Home",
        "fr": "Maison",
        "es": "Hogar",
        "de": "Zuhause",
        "pt": "Casa",
        "ar": "الصفحة الرئيسية",
        "ko": "집"
      } +
      {
        "en": "Orders",
        "fr": "Ordres",
        "es": "Pedidos",
        "de": "Aufträge",
        "pt": "Pedidos",
        "ar": "أوامر",
        "ko": "명령"
      } +
      {
        "en": "Cart",
        "fr": "Chariot",
        "es": "Carro",
        "de": "Wagen",
        "pt": "Carrinho",
        "ar": "عربة التسوق",
        "ko": "카트"
      } +
      {
        "en": "More",
        "fr": "Suite",
        "es": "Más",
        "de": "Mehr",
        "pt": "Mais",
        "ar": "أكثر",
        "ko": "더"
      } +
      {
        "en": "Delivery Location",
        "fr": "Lieu de livraison",
        "es": "Lugar de entrega",
        "de": "Lieferort",
        "pt": "Local de entrega",
        "ar": "موقع التسليم",
        "ko": "배송 위치"
      } +
      {
        "en": "Press back again to close",
        "fr": "Appuyez à nouveau pour fermer",
        "es": "Presione de nuevo para cerrar",
        "de": "Zum Schließen erneut drücken",
        "pt": "Pressione novamente para fechar",
        "ar": "اضغط مرة أخرى للإغلاق",
        "ko": "닫으려면 뒤로를 다시 누르세요.",
        "my": "ပိတ်ရန်နောက်သို့ပြန်နှိပ်ပါ"
      } +
      {
        "en": "Search",
        "fr": "Chercher",
        "es": "Búsqueda",
        "de": "Suche",
        "pt": "Procurar",
        "ar": "بحث",
        "ko": "찾다"
      } +
      {
        "en": "Search for",
        "fr": "Rechercher",
        "es": "Buscar",
        "de": "Suchen nach",
        "pt": "Procurar",
        "ar": "بحث عن",
        "ko": "검색",
        "my": "အားရှာဖွေခြင်း"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
