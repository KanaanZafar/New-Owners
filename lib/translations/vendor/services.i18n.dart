import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Off",
        "fr": "Désactivé",
        "es": "Apagado",
        "de": "aus",
        "pt": "Desligado",
        "ar": "اطفء",
        "ko": "끄다"
      } +
      {
        "en": "Popular",
        "fr": "Populaire",
        "es": "Popular",
        "de": "Beliebt",
        "pt": "Popular",
        "ar": "شائع",
        "ko": "인기있는"
      } +
      {
        "en": "View More",
        "fr": "Voir plus",
        "es": "Ver más",
        "de": "Mehr sehen",
        "pt": "Veja mais",
        "ar": "عرض المزيد",
        "ko": "더보기"
      } +
      {
        "en": "Provider",
        "fr": "Fournisseur",
        "es": "Proveedor",
        "de": "Anbieter",
        "pt": "Fornecedor",
        "ar": "مزود",
        "ko": "공급자"
      } +
      {
        "en": "Book Now",
        "fr": "Reserve maintenant",
        "es": "Reservar ahora",
        "de": "buchen Sie jetzt",
        "pt": "Agende agora",
        "ar": "احجز الآن",
        "ko": "지금 예약"
      } +
      {
        "en": "Hours",
        "fr": "Les heures",
        "es": "Horas",
        "de": "Std",
        "pt": "Horas",
        "ar": "ساعات",
        "ko": "시간"
      } +
      {
        "en": "Booking Summary",
        "fr": "Résumé de la réservation",
        "es": "Resumen de reserva",
        "de": "Buchungsübersicht",
        "pt": "Sumário",
        "ar": "ملخص الكتاب",
        "ko": "예약 요약"
      } +
      {
        "en": "Note",
        "fr": "Noter",
        "es": "Nota",
        "de": "Notiz",
        "pt": "Observação",
        "ar": "ملحوظة",
        "ko": "메모"
      } +
      {
        "en": "Continue",
        "fr": "Continuer",
        "es": "Continuar",
        "de": "Weitermachen",
        "pt": "Prosseguir",
        "ar": "يكمل",
        "ko": "계속하다"
      } +
      {
        "en": "Hour",
        "fr": "Heure",
        "es": "Hora",
        "de": "Stunde",
        "pt": "Hora",
        "ar": "ساعة",
        "ko": "시",
        "my": "နာရီ"
      } +
      {
        "en": "Day",
        "fr": "Jour",
        "es": "Día",
        "de": "Tag",
        "pt": "Dia",
        "ar": "يوم",
        "ko": "낮",
        "my": "နေ့"
      } +
      {
        "en": "Fixed",
        "fr": "Fixé",
        "es": "Reparado",
        "de": "Fest",
        "pt": "Fixo",
        "ar": "مثبت",
        "ko": "결정된",
        "my": "သတ်မှတ်ထားတဲ့"
      } +
      {
        "en": "Month",
        "fr": "Mois",
        "es": "Mes",
        "de": "Monat",
        "pt": "Mês",
        "ar": "شهر",
        "ko": "월",
        "my": "လ"
      } +
      {
        "en": "Year",
        "fr": "An",
        "es": "Año",
        "de": "Jahr",
        "pt": "Ano",
        "ar": "عام",
        "ko": "년도",
        "my": "တစ်နှစ်"
      };

  String get i18n => localize(this, _t);
}
