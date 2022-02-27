import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Order Details",
        "fr": "détails de la commande",
        "es": "Detalles del pedido",
        "de": "Bestelldetails",
        "pt": "detalhes do pedido",
        "ar": "تفاصيل الطلب",
        "ko": "주문 정보"
      } +
      {
        "en": "Deliver To",
        "fr": "Livrer à",
        "es": "Entregar a",
        "de": "Liefern an",
        "pt": "Entregar para",
        "ar": "يسلم إلى",
        "ko": "배달"
      } +
      {
        "en": "Customer Order Pickup",
        "fr": "Ramassage de la commande client",
        "es": "Recogida de pedidos del cliente",
        "de": "Abholung von Kundenaufträgen",
        "pt": "Retirada de pedido do cliente",
        "ar": "استلام طلب العميل",
        "ko": "고객 주문 픽업"
      } +
      {
        "en": "Status",
        "fr": "Statut",
        "es": "Estado",
        "de": "Status",
        "pt": "Status",
        "ar": "حالة",
        "ko": "상태"
      } +
      {
        "en": "Payment Status",
        "fr": "Statut de paiement",
        "es": "Estado de pago",
        "de": "Zahlungsstatus",
        "pt": "Status do pagamento",
        "ar": "حالة السداد",
        "ko": "지불 상태"
      } +
      {
        "en": "PAY FOR ORDER",
        "fr": "PAYER LA COMMANDE",
        "es": "PAGO POR ORDEN",
        "de": "FÜR EINE BESTELLUNG BEZAHLEN",
        "pt": "PAGAR PELO PEDIDO",
        "ar": "دفع ثمن ذلك",
        "ko": "주문 결제"
      } +
      {
        "en": "Code",
        "fr": "Code",
        "es": "Código",
        "de": "Code",
        "pt": "Código",
        "ar": "رمز",
        "ko": "암호"
      } +
      {
        "en": "Products",
        "fr": "Des produits",
        "es": "Productos",
        "de": "Produkte",
        "pt": "Produtos",
        "ar": "منتجات",
        "ko": "제품"
      } +
      {
        "en": "Vendor",
        "fr": "Vendeur",
        "es": "Vendedor",
        "de": "Verkäufer",
        "pt": "Fornecedor",
        "ar": "بائع",
        "ko": "공급 업체"
      } +
      {
        "en": "Driver",
        "fr": "Chauffeur",
        "es": "Conductor",
        "de": "Treiber",
        "pt": "Motorista",
        "ar": "سائق",
        "ko": "운전사"
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
        "en": "Chat with vendor",
        "fr": "Discuter avec le fournisseur",
        "es": "Chatear con el proveedor",
        "de": "Chatten Sie mit dem Anbieter",
        "pt": "Converse com o fornecedor",
        "ar": "الدردشة مع البائع",
        "ko": "공급 업체와 채팅"
      } +
      {
        "en": "Chat with driver",
        "fr": "Discuter avec le chauffeur",
        "es": "Chatear con el conductor",
        "de": "Chatten Sie mit dem Fahrer",
        "pt": "Converse com o motorista",
        "ar": "الدردشة مع السائق",
        "ko": "운전 기사와 채팅"
      } +
      {
        "en": "Chat with",
        "fr": "Parler avec",
        "es": "Chatear con",
        "de": "Plaudern mit",
        "pt": "Conversar com",
        "ar": "الدردشة مع",
        "ko": "채팅"
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
        "en": "Dropoff Location",
        "fr": "Point de chute",
        "es": "Punto de entrega",
        "de": "Rückgabestation",
        "pt": "Local de entrega",
        "ar": "موقع الإنزال",
        "ko": "반납 장소"
      } +
      {
        "en": "Package Details",
        "fr": "Détails du package",
        "es": "Detalles del paquete",
        "de": "Paketdetails",
        "pt": "Detalhes de embalagem",
        "ar": "حزمة من التفاصيل",
        "ko": "패키지 세부 정보"
      } +
      {
        "en": "Width",
        "fr": "Largeur",
        "es": "Ancho",
        "de": "Breite",
        "pt": "Largura",
        "ar": "عرض",
        "ko": "폭"
      } +
      {
        "en": "Length",
        "fr": "Longueur",
        "es": "Largo",
        "de": "Länge",
        "pt": "Comprimento",
        "ar": "طول",
        "ko": "길이"
      } +
      {
        "en": "Height",
        "fr": "Hauteur",
        "es": "Altura",
        "de": "Höhe",
        "pt": "Altura",
        "ar": "ارتفاع",
        "ko": "신장"
      } +
      {
        "en": "Weight",
        "fr": "Poids",
        "es": "Peso",
        "de": "Gewicht",
        "pt": "Peso",
        "ar": "وزن",
        "ko": "무게"
      } +
      {
        "en": "Package Type",
        "fr": "Type d'emballage",
        "es": "Tipo de paquete",
        "de": "Pakettyp",
        "pt": "Tipo de Pacote",
        "ar": "نوع الحزمة",
        "ko": "포장 종류"
      } +
      {
        "en": "Recipient Name",
        "fr": "Nom du destinataire",
        "es": "Nombre del Recipiente",
        "de": "Name des Empfängers",
        "pt": "Nome do Destinatário",
        "ar": "اسم المستلم",
        "ko": "받는 사람 이름"
      } +
      {
        "en": "Recipient Phone",
        "fr": "Téléphone du destinataire",
        "es": "Teléfono del destinatario",
        "de": "Empfängertelefon",
        "pt": "Telefone Destinatário",
        "ar": "هاتف المستلم",
        "ko": "수신자 전화"
      } +
      {
        "en": "Rate The Vendor",
        "fr": "Évaluez le fournisseur",
        "es": "Califica al vendedor",
        "de": "Bewerten Sie den Anbieter",
        "pt": "Avalie o fornecedor",
        "ar": "قيم البائع",
        "ko": "공급 업체 평가"
      } +
      {
        "en": "Call vendor",
        "fr": "Appeler le vendeur",
        "es": "Llamar al proveedor",
        "de": "Rufen Sie den Anbieter an",
        "pt": "Ligue para o vendedor",
        "ar": "اتصل بالبائع",
        "ko": "공급 업체에 전화"
      } +
      {
        "en": "Track Order",
        "fr": "Suivi de commande",
        "es": "Orden de pista",
        "de": "Bestellung verfolgen",
        "pt": "Acompanhar Pedido",
        "ar": "ترتيب المسار",
        "ko": "주문을 추적하다"
      } +
      {
        "en": "Order Tracking",
        "fr": "Suivi de commande",
        "es": "Rastreo de orden",
        "de": "Sendungsverfolgung",
        "pt": "Rastreamento de pedido",
        "ar": "تتبع الطلب",
        "ko": "주문 추적"
      } +
      {
        "en": "Verification Code",
        "fr": "Code de vérification",
        "es": "Código de verificación",
        "de": "Verifizierungs-Schlüssel",
        "pt": "Código de verificação",
        "ar": "شيفرة التأكيد",
        "ko": "확인 코드"
      } +
      {
        "en": "Cancel Order",
        "fr": "annuler la commande",
        "es": "Cancelar orden",
        "de": "Bestellung stornieren",
        "pt": "Cancelar pedido",
        "ar": "الغاء الطلب",
        "ko": "주문 취소"
      } +
      {
        "en": "Order Cancellation",
        "fr": "Annulation de la commande",
        "es": "Cancelación de orden",
        "de": "Auftragsstornierung",
        "pt": "Cancelamento de pedido",
        "ar": "طلب الغاء",
        "ko": "주문 취소"
      } +
      {
        "en": "Please state why you want to cancel order",
        "fr": "Veuillez indiquer pourquoi vous souhaitez annuler la commande",
        "es": "Indique por qué desea cancelar el pedido.",
        "de": "Bitte geben Sie an, warum Sie die Bestellung stornieren möchten",
        "pt": "Por favor, indique porque você deseja cancelar o pedido",
        "ar": "يرجى ذكر سبب رغبتك في إلغاء الطلب",
        "ko": "주문을 취소하려는 이유를 명시하십시오."
      } +
      {
        "en": "Long pickup time",
        "fr": "Temps de ramassage long",
        "es": "Tiempo de recogida prolongado",
        "de": "Lange Abholzeit",
        "pt": "Tempo de coleta longo",
        "ar": "وقت طويل",
        "ko": "긴 픽업 시간"
      } +
      {
        "en": "Vendor is too slow",
        "fr": "Le fournisseur est trop lent",
        "es": "El vendedor es demasiado lento",
        "de": "Verkäufer ist zu langsam",
        "pt": "Vendedor é muito lento",
        "ar": "البائع بطيء جدًا",
        "ko": "공급 업체가 너무 느립니다."
      } +
      {
        "en": "custom",
        "fr": "Douane",
        "es": "personalizado",
        "de": "Benutzerdefiniert",
        "pt": "personalizadas",
        "ar": "العادة",
        "ko": "커스텀"
      } +
      {
        "en": "Reason",
        "fr": "Raison",
        "es": "Razón",
        "de": "Grund",
        "pt": "Razão",
        "ar": "سبب",
        "ko": "이유"
      } +
      {
        "en": "Submit",
        "fr": "Soumettre",
        "es": "Enviar",
        "de": "einreichen",
        "pt": "Enviar",
        "ar": "إرسال",
        "ko": "제출"
      } +
      {
        "en": "Scheduled Date",
        "fr": "Date prévue",
        "es": "Cita agendada",
        "de": "Geplantes Datum",
        "pt": "Data marcada",
        "ar": "التاريخ المقرر",
        "ko": "예정일"
      } +
      {
        "en": "Scheduled Time",
        "fr": "Heure prévue",
        "es": "Hora programada",
        "de": "Geplante Zeit",
        "pt": "Horário marcado",
        "ar": "جدول زمني",
        "ko": "예정된 시간"
      } +
      {
        "en": "Stop",
        "fr": "Arrêter",
        "es": "Detener",
        "de": "Halt",
        "pt": "Pare",
        "ar": "قف",
        "ko": "중지"
      } +
      {
        "en": "Rate The Driver",
        "fr": "Évaluez le conducteur",
        "es": "Califica al conductor",
        "de": "Bewerten Sie den Treiber",
        "pt": "Avalie o motorista",
        "ar": "قيم السائق",
        "ko": "드라이버 평가"
      } +
      {
        "en": "Order Status tracking",
        "fr": "Suivi de l'état de la commande",
        "es": "Seguimiento del estado del pedido",
        "de": "Auftragsstatusverfolgung",
        "pt": "Rastreamento do status do pedido",
        "ar": "تتبع حالة الطلب",
        "ko": "주문 상태 추적"
      } +
      {
        "en": "Contact Info",
        "fr": "Informations de contact",
        "es": "Datos de contacto",
        "de": "Kontaktinformation",
        "pt": "Informação de contato",
        "ar": "معلومات الاتصال",
        "ko": "연락처 정보"
      } +
      {
        "en": "pending",
        "fr": "en attendant",
        "es": "pendiente",
        "de": "steht aus",
        "pt": "pendente",
        "ar": "ريثما",
        "ko": "보류 중",
        "my": "ဆိုင်းငံ့"
      } +
      {
        "en": "preparing",
        "fr": "en train de préparer",
        "es": "preparando",
        "de": "vorbereiten",
        "pt": "preparando",
        "ar": "خطة",
        "ko": "준비",
        "my": "ပြင်ဆင်နေသည်"
      } +
      {
        "en": "enroute",
        "fr": "en route",
        "es": "en camino",
        "de": "unterwegs",
        "pt": "a caminho",
        "ar": "في المسار",
        "ko": "도중에",
        "my": "လမ်းခရီးတွင်"
      } +
      {
        "en": "ready",
        "fr": "prêt",
        "es": "Listo",
        "de": "bereit",
        "pt": "pronto",
        "ar": "جاهز",
        "ko": "준비된",
        "my": "အဆင်သင့်"
      } +
      {
        "en": "delivered",
        "fr": "livré",
        "es": "entregado",
        "de": "geliefert",
        "pt": "entregue",
        "ar": "تم التوصيل",
        "ko": "배달",
        "my": "ပို့သည်"
      } +
      {
        "en": "failed",
        "fr": "manqué",
        "es": "ha fallado",
        "de": "gescheitert",
        "pt": "fracassado",
        "ar": "باءت بالفشل",
        "ko": "실패한",
        "my": "မအောင်မြင်ဘူး"
      } +
      {
        "en": "cancelled",
        "fr": "annulé",
        "es": "cancelado",
        "de": "abgesagt",
        "pt": "cancelado",
        "ar": "ألغيت",
        "ko": "취소 된",
        "my": "ဖျက်သိမ်း"
      } +
      {
        "en": "scheduled",
        "fr": "programmé",
        "es": "programado",
        "de": "geplant",
        "pt": "agendado",
        "ar": "المقرر",
        "ko": "예정",
        "my": "စီစဉ်ထား"
      } +
      {
        "en":
            "%s is sharing an order code with you. Track order with this code: %s",
        "fr":
            "%s partage un code de commande avec vous. Suivre la commande avec ce code : %s",
        "es":
            "%s comparte un código de pedido contigo. Seguimiento del pedido con este código: %s",
        "de":
            "%s teilt einen Bestellcode mit Ihnen. Bestellung mit diesem Code verfolgen: %s",
        "pt":
            "%s está compartilhando um código de pedido com você. Rastreie o pedido com este código: %s",
        "ar": "يقوم %s بمشاركة رمز طلب معك. تتبع الطلب بهذا الرمز: %s",
        "ko": "%s 이(가) 주문 코드를 공유하고 있습니다. 다음 코드로 주문 추적: %s"
      } +
      {
        "en": "Service",
        "fr": "Service",
        "es": "Servicio",
        "de": "Service",
        "pt": "Serviço",
        "ar": "خدمة",
        "ko": "서비스"
      } +
      {
        "en": "Category",
        "fr": "Catégorie",
        "es": "Categoría",
        "de": "Kategorie",
        "pt": "Categoria",
        "ar": "فئة",
        "ko": "범주"
      } +
      {
        "en": "Pickup Address",
        "fr": "Adresse de retrait",
        "es": "Dirección de entrega",
        "de": "Abholadresse",
        "pt": "Endereço de retirada",
        "ar": "عنوان الاستلام",
        "ko": "픽업 주소"
      } +
      {
        "en": "Dropoff Address",
        "fr": "Adresse de dépôt",
        "es": "Dirección de entrega",
        "de": "Abgabeadresse",
        "pt": "Endereço de entrega",
        "ar": "عنوان الإنزال",
        "ko": "하차 주소"
      } +
      {
        "en": "Customer",
        "fr": "Client",
        "es": "Cliente",
        "de": "Kunde",
        "pt": "Cliente",
        "ar": "عميل",
        "ko": "고객"
      } +
      {
        "en": "Stop",
        "fr": "Arrêter",
        "es": "Parada",
        "de": "Halt",
        "pt": "Pare",
        "ar": "قف",
        "ko": "중지"
      } +
      {
        "en": "Trip Details",
        "fr": "Détails du voyage",
        "es": "Detalles del viaje",
        "de": "Reisedetails",
        "pt": "Detalhes da viagem",
        "ar": "تفاصيل الرحلة",
        "ko": "여행 세부 정보",
        "my": "ခရီးစဉ်အသေးစိတ်"
      } +
      {
        "en": "completed",
        "fr": "complété",
        "es": "terminado",
        "de": "vollendet",
        "pt": "completado",
        "ar": "منجز",
        "ko": "완전한",
        "my": "ပြီးစီး"
      } +
      {
        "en": "Delivery details",
        "fr": "Détails de livraison",
        "es": "Detalles de la entrega",
        "de": "Lieferdetails",
        "pt": "Detalhes da Entrega",
        "ar": "تفاصيل التسليم",
        "ko": "배송 세부정보"
      } +
      {
        "en": "Service Provider",
        "fr": "Fournisseur de services",
        "es": "Proveedor de servicio",
        "de": "Dienstanbieter",
        "pt": "Provedor de serviço",
        "ar": "مقدم الخدمة",
        "ko": "서비스 제공자",
        "my": "ဝန်ဆောင်မှုပေးသူ"
      } +
      {
        "en": "Chat with %s",
        "fr": "Parler avec %s",
        "es": "Chatear con %s",
        "de": "Plaudern mit %s",
        "pt": "Conversar com %s",
        "ar": "الدردشة مع %s",
        "ko": "채팅 %s",
        "my": "စကားစမြည် %s"
      } +
      {
        "en": "Rate %s",
        "fr": "Taux %s",
        "es": "Índice %s",
        "de": "Rate %s",
        "pt": "Avaliar %s",
        "ar": "معدل %s",
        "ko": "비율 %s",
        "my": "နှုန်းထား %s"
      } +
      {
        "en": "successful",
        "fr": "à succès",
        "es": "exitoso",
        "de": "erfolgreich",
        "pt": "bem-sucedido",
        "ar": "ناجح",
        "ko": "성공적인",
        "my": "အောင်မြင်သည်။"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
