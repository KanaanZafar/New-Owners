import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Where to?",
        "fr": "Où ?",
        "es": "¿A donde?",
        "de": "Wohin?",
        "pt": "Para onde?",
        "ar": "إلى أين؟",
        "ko": "어디로?"
      } +
      {
        "en": "Pickup Location",
        "fr": "Lieu de ramassage",
        "es": "Lugar de recogida",
        "de": "Treffpunkt",
        "pt": "Local de coleta",
        "ar": "اختر موقعا",
        "ko": "짐을 싣는 곳"
      } +
      {
        "en": "Drop-off Location",
        "fr": "Point de chute",
        "es": "Punto de entrega",
        "de": "Rückgabestation",
        "pt": "Local de entrega",
        "ar": "موقع الإنزال",
        "ko": "하차 장소"
      } +
      {
        "en": "Next",
        "fr": "Prochain",
        "es": "próximo",
        "de": "Nächste",
        "pt": "Próximo",
        "ar": "التالي",
        "ko": "다음"
      } +
      {
        "en": "Vehicle Type",
        "fr": "Type de véhicule",
        "es": "tipo de vehiculo",
        "de": "Fahrzeugtyp",
        "pt": "Tipo de Veículo",
        "ar": "نوع السيارة",
        "ko": "차량 종류"
      } +
      {
        "en": "Payment",
        "fr": "Paiement",
        "es": "Pago",
        "de": "Zahlung",
        "pt": "Pagamento",
        "ar": "قسط",
        "ko": "지불"
      } +
      {
        "en": "Order Now",
        "fr": "Commandez maintenant",
        "es": "Ordenar ahora",
        "de": "Jetzt bestellen",
        "pt": "Peça agora",
        "ar": "اطلب الان",
        "ko": "지금 주문하세요"
      } +
      {
        "en": "Please select pickup and drop-off location",
        "fr": "Veuillez sélectionner le lieu de prise en charge et de dépose",
        "es": "Seleccione el lugar de recogida y devolución",
        "de": "Bitte wählen Sie den Abhol- und Abgabeort aus",
        "pt": "Selecione o local de embarque e desembarque",
        "ar": "الرجاء تحديد موقع الالتقاط والتوصيل",
        "ko": "픽업 및 하차 장소를 선택하세요."
      } +
      {
        "en": "Cancel",
        "fr": "Annuler",
        "es": "Cancelar",
        "de": "Abbrechen",
        "pt": "Cancelar",
        "ar": "يلغي",
        "ko": "취소"
      } +
      {
        "en": "Back",
        "fr": "Arrière",
        "es": "atrás",
        "de": "Zurück",
        "pt": "Voltar",
        "ar": "خلف",
        "ko": "뒤"
      } +
      {
        "en": "Dropoff Location",
        "fr": "Point de chute",
        "es": "Punto de entrega",
        "de": "Rückgabestation",
        "pt": "Local de entrega",
        "ar": "موقع الإنزال",
        "ko": "하차 장소"
      } +
      {
        "en": "Message",
        "fr": "Un message",
        "es": "Mensaje",
        "de": "Nachricht",
        "pt": "Mensagem",
        "ar": "رسالة",
        "ko": "메세지"
      } +
      {
        "en": "Cancel Booking",
        "fr": "Annuler la réservation",
        "es": "Cancelar reserva",
        "de": "Buchung stornieren",
        "pt": "Cancelar reserva",
        "ar": "إلغاء الحجز",
        "ko": "예약 취소"
      } +
      {
        "en": "Safety",
        "fr": "Sécurité",
        "es": "La seguridad",
        "de": "Sicherheit",
        "pt": "Segurança",
        "ar": "أمان",
        "ko": "안전"
      } +
      {
        "en": "Rate your trip",
        "fr": "Évaluez votre voyage",
        "es": "Califica tu viaje",
        "de": "Bewerte deine Reise",
        "pt": "Avalie sua viagem",
        "ar": "قيم رحلتك",
        "ko": "여행 평가"
      } +
      {
        "en": "Submit Rating",
        "fr": "Soumettre une évaluation",
        "es": "Enviar calificación",
        "de": "Bewertung senden",
        "pt": "Enviar avaliação",
        "ar": "إرسال التقييم",
        "ko": "평가 제출"
      } +
      {
        "en": "Searching for a driver. Please wait...",
        "fr": "Recherche d'un chauffeur. S'il vous plaît, attendez...",
        "es": "Buscando un conductor. Espere por favor...",
        "de": "Auf der Suche nach einem Fahrer. Warten Sie mal...",
        "pt": "Procurando por um motorista. Por favor, espere...",
        "ar": "البحث عن سائق. ارجوك انتظر...",
        "ko": "드라이버를 찾고 있습니다. 기다리세요..."
      } +
      {
        "en": "Review",
        "fr": "Revoir",
        "es": "Revisar",
        "de": "Rezension",
        "pt": "Análise",
        "ar": "إعادة النظر",
        "ko": "검토"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
