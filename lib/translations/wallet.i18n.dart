import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Wallet",
        "fr": "Portefeuille",
        "es": "Cartera",
        "de": "Brieftasche",
        "pt": "Carteira",
        "ar": "محفظة",
        "ko": "지갑"
      } +
      {
        "en": "Total Balance",
        "fr": "Solde total",
        "es": "Balance total",
        "de": "Gesamtsaldo",
        "pt": "Balanço total",
        "ar": "إجمالي الرصيد",
        "ko": "전체 균형"
      } +
      {
        "en": "Updated last at:",
        "fr": "Dernière mise à jour à:",
        "es": "Actualizado por última vez en:",
        "de": "Zuletzt aktualisiert um:",
        "pt": "Atualizado pela última vez em:",
        "ar": "آخر تحديث في:",
        "ko": "마지막 업데이트 날짜 :"
      } +
      {
        "en": "Top-Up Wallet",
        "fr": "Portefeuille de recharge",
        "es": "Billetera de recarga",
        "de": "Geldbörse aufladen",
        "pt": "Carteira de recarga",
        "ar": "رصيد المحفظة",
        "ko": "탑업 지갑"
      } +
      {
        "en": "Enter amount to top-up wallet with",
        "fr": "Saisissez le montant à recharger avec le portefeuille",
        "es": "Ingrese el monto para recargar la billetera con",
        "de":
            "Geben Sie den Betrag ein, mit dem die Brieftasche aufgeladen werden soll",
        "pt": "Insira o valor para recarregar a carteira com",
        "ar": "أدخل المبلغ لتعبئة المحفظة به",
        "ko": "충전 할 지갑 금액 입력"
      } +
      {
        "en": "Amount",
        "fr": "Montant",
        "es": "Monto",
        "de": "Menge",
        "pt": "Resultar",
        "ar": "كمية",
        "ko": "양"
      } +
      {
        "en": "TOP-UP",
        "fr": "REMPLIR",
        "es": "Recarga",
        "de": "NACHFÜLLEN",
        "pt": "COMPLETAR",
        "ar": "فوق حتى",
        "ko": "충전"
      } +
      {
        "en": "Wallet Transactions",
        "fr": "Transactions de portefeuille",
        "es": "Transacciones de billetera",
        "de": "Wallet-Transaktionen",
        "pt": "Carteira de transações",
        "ar": "معاملات المحفظة",
        "ko": "지갑 거래"
      } +
      {
        "en": "scheduled",
        "fr": "programmé",
        "es": "programado",
        "de": "geplant",
        "pt": "agendado",
        "ar": "المقرر",
        "ko": "예정"
      } +
      {
        "en": "pending",
        "fr": "en attendant",
        "es": "pendiente",
        "de": "steht aus",
        "pt": "pendente",
        "ar": "ريثما",
        "ko": "보류 중"
      } +
      {
        "en": "preparing",
        "fr": "en train de préparer",
        "es": "preparando",
        "de": "vorbereiten",
        "pt": "preparando",
        "ar": "خطة",
        "ko": "준비"
      } +
      {
        "en": "ready",
        "fr": "prêt",
        "es": "Listo",
        "de": "bereit",
        "pt": "pronto",
        "ar": "جاهز",
        "ko": "준비된"
      } +
      {
        "en": "enroute",
        "fr": "en route",
        "es": "en camino",
        "de": "unterwegs",
        "pt": "a caminho",
        "ar": "في المسار",
        "ko": "도중에"
      } +
      {
        "en": "failed",
        "fr": "manqué",
        "es": "ha fallado",
        "de": "gescheitert",
        "pt": "fracassado",
        "ar": "باءت بالفشل",
        "ko": "실패한"
      } +
      {
        "en": "delivered",
        "fr": "livré",
        "es": "entregado",
        "de": "geliefert",
        "pt": "entregue",
        "ar": "تم التوصيل",
        "ko": "배달"
      } +
      {
        "en": "successful",
        "fr": "à succès",
        "es": "exitoso",
        "de": "erfolgreich",
        "pt": "bem sucedido",
        "ar": "ناجح",
        "ko": "성공한"
      } +
      {
        "en": "cancelled",
        "fr": "annulé",
        "es": "cancelado",
        "de": "abgesagt",
        "pt": "cancelado",
        "ar": "ألغيت",
        "ko": "취소 된"
      } +
      {
        "en": "scheduled",
        "fr": "programmé",
        "es": "programado",
        "de": "geplant",
        "pt": "agendado",
        "ar": "المقرر",
        "ko": "예정"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
