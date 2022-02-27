import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/login.view_model.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/login.i18n.dart';

class OTPLoginView extends StatelessWidget {
  const OTPLoginView(this.model, {Key key}) : super(key: key);

  final LoginViewModel model;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: model.otpLogin,
      child: Form(
        key: model.formKey,
        child: VStack(
          [
            //
            HStack(
              [
                CustomTextFormField(
                  prefixIcon: HStack(
                    [
                      //icon/flag
                      Flag.fromString(
                        model.selectedCountry.countryCode,
                        width: 20,
                        height: 20,
                      ),
                      UiSpacer.horizontalSpace(space: 5),
                      //text
                      ("+" + model.selectedCountry.phoneCode).text.make(),
                    ],
                  ).px8().onInkTap(model.showCountryDialPicker),
                  labelText: "Phone".i18n,
                  hintText: "",
                  keyboardType: TextInputType.phone,
                  textEditingController: model.phoneTEC,
                  validator: FormValidator.validatePhone,
                ).expand(),
              ],
            ).py12(),
            //

            CustomButton(
              title: "Login".i18n,
              loading: model.busy(model.otpLogin),
              onPressed: model.processOTPLogin,
            ).centered().py12(),
            //email login
            "Login with Email"
                .i18n
                .text
                .semiBold
                .makeCentered()
                .py12()
                .onInkTap(model.toggleLoginType),
            //register
            "OR".i18n.text.light.makeCentered(),
            "Create An Account"
                .i18n
                .text
                .semiBold
                .makeCentered()
                .py12()
                .onInkTap(model.openRegister),
          ],
          crossAlignment: CrossAxisAlignment.end,
        ),
      ).py20(),
    );
  }
}
