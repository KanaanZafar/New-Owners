import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "New",
        "fr": "Nouvelle",
        "es": "Nuevo",
        "de": "Neu",
        "pt": "Novo",
        "ar": "جديد",
        "ko": "새로운",
        "my": "အသစ်"
      } +
      {
        "en": "Track your package",
        "fr": "Suivre votre colis",
        "es": "Seguimiento de su paquete",
        "de": "Verfolgen Sie Ihre Paket",
        "pt": "Rastreie sua encomenda",
        "ar": "تتبع حزمة الخاص بك",
        "ko": "패키지 추적",
        "my": "သင့်ရဲ့အထုပ်ကိုခြေရာခံ"
      } +
      {
        "en": "Search by order code",
        "fr": "Recherche par code de commande",
        "es": "Buscar por código de pedido",
        "de": "Suche nach Bestellcode",
        "pt": "Pesquisa por código de pedido",
        "ar": "البحث عن طريق رمز الطلب",
        "ko": "주문 코드로 검색",
        "my": "အမိန့်ကုဒ်အားဖြင့်ရှာဖွေပါ"
      } +
      {
        "en": "Recent Orders",
        "fr": "Dernières commandes",
        "es": "órdenes recientes",
        "de": "letzte Bestellungen",
        "pt": "pedidos recentes",
        "ar": "الطلبيات الأخيرة",
        "ko": "최근 주문들"
      } +
      {
        "en": "Toggle Flash",
        "fr": "Activer/désactiver le flash",
        "es": "Alternar flash",
        "de": "Blitz umschalten",
        "pt": "Alternar Flash",
        "ar": "تبديل الفلاش",
        "ko": "플래시 토글"
      } +
      {
        "en": "Contact Phone number",
        "fr": "Numéro de téléphone de contact",
        "es": "Teléfono de contacto",
        "de": "Kontakt Telefonnummer",
        "pt": "Número de telefone do contato",
        "ar": "الاتصال رقم الهاتف",
        "ko": "연락처 전화번호"
      } +
      {
        "en": "Contact Name",
        "fr": "Nom du contact",
        "es": "Nombre de contacto",
        "de": "Kontaktname",
        "pt": "Nome de contato",
        "ar": "اسم جهة الاتصال",
        "ko": "담당자 이름"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
