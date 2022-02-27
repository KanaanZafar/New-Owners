import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Delivery Addresses",
        "fr": "Adresses de livraison",
        "es": "Direcciones de entrega",
        "de": "Lieferadressen",
        "pt": "Endereços de entrega",
        "ar": "عناوين التسليم",
        "ko": "배송 주소"
      } +
      {
        "en": "Swipe right to see more options",
        "fr": "Balayez vers la droite pour voir plus d'options",
        "es": "Desliza el dedo hacia la derecha para ver más opciones",
        "de": "Wischen Sie nach rechts, um weitere Optionen anzuzeigen",
        "pt": "Deslize para a direita para ver mais opções",
        "ar": "اسحب لليمين لرؤية المزيد من الخيارات",
        "ko": "더 많은 옵션을 보려면 오른쪽으로 스 와이프하세요."
      } +
      {
        "en": "No Delivery Address Found",
        "fr": "Aucune adresse de livraison trouvée",
        "es": "No se ha encontrado ninguna dirección de entrega",
        "de": "Keine Lieferadresse gefunden",
        "pt": "Nenhum endereço de entrega encontrado",
        "ar": "لم يتم العثور على عنوان التسليم",
        "ko": "배송 주소를 찾을 수 없습니다."
      } +
      {
        "en": "When you add delivery addresses, they will appear here",
        "fr":
            "Lorsque vous ajoutez des adresses de livraison, elles apparaîtront ici",
        "es": "Cuando agregue direcciones de entrega, aparecerán aquí",
        "de": "Wenn Sie Lieferadressen hinzufügen, werden diese hier angezeigt",
        "pt":
            "Quando você adicionar endereços de entrega, eles aparecerão aqui",
        "ar": "عند إضافة عناوين التسليم ، ستظهر هنا",
        "ko": "배송지 주소를 추가하면 여기에 표시됩니다."
      } +
      {
        "en": "Delete Delivery Address",
        "fr": "Supprimer l'adresse de livraison",
        "es": "Eliminar dirección de entrega",
        "de": "Lieferadresse löschen",
        "pt": "Excluir endereço de entrega",
        "ar": "حذف عنوان التسليم",
        "ko": "배송 주소 삭제"
      } +
      {
        "en": "Are you sure you want to delete this delivery address?",
        "fr": "Voulez-vous vraiment supprimer cette adresse de livraison?",
        "es": "¿Está seguro de que desea eliminar esta dirección de entrega?",
        "de": "Möchten Sie diese Lieferadresse wirklich löschen?",
        "pt": "Tem certeza de que deseja excluir este endereço de entrega?",
        "ar": "هل أنت متأكد أنك تريد حذف عنوان التسليم هذا؟",
        "ko": "이 배송 주소를 삭제 하시겠습니까?"
      } +
      {
        "en": "Delete",
        "fr": "Effacer",
        "es": "Borrar",
        "de": "Löschen",
        "pt": "Excluir",
        "ar": "حذف",
        "ko": "지우다"
      } +
      {
        "en": "No Delivery Address Selected",
        "fr": "Aucune adresse de livraison sélectionnée",
        "es": "No se ha seleccionado ninguna dirección de entrega",
        "de": "Keine Lieferadresse ausgewählt",
        "pt": "Nenhum endereço de entrega selecionado",
        "ar": "لم يتم تحديد عنوان التسليم",
        "ko": "선택한 배송 주소 없음"
      } +
      {
        "en": "Please select a delivery address",
        "fr": "Veuillez sélectionner une adresse de livraison",
        "es": "Seleccione una dirección de entrega",
        "de": "Bitte wählen Sie eine Lieferadresse",
        "pt": "Selecione um endereço de entrega",
        "ar": "الرجاء تحديد عنوان التسليم",
        "ko": "배송지 주소를 선택하세요"
      } +
      {
        "en": "Description",
        "ar": "وصف",
        "de": "Beschreibung",
        "es": "Descripción",
        "fr": "La description",
        "ko": "기술",
        "my": "ဖော်ပြချက်",
        "pt": "Descrição"
      } +
      {
        "en": "No Booking Address Selected",
        "fr": "Aucune adresse de réservation sélectionnée",
        "es": "No se ha seleccionado ninguna dirección de reserva",
        "de": "Keine Buchungsadresse ausgewählt",
        "pt": "Nenhum endereço de reserva selecionado",
        "ar": "لم يتم تحديد عنوان الحجز",
        "ko": "예약 주소를 선택하지 않았습니다.",
        "my": "ကြိုတင်စာရင်းသွင်းရန်လိပ်စာကို ရွေးချယ်ထားခြင်းမရှိပါ။"
      } +
      {
        "en": "No Booking Address Found",
        "fr": "Aucune adresse de réservation trouvée",
        "es": "No se ha encontrado ninguna dirección de reserva",
        "de": "Keine Buchungsadresse gefunden",
        "pt": "Nenhum endereço de reserva encontrado",
        "ar": "لم يتم العثور على عنوان الحجز",
        "ko": "예약 주소를 찾을 수 없습니다",
        "my": "ဘွတ်ကင်လိပ်စာမတွေ့ပါ။"
      } +
      {
        "en": "Please select a booking address",
        "fr": "Veuillez sélectionner une adresse de réservation",
        "es": "Seleccione una dirección de reserva",
        "de": "Bitte wählen Sie eine Buchungsadresse",
        "pt": "Selecione um endereço de reserva",
        "ar": "الرجاء تحديد عنوان الحجز",
        "ko": "예약 주소를 선택하세요",
        "my": "ကျေးဇူးပြု၍ ကြိုတင်စာရင်းသွင်းရန်လိပ်စာကို ရွေးပါ။"
      } +
      {
        "en": "When you add booking addresses, they will appear here",
        "fr":
            "Lorsque vous ajoutez des adresses de réservation, elles apparaîtront ici",
        "es": "Cuando agregue direcciones de reserva, aparecerán aquí",
        "de": "Wenn Sie Buchungsadressen hinzufügen, werden sie hier angezeigt",
        "pt": "Quando você adiciona endereços de reserva, eles aparecerão aqui",
        "ar": "عند إضافة عناوين الحجز ، ستظهر هنا",
        "ko": "예약 주소를 추가하면 여기에 표시됩니다.",
        "my": "ဘွတ်ကင်လိပ်စာများ ထည့်သောအခါ ၎င်းတို့သည် ဤနေရာတွင် ပေါ်လာပါမည်။"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
