import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/constants/app_theme.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/register.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/register.i18n.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({
    this.email,
    this.name,
    this.phone,
    Key key,
  }) : super(key: key);

  final String email;
  final String name;
  final String phone;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(context),
      onModelReady: (model) {
        model.nameTEC.text = widget.name;
        model.emailTEC.text = widget.email;
        model.phoneTEC.text = widget.phone;
        model.initialise();
      },
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: false,
          showAppBar: false,
          body: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: context.mq.viewInsets.bottom),
              child: VStack(
                [
                  Image.asset(
                    AppImages.onboarding2,
                  ).hOneForth(context).centered(),
                  //
                  VStack(
                    [
                      //
                      "Join Us".i18n.text.xl2.semiBold.make(),
                      "Create an account now".i18n.text.light.make(),

                      //form
                      Form(
                        key: model.formKey,
                        child: VStack(
                          [
                            //
                            CustomTextFormField(
                              // labelText: "Name".i18n,
                              hintText: "Name".i18n,
                              textEditingController: model.nameTEC,
                              validator: FormValidator.validateName,
                              suffixIcon: Image.asset(
                                "assets/images/name-suffix.png",
                                // fit: BoxFit.fill,
                              ),
                            ), //.py12(),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              // labelText: "Email",
                              hintText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              textEditingController: model.emailTEC,
                              validator: FormValidator.validateEmail,
                              suffixIcon:
                                  Image.asset("assets/images/email-suffix.png"),
                            ), //.py12(),
                            SizedBox(
                              height: 20,
                            ),

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
                                      ("+" + model.selectedCountry.phoneCode)
                                          .text
                                          .make(),
                                    ],
                                  ).px8().onInkTap(model.showCountryDialPicker),
                                  // labelText: "Phone".i18n,
                                  hintText: "Phone".i18n,
                                  keyboardType: TextInputType.phone,
                                  textEditingController: model.phoneTEC,
                                  validator: FormValidator.validatePhone,
                                  suffixIcon: Image.asset(
                                      "assets/images/phone-suffix.png"),
                                ).expand(),
                              ],
                            ), //.py12(),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              hintText: "Password".i18n,
                              obscureText: true,
                              textEditingController: model.passwordTEC,
                              validator: FormValidator.validatePassword,
                            ), //.py12(),
                            SizedBox(
                              height: 20,
                            ),
                            AppStrings.enableReferSystem
                                ? CustomTextFormField(
                                    hintText: "Referral Code(optional)".i18n,
                                    textEditingController:
                                        model.referralCodeTEC,
                                    suffixIcon: Image.asset(
                                        "assets/images/referal-suffix.png"),
                                  ) //.py12()
                                : UiSpacer.emptySpace(),

                            //terms
                            HStack(
                              [
                                Theme(
                                  child: Checkbox(
                                    value: model.agreed,
                                    onChanged: (value) {
                                      model.agreed = value;
                                      model.notifyListeners();
                                    },
                                    overlayColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  data: ThemeData(
                                      primarySwatch: NaguaraColors
                                          .primaryMaterialColorForNaguara,
                                      unselectedWidgetColor:
                                          NaguaraColors.naGuaraPrimaryColor),
                                ),

                                //
                                "I agree with".i18n.text.make(),
                                UiSpacer.horizontalSpace(space: 2),
                                "Terms & Conditions"
                                    .i18n
                                    .text
                                    .color(NaguaraColors.naGuaraPrimaryColor)
                                    .bold
                                    .underline
                                    .make()
                                    .onInkTap(model.openTerms)
                                    .expand(),
                              ],
                            ),

                            //
                            CustomButton(
                              title: "Create Account".i18n,
                              loading: model.isBusy,
                              onPressed: model.processRegister,
                              shapeRadius: 10,
                            ).centered().py12(),

                            //register
                            // "OR".i18n.text.light.makeCentered(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Already have an Account"
                                    .i18n
                                    .text
                                    .semiBold
                                    .makeCentered()
                                    .py12(),
                                    // .onInkTap(model.openLogin),
                              Text(" "),
                                // title: "Login".i18n,
                                "Login".i18n.text.color(NaguaraColors.naGuaraPrimaryColor).semiBold.makeCentered().py12().onInkTap(model.openLogin)
                              ],
                            ),
                          ],
                          crossAlignment: CrossAxisAlignment.end,
                        ),
                      ).py20(),
                    ],
                  ).wFull(context).p20(),

                  //
                ],
              ).scrollVertical(),
            ),
          ),
        );
      },
    );
  }
}
