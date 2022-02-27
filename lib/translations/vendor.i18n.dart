import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "No Vendor Found",
        "fr": "Aucun fournisseur trouvé",
        "es": "No se encontró ningún proveedor",
        "de": "Kein Anbieter gefunden",
        "pt": "Nenhum fornecedor encontrado",
        "ar": "لم يتم العثور على بائع",
        "ko": "공급 업체를 찾을 수 없습니다."
      } +
      {
        "en": "There seems to be no vendor around your selected location",
        "fr":
            "Il semble n'y avoir aucun fournisseur à proximité de l'emplacement sélectionné",
        "es": "Parece que no hay ningún proveedor en la ubicación seleccionada",
        "de":
            "An Ihrem ausgewählten Standort scheint es keinen Anbieter zu geben",
        "pt": "Parece não haver nenhum fornecedor próximo ao local selecionado",
        "ar": "يبدو أنه لا يوجد بائع حول موقعك المحدد",
        "ko": "선택한 위치 주변에 공급 업체가없는 것 같습니다."
      } +
      {
        "en": "No Product Found",
        "fr": "Aucun produit trouvé",
        "es": "No se ha encontrado ningún producto",
        "de": "Kein Produkt gefunden",
        "pt": "Nenhum produto encontrado",
        "ar": "لم يتم العثور على منتج",
        "ko": "제품을 찾을 수 없음"
      } +
      {
        "en": "There seems to be no product",
        "fr": "Il semble n'y avoir aucun produit",
        "es": "Parece que no hay producto",
        "de": "Es scheint kein Produkt zu geben",
        "pt": "Parece não haver nenhum produto",
        "ar": "يبدو أنه لا يوجد منتج",
        "ko": "상품이없는 것 같습니다"
      } +
      {
        "en": "No Product/Vendor Found",
        "fr": "Aucun produit / fournisseur trouvé",
        "es": "No se encontró ningún producto / proveedor",
        "de": "Kein Produkt / Anbieter gefunden",
        "pt": "Nenhum produto / fornecedor encontrado",
        "ar": "لم يتم العثور على منتج / بائع",
        "ko": "제품 / 공급 업체를 찾을 수 없음"
      } +
      {
        "en": "There seems to be no product/vendor",
        "fr": "Il ne semble y avoir aucun produit / fournisseur",
        "es": "Parece que no hay ningún producto / proveedor",
        "de": "Es scheint kein Produkt / Anbieter zu geben",
        "pt": "Parece não haver nenhum produto / fornecedor",
        "ar": "يبدو أنه لا يوجد منتج / بائع",
        "ko": "제품 / 공급 업체가없는 것 같습니다."
      } +
      {
        "en": "View all vendors",
        "fr": "Voir tous les fournisseurs",
        "es": "Ver todos los proveedores",
        "de": "Alle Anbieter anzeigen",
        "pt": "Ver todos os fornecedores",
        "ar": "عرض كل البائعين",
        "ko": "모든 공급업체 보기",
        "my": "ရောင်းသူအားလုံးကိုကြည့်ပါ"
      } +
      {
        "en": "Reviews",
        "fr": "Commentaires",
        "es": "Reseñas",
        "de": "Bewertungen",
        "pt": "Avaliações",
        "ar": "المراجعات",
        "ko": "리뷰"
      } +
      {
        "en": "When customer drop review, you will see them here",
        "fr": "Lorsque le client dépose un avis, vous le verrez ici",
        "es": "Cuando el cliente deje una reseña, los verá aquí",
        "de": "Wenn Kundenbewertungen fallen, werden sie hier angezeigt",
        "pt": "Quando o cliente deixar a avaliação, você os verá aqui",
        "ar": "عندما يسقط العميل المراجعة ، ستراهم هنا",
        "ko": "고객이 리뷰를 삭제하면 여기에 표시됩니다.",
        "my":
            "ဖောက်သည်ချသည့်အခါ ပြန်လည်သုံးသပ်သည့်အခါ ၎င်းတို့ကို ဤနေရာတွင် တွေ့ရပါမည်။"
      } +
      {
        "en": "No Review",
        "fr": "Pas d'avis",
        "es": "Sin revisión",
        "de": "Keine Rezension",
        "pt": "Sem revisão",
        "ar": "لا مراجعة",
        "ko": "리뷰 없음",
        "my": "သုံးသပ်ချက်မရှိပါ။"
      };

  String get i18n => localize(this, _t);
}
