import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Items",
        "fr": "Articles",
        "es": "Artículos",
        "de": "Artikel",
        "pt": "Itens",
        "ar": "العناصر",
        "ko": "아이템"
      } +
      {
        "en": "Add to cart",
        "fr": "Ajouter au panier",
        "es": "Añadir a la cesta",
        "de": "In den Warenkorb legen",
        "pt": "Adicionar ao Carrinho",
        "ar": "أضف إلى السلة",
        "ko": "장바구니에 담기"
      } +
      {
        "en": "Quantity",
        "fr": "Quantité",
        "es": "Cantidad",
        "de": "Menge",
        "pt": "Quantidade",
        "ar": "كمية",
        "ko": "수량"
      } +
      {
        "en": "Options",
        "fr": "Options",
        "es": "Opciones",
        "de": "Optionen",
        "pt": "Opções",
        "ar": "خيارات",
        "ko": "옵션"
      } +
      {
        "en": "Select options to add them to the product/service",
        "fr": "Sélectionnez les options pour les ajouter au produit/service",
        "es": "Seleccione opciones para agregarlas al producto / servicio",
        "de": "Wählen Sie Optionen aus, um sie zum Produkt/Dienst hinzuzufügen",
        "pt": "Selecione opções para adicioná-los ao produto / serviço",
        "ar": "حدد الخيارات لإضافتها إلى المنتج / الخدمة",
        "ko": "제품/서비스에 추가할 옵션 선택"
      } +
      {
        "en": "Deliverable",
        "fr": "Livrable",
        "es": "Entregables",
        "de": "Lieferbar",
        "pt": "Entregável",
        "ar": "التسليم",
        "ko": "결과물"
      } +
      {
        "en": "Not Deliverable",
        "fr": "Non livrable",
        "es": "No entregable",
        "de": "Nicht lieferbar",
        "pt": "Não Entregável",
        "ar": "غير قابل للتسليم",
        "ko": "배송 불가"
      } +
      {
        "en": "%s Items",
        "fr": "%s éléments",
        "es": "%s artículos",
        "de": "%s Artikel",
        "pt": "%s itens",
        "ar": "%s عناصر",
        "ko": "%s 항목"
      } +
      {
        "en": "View more from",
        "fr": "En savoir plus sur",
        "es": "Ver más de",
        "de": "Mehr anzeigen von",
        "pt": "Ver mais de",
        "ar": "عرض المزيد من",
        "ko": "더보기"
      } +
      {
        "en": "No stock",
        "fr": "Pas de stock",
        "es": "No hay stock",
        "de": "Kein Bestand",
        "pt": "Sem estoque",
        "ar": "لا يوجد مخزون",
        "ko": "재고 없음"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
