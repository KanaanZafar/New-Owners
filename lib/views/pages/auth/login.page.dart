import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/view_models/login.view_model.dart';
import 'package:fuodz/views/pages/auth/login/email_login.view.dart';
import 'package:fuodz/views/pages/auth/login/otp_login.view.dart';
import 'package:fuodz/views/pages/auth/login/social_media.view.dart';
import 'package:fuodz/widgets/base.page.dart';

import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/login.i18n.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.required = false, Key key}) : super(key: key);

  final bool required;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            if (widget.required) {
              context.pop();
            }
            return true;
          },
          child: BasePage(
            showLeadingAction: !widget.required,
            showAppBar: !widget.required,
            appBarColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                FlutterIcons.arrow_left_fea,
                color: AppColor.primaryColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0,
            body: SafeArea(
              top: true,
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(bottom: context.mq.viewInsets.bottom),
                child: VStack(
                  [
                    //
                    VStack(
                      [
                        //
                        HStack(
                          [
                            VStack(
                              [
                                "Welcome Back".i18n.text.xl2.semiBold.make(),
                                "Login to continue".i18n.text.light.make(),
                              ],
                            ).expand(),
                            Image.asset(
                              AppImages.appLogo,
                            )
                                .h(60)
                                .w(60)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                          ],
                        ),

                        //otp form
                        OTPLoginView(model),

                        //email form
                        EmailLoginView(model),
                      ],
                    ).wFull(context).px20().pOnly(top: Vx.dp20),
                    //
                    SocialMediaView(model),
                  ],
                ).scrollVertical(),
              ),
            ),
          ),
        );
      },
    );
  }
}
