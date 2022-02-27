import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "What are you getting today?",
        "fr": "Qu'est-ce que vous obtenez aujourd'hui?",
        "es": "¿Qué vas a conseguir hoy?",
        "de": "Was bekommst du heute?",
        "pt": "O que você vai comprar hoje?",
        "ar": "ماذا ستحصل اليوم؟",
        "ko": "오늘 무엇을 받고 있습니까?"
      } +
      {
        "en": "See all",
        "fr": "Voir tout",
        "es": "Ver todo",
        "de": "Alles sehen",
        "pt": "Ver tudo",
        "ar": "اظهار الكل",
        "ko": "모두보기"
      } +
      {
        "en": "Show less",
        "fr": "Montrer moins",
        "es": "Muestra menos",
        "de": "Zeige weniger",
        "pt": "Mostre menos",
        "ar": "عرض أقل",
        "ko": "간략히보기"
      } +
      {
        "en": "Pick's Today",
        "fr": "Choisissez aujourd'hui",
        "es": "Elija hoy",
        "de": "Pick's heute",
        "pt": "Escolha hoje",
        "ar": "اختيار اليوم",
        "ko": "오늘의 선택"
      } +
      {
        "en": "We are here for you",
        "fr": "Nous sommes là pour vous",
        "es": "Estamos aquí para ti",
        "de": "Wir sind für dich da",
        "pt": "Estamos aqui por você",
        "ar": "نحن هنا من أجلك",
        "ko": "우리는 당신을 위해 여기 있습니다"
      } +
      {
        "en": "How can we help?",
        "fr": "Comment pouvons nous aider?",
        "es": "¿Cómo podemos ayudar?",
        "de": "Wie können wir helfen?",
        "pt": "Como podemos ajudar?",
        "ar": "كيف يمكن أن نساعد؟",
        "ko": "어떻게 도와 드릴까요?"
      } +
      {
        "en": "Upload",
        "fr": "Télécharger",
        "es": "Subir",
        "de": "Hochladen",
        "pt": "Envio",
        "ar": "تحميل",
        "ko": "업로드"
      } +
      {
        "en": "Need a helping hand today?",
        "fr": "Besoin d'un coup de main aujourd'hui ?",
        "es": "¿Necesitas una mano amiga hoy?",
        "de": "Brauchen Sie heute eine helfende Hand?",
        "pt": "Precisa de uma ajuda hoje?",
        "ar": "بحاجة الى يد المساعدة اليوم؟",
        "ko": "오늘 도움의 손길이 필요하십니까?",
        "my": "ဒီနေ့ကူညီမယ့်သူရှိသလား။"
      } +
      {
        "en": "Categories",
        "fr": "Catégories",
        "es": "Categorías",
        "de": "Kategorien",
        "pt": "Categorias",
        "ar": "فئات",
        "ko": "카테고리",
        "my": "အမျိုးအစားများ"
      };

  String get i18n => localize(this, _t);
}
