import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/requests/order.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/order/orders_details.page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fuodz/translations/parcel.i18n.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:velocity_x/velocity_x.dart';

class ParcelViewModel extends MyBaseViewModel {
  //
  ParcelViewModel(BuildContext context, {this.vendorType}) {
    this.viewContext = context;
  }

  //
  VendorType vendorType;
  OrderRequest orderRequest = OrderRequest();
  RefreshController refreshController = RefreshController();
  Order order;

  //scanning
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  bool flashEnabled = false;

  //
  trackOrder(String orderCode) async {
    setBusy(true);

    try {
      order = await orderRequest.trackOrder(
        orderCode,
        vendorTypeId: vendorType.id,
      );
      clearErrors();

      //open order details
      viewContext.nextPage(
        OrderDetailsPage(
          order: order,
          isOrderTracking: true,
        ),
      );
    } catch (error) {
      print("Order Error ==> $error");
      setError(error);
      //
      CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Track your package".i18n,
          text: "$error");
    }

    setBusy(false);
  }

  //
  void openCodeScanner() async {
    //
    final result = await showDialog(
      context: viewContext,
      builder: (context) {
        return Dialog(
          child: VStack(
            [
              //qr code preview
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ).h48(context),
              //
              HStack(
                [
                  "Toggle Flash".i18n.text.make().expand(),
                  Switch(
                    value: flashEnabled,
                    onChanged: (value) {
                      flashEnabled = value;
                      controller.toggleFlash();
                      notifyListeners();
                    },
                  ),
                ],
              ).px20(),
            ],
          ),
        );
      },
    );

    //
    print("Results ==> $result");
    if (controller != null) {
      controller.stopCamera();
    }
    //
    FocusScope.of(viewContext).requestFocus(FocusNode());
  }

  //
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    // controller.toggleFlash();
    controller.scannedDataStream.listen((scanData) {
      //cloe dialog
      viewContext.pop();
      //start searching
      trackOrder(scanData.code);
    });
  }
}
