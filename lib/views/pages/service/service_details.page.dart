import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/utils/utils.dart';
import 'package:fuodz/view_models/service_details.vm.dart';
import 'package:fuodz/views/pages/service/widgets/service_details.bottomsheet.dart';
import 'package:fuodz/views/pages/service/widgets/service_details_price.section.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/custom_masonry_grid_view.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/services.i18n.dart';

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage(
    this.service, {
    Key key,
  }) : super(key: key);

  //
  final Service service;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ServiceDetailsViewModel>.reactive(
      viewModelBuilder: () => ServiceDetailsViewModel(context, service),
      onModelReady: (model) => model.getServiceDetails(),
      builder: (context, vm, child) {
        return BasePage(
          extendBodyBehindAppBar: true,
          isLoading: vm.busy(vm.service),
          body: Stack(
            children: [
              //
              CustomImage(
                imageUrl:
                    vm.service.photos.isNotEmpty ? vm.service.photos.first : '',
                width: double.infinity,
                height: context.percentHeight * 50,
              ),

              //service details section
              VStack(
                [
                  //empty space
                  UiSpacer.verticalSpace(space: context.percentHeight * 40),
                  //details
                  VStack(
                    [
                      //name
                      vm.service.name.text.medium.xl.make(),
                      //price
                      ServiceDetailsPriceSectionView(vm.service),

                      //rest details
                      UiSpacer.verticalSpace(),
                      VStack(
                        [
                          //photos
                          CustomMasonryGridView(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            items: vm.service.photos
                                .map(
                                  (photo) => CustomImage(
                                    imageUrl: photo,
                                    width: double.infinity,
                                    height: 80,
                                  ).box.roundedSM.clip(Clip.antiAlias).make(),
                                )
                                .toList(),
                          ),

                          //description
                          vm.service.description.text.sm.make(),
                        ],
                      ).box.p8.color(context.backgroundColor).roundedSM.make(),
                      UiSpacer.divider().py12(),
                      //vendor profile
                      "Provider".i18n.text.medium.xl.make().py12(),
                      HStack(
                        [
                          //provider logo
                          CustomImage(
                            imageUrl: vm.service.vendor.logo,
                            width: 50,
                            height: 50,
                          ).box.roundedSM.clip(Clip.antiAlias).make(),
                          //provider details
                          VStack(
                            [
                              vm.service.vendor.name.text.semiBold.lg.make(),
                              "${vm.service.vendor.phone}"
                                  .text
                                  .medium
                                  .sm
                                  .make(),
                              "${vm.service.vendor.address ?? ''}"
                                  .text
                                  .light
                                  .sm
                                  .maxLines(1)
                                  .make(),
                            ],
                          ).px12().expand(),
                        ],
                      )
                          .box
                          .p8
                          .color(context.backgroundColor)
                          .shadowXs
                          .roundedSM
                          .make()
                          .onInkTap(() => vm.openVendorPage()),

                      //spaces
                      UiSpacer.verticalSpace(),
                      UiSpacer.verticalSpace(),
                      UiSpacer.verticalSpace(),
                    ],
                  )
                      .wFull(context)
                      .p20()
                      .box
                      .color(context.backgroundColor)
                      .topRounded(value: 30)
                      .make(),
                ],
              ).scrollVertical(),

              // appbar section
              Positioned(
                top: kToolbarHeight,
                left: !Utils.isArabic ? Vx.dp20 : null,
                right: Utils.isArabic ? Vx.dp20 : null,
                child: Icon(
                  !Utils.isArabic
                      ? FlutterIcons.arrow_left_fea
                      : FlutterIcons.arrow_right_fea,
                  color: AppColor.primaryColor,
                )
                    .p12()
                    .box
                    .roundedSM
                    .color(context.backgroundColor)
                    .make()
                    .onTap(
                      () => context.pop(),
                    ),
              ),
            ],
          ),
          //
          bottomNavigationBar: ServiceDetailsBottomSheet(vm),
        );
      },
    );
  }
}
