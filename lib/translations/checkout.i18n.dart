import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Checkout",
        "fr": "Vérifier",
        "es": "Revisa",
        "de": "Überprüfen",
        "pt": "Confira",
        "ar": "الدفع",
        "ko": "점검"
      } +
      {
        "en": "Note",
        "fr": "Noter",
        "es": "Nota",
        "de": "Hinweis",
        "pt": "Observação",
        "ar": "ملحوظة",
        "ko": "노트"
      } +
      {
        "en": "Delivery address",
        "fr": "Adresse de livraison",
        "es": "Dirección de entrega",
        "de": "Lieferadresse",
        "pt": "Endereço de entrega",
        "ar": "عنوان التسليم",
        "ko": "배달 주소"
      } +
      {
        "en": "Please select delivery address",
        "fr": "Veuillez sélectionner l'adresse de livraison",
        "es": "Por favor seleccione la dirección de entrega.",
        "de": "Bitte wählen Sie die Lieferadresse",
        "pt": "Selecione o endereço de entrega",
        "ar": "الرجاء تحديد عنوان التسليم",
        "ko": "배송지 주소를 선택하세요"
      } +
      {
        "en": "Delivery address is out of vendor delivery range",
        "fr":
            "L'adresse de livraison est en dehors de la plage de livraison du fournisseur",
        "es":
            "La dirección de entrega está fuera del rango de entrega del proveedor",
        "de":
            "Die Lieferadresse liegt außerhalb des Lieferbereichs des Anbieters",
        "pt":
            "O endereço de entrega está fora do intervalo de entrega do fornecedor",
        "ar": "عنوان التسليم خارج نطاق تسليم البائع",
        "ko": "배송 주소가 공급 업체 배송 범위를 벗어났습니다."
      } +
      {
        "en": "Please select delivery address/location",
        "fr": "Veuillez sélectionner l'adresse / le lieu de livraison",
        "es": "Seleccione la dirección / ubicación de entrega",
        "de": "Bitte wählen Sie Lieferadresse / Ort",
        "pt": "Selecione o endereço / local de entrega",
        "ar": "يرجى تحديد عنوان التسليم / الموقع",
        "ko": "배송지 주소 / 위치를 선택하세요"
      } +
      {
        "en": "Pickup Order",
        "fr": "Ordre de ramassage",
        "es": "Orden para recoger",
        "de": "Bestellung aufnehmen",
        "pt": "Pedido de Retirada",
        "ar": "طلب الاستلام",
        "ko": "픽업 순서"
      } +
      {
        "en": "Payment Methods",
        "fr": "méthodes de payement",
        "es": "Métodos de pago",
        "de": "Zahlungsarten",
        "pt": "Métodos de Pagamento",
        "ar": "طرق الدفع",
        "ko": "지불 방법"
      } +
      {
        "en": "Please select a payment method",
        "fr": "Veuillez choisir un moyen de paiement",
        "es": "Por favor seleccione un método de pago",
        "de": "Bitte Zahlungsart wählen",
        "pt": "Selecione um método de pagamento",
        "ar": "الرجاء اختيار طريقة الدفع",
        "ko": "결제 방법을 선택하세요"
      } +
      {
        "en": "Please indicate if you would come pickup order at the vendor",
        "fr": "Veuillez indiquer si vous viendriez enlèvement chez le vendeur",
        "es": "Indique si vendría a recoger el pedido al proveedor",
        "de":
            "Bitte geben Sie an, ob Sie eine Abholbestellung beim Verkäufer erhalten würden",
        "pt":
            "Indique se você gostaria de fazer a ordem de coleta no fornecedor",
        "ar": "يرجى توضيح ما إذا كنت ستأتي لطلب الاستلام من البائع",
        "ko": "공급 업체에서 픽업 주문을받을 것인지 표시하십시오."
      } +
      {
        "en": "PLACE ORDER",
        "fr": "PASSER LA COMMANDE",
        "es": "REALIZAR PEDIDO",
        "de": "BESTELLUNG AUFGEBEN",
        "pt": "FAÇA A ENCOMENDA",
        "ar": "مكان الامر",
        "ko": "주문하기"
      } +
      {
        "en": "Processing order. Please wait...",
        "fr": "Commande en traitement. S'il vous plaît, attendez...",
        "es": "Orden de procesamiento. Espere por favor...",
        "de": "Bearbeitungsauftrag. Warten Sie mal...",
        "pt": "Processando o Pedido. Por favor, espere...",
        "ar": "معالجة الطلب. انتظر من فضلك...",
        "ko": "주문 처리 중입니다. 잠시만 기다려주세요 ..."
      } +
      {
        "en": "Product",
        "fr": "Produit",
        "es": "Producto",
        "de": "Produkt",
        "pt": "produtos",
        "ar": "منتج",
        "ko": "생성물"
      } +
      {
        "en":
            "There seems to be products that can not be delivered in your cart",
        "fr":
            "Il semble y avoir des produits qui ne peuvent pas être livrés dans votre panier",
        "es":
            "Parece que hay productos que no se pueden entregar en su carrito.",
        "de":
            "Es scheint Produkte zu geben, die nicht in Ihren Warenkorb geliefert werden können",
        "pt":
            "Parece haver produtos que não podem ser entregues no seu carrinho",
        "ar": "يبدو أن هناك منتجات لا يمكن تسليمها في عربة التسوق الخاصة بك",
        "ko": "장바구니에 담을 수없는 상품이있는 것 같습니다"
      } +
      {
        "en": "Schedule Order",
        "fr": "Planifier la commande",
        "es": "Orden de programación",
        "de": "Bestellung planen",
        "pt": "Ordem de agendamento",
        "ar": "ترتيب الجدول",
        "ko": "주문 예약"
      } +
      {
        "en":
            "If you want your order to be delivered/prepared at scheduled date/time",
        "fr":
            "Si vous souhaitez que votre commande soit livrée / préparée à la date / heure prévue",
        "es":
            "Si desea que su pedido sea entregado / preparado en la fecha / hora programadas",
        "de":
            "Wenn Sie möchten, dass Ihre Bestellung zum geplanten Datum / zur geplanten Uhrzeit geliefert / vorbereitet wird",
        "pt":
            "Se você deseja que seu pedido seja entregue / preparado na data / hora programada",
        "ar": "إذا كنت ترغب في تسليم / تجهيز طلبك في التاريخ / الوقت المحدد",
        "ko": "주문하신 날짜 / 시간에 배송 / 준비를 원하시는 경우"
      } +
      {
        "en": "Delivery Date",
        "fr": "Date de livraison",
        "es": "Fecha de entrega",
        "de": "Liefertermin",
        "pt": "Data de entrega",
        "ar": "تاريخ التسليم او الوصول",
        "ko": "배송 날짜"
      } +
      {
        "en": "Please select your desire order date",
        "fr": "Veuillez sélectionner la date de commande souhaitée",
        "es": "Seleccione la fecha de pedido deseada",
        "de": "Bitte wählen Sie das gewünschte Bestelldatum",
        "pt": "Por favor, selecione a data desejada para o pedido",
        "ar": "يرجى تحديد تاريخ الطلب الخاص بك",
        "ko": "원하시는 주문일을 선택하세요"
      } +
      {
        "en": "Delivery Time",
        "fr": "Heure de livraison",
        "es": "El tiempo de entrega",
        "de": "Lieferzeit",
        "pt": "Tempo de entrega",
        "ar": "موعد التسليم",
        "ko": "배달 시간"
      } +
      {
        "en": "Please select your desire order time",
        "fr": "Veuillez sélectionner votre heure de commande souhaitée",
        "es": "Seleccione la hora de su pedido deseada",
        "de": "Bitte wählen Sie Ihre gewünschte Bestellzeit",
        "pt": "Por favor, selecione a hora do pedido desejada",
        "ar": "يرجى تحديد وقت الطلب الخاص بك",
        "ko": "원하시는 주문 시간을 선택하세요"
      } +
      {
        "en": "Date slot",
        "fr": "Plage de date",
        "es": "Ranura de fecha",
        "de": "Datum Slot",
        "pt": "Slot de data",
        "ar": "خانة التاريخ",
        "ko": "날짜 슬롯"
      } +
      {
        "en": "Time slot",
        "fr": "Créneau horaire",
        "es": "Franja horaria",
        "de": "Zeitfenster",
        "pt": "Intervalo de tempo",
        "ar": "فسحة زمنية",
        "ko": "시간 슬롯"
      } +
      {
        "en": "Driver Tip",
        "fr": "Conseil du conducteur",
        "es": "Consejo para el conductor",
        "de": "Fahrertipp",
        "pt": "Dica do motorista",
        "ar": "نصيحة السائق",
        "ko": "드라이버 팁"
      } +
      {
        "en": "Fill Contact Info",
        "fr": "Remplir les coordonnées",
        "es": "Complete la información de contacto",
        "de": "Kontaktdaten ausfüllen",
        "pt": "Preencher informações de contato",
        "ar": "املأ معلومات الاتصال",
        "ko": "연락처 정보 입력"
      } +
      {
        "en":
            "Please ensure you fill in contact info for all added stops. Thank you",
        "fr":
            "Veuillez vous assurer de remplir les coordonnées de tous les arrêts ajoutés. Merci",
        "es":
            "Asegúrese de completar la información de contacto para todas las paradas adicionales. Gracias",
        "de":
            "Bitte stellen Sie sicher, dass Sie die Kontaktdaten für alle hinzugefügten Haltestellen angeben. Vielen Dank",
        "pt":
            "Certifique-se de preencher as informações de contato para todas as paradas adicionadas. Obrigada",
        "ar":
            "يرجى التأكد من ملء معلومات الاتصال لجميع المحطات المضافة. شكرا لك",
        "ko": "추가 된 모든 정류장에 대한 연락처 정보를 입력했는지 확인하십시오. 감사합니다"
      } +
      {
        "en": "Minimum Order Value",
        "fr": "Valeur minimale de commande",
        "es": "Valor de pedido mínimo",
        "de": "Mindestbestellwert",
        "pt": "Valor mínimo do pedido",
        "ar": "الحد الأدنى لقيمة الطلب",
        "ko": "최소 주문 금액",
        "my": "အနည်းဆုံးအမှာစာတန်ဖိုး"
      } +
      {
        "en": "Order value/amount is less than vendor accepted minimum order",
        "fr":
            "La valeur/le montant de la commande est inférieur à la commande minimale acceptée par le fournisseur",
        "es":
            "El valor / monto del pedido es menor que el pedido mínimo aceptado por el proveedor",
        "de":
            "Bestellwert/Betrag liegt unter dem vom Anbieter akzeptierten Mindestbestellwert",
        "pt":
            "O valor / quantidade do pedido é menor do que o pedido mínimo aceito pelo fornecedor",
        "ar": "قيمة / مبلغ الطلب أقل من الحد الأدنى للطلب الذي يقبله البائع",
        "ko": "주문 금액/금액이 공급업체에서 허용한 최소 주문보다 적습니다.",
        "my":
            "အမှာစာတန်ဖိုး / ပမာဏသည်ရောင်းချသူမှလက်ခံသောအနည်းဆုံးအမှာစာထက်နည်းသည်"
      } +
      {
        "en": "Maximum Order Value",
        "fr": "Valeur maximale de la commande",
        "es": "Valor máximo de pedido",
        "de": "Maximaler Bestellwert",
        "pt": "Valor máximo do pedido",
        "ar": "الحد الأقصى لقيمة الطلب",
        "ko": "최대 주문 금액",
        "my": "အများဆုံးအမိန့်တန်ဖိုး"
      } +
      {
        "en": "Order value/amount is more than vendor accepted maximum order",
        "fr":
            "La valeur/le montant de la commande est supérieur à la commande maximale acceptée par le fournisseur",
        "es":
            "El valor / monto del pedido es mayor que el pedido máximo aceptado por el proveedor",
        "de":
            "Bestellwert/Betrag liegt über der vom Anbieter akzeptierten Höchstbestellung",
        "pt":
            "O valor / quantidade do pedido é maior do que o pedido máximo aceito pelo fornecedor",
        "ar": "قيمة / مبلغ الطلب أكبر من الحد الأقصى الذي يقبله البائع",
        "ko": "주문 금액/금액이 공급업체에서 허용한 최대 주문보다 큽니다.",
        "my":
            "အမှာစာတန်ဖိုး / ပမာဏသည်ရောင်းချသူမှအများဆုံးလက်ခံသောအော်ဒါထက်ပိုပါသည်"
      } +
      {
        "en": "Vendor is not open",
        "fr": "Le vendeur n'est pas ouvert",
        "es": "El vendedor no está abierto",
        "de": "Verkäufer ist nicht geöffnet",
        "pt": "O vendedor não está aberto",
        "ar": "البائع غير مفتوح",
        "ko": "공급업체가 열리지 않음"
      } +
      {
        "en": "Vendor is currently not open to accepting order at the moment",
        "fr":
            "Le fournisseur n'est actuellement pas disposé à accepter la commande pour le moment",
        "es":
            "El proveedor actualmente no está abierto a aceptar pedidos en este momento.",
        "de":
            "Der Verkäufer ist derzeit nicht für die Annahme von Bestellungen geöffnet",
        "pt": "O fornecedor não está aberto para aceitar pedidos no momento",
        "ar": "البائع غير مفتوح حاليًا لقبول الطلب في الوقت الحالي",
        "ko": "공급업체는 현재 주문을 수락할 수 없습니다."
      } +
      {
        "en": "Change",
        "fr": "Changer",
        "es": "Cambio",
        "de": "Ändern",
        "pt": "Mudar",
        "ar": "يتغيرون",
        "ko": "변화",
        "my": "ပြောင်းပါ"
      } +
      {
        "en": "Select",
        "fr": "Sélectionner",
        "es": "Seleccione",
        "de": "Wählen",
        "pt": "Selecione",
        "ar": "يختار",
        "ko": "선택하다",
        "my": "ရွေးချယ်ပါ။"
      } +
      {
        "en": "Booking address",
        "fr": "Adresse de réservation",
        "es": "Dirección de reserva",
        "de": "Buchungsadresse",
        "pt": "Endereço de reserva",
        "ar": "عنوان الحجز",
        "ko": "예약 주소",
        "my": "ဘွတ်ကင်လိပ်စာ"
      } +
      {
        "en": "Please select booking address/location",
        "fr": "Veuillez sélectionner l'adresse/l'emplacement de réservation",
        "es": "Seleccione la dirección / ubicación de la reserva",
        "de": "Bitte Buchungsadresse/Ort auswählen",
        "pt": "Selecione o endereço / localização da reserva",
        "ar": "الرجاء تحديد عنوان الحجز / الموقع",
        "ko": "예약 주소/위치를 선택하세요.",
        "my": "ကျေးဇူးပြု၍ ကြိုတင်စာရင်းသွင်းရန်လိပ်စာ/တည်နေရာကို ရွေးချယ်ပါ။"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
