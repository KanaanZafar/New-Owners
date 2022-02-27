import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/social_media_login.service.dart';
import 'package:fuodz/views/pages/auth/register.page.dart';
import 'package:fuodz/widgets/bottomsheets/account_verification_entry.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/dialogs.i18n.dart';

class LoginViewModel extends MyBaseViewModel {
  //the textediting controllers
  TextEditingController phoneTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  //
  AuthRequest authRequest = AuthRequest();
  SocialMediaLoginService socialMediaLoginService = SocialMediaLoginService();
  bool otpLogin = AppStrings.enableOTPLogin;
  Country selectedCountry;
  String accountPhoneNumber;

  LoginViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() {
    //
    emailTEC.text = kReleaseMode ? "" : "client@demo.com";
    passwordTEC.text = kReleaseMode ? "" : "password";

    //phone login
    try {
      this.selectedCountry = Country.parse(AppStrings.countryCode
          .toUpperCase()
          .replaceAll("AUTO,", "")
          .split(",")[0]);
    } catch (error) {
      this.selectedCountry = Country.parse("us");
    }
  }

  toggleLoginType() {
    otpLogin = !otpLogin;
    notifyListeners();
  }

  showCountryDialPicker() {
    showCountryPicker(
      context: viewContext,
      showPhoneCode: true,
      onSelect: countryCodeSelected,
    );
  }

  countryCodeSelected(Country country) {
    selectedCountry = country;
    notifyListeners();
  }

  void processOTPLogin() async {
    //
    accountPhoneNumber = "+${selectedCountry.phoneCode}${phoneTEC.text}";
    // Validate returns true if the form is valid, otherwise false.
    if (formKey.currentState.validate()) {
      //
      if (AppStrings.isFirebaseOtp) {
        processFirebaseOTPVerification();
      } else {
        processCustomOTPVerification();
      }
    }
  }

  //PROCESSING VERIFICATION
  processFirebaseOTPVerification() async {
    setBusyForObject(otpLogin, true);
    //firebase authentication
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: accountPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // firebaseVerificationId = credential.verificationId;
        // verifyFirebaseOTP(credential.smsCode);
        print("verificationCompleted ==>  Yes");
        // finishOTPLogin(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log("Error message ==> ${e.message}");
        if (e.code == 'invalid-phone-number') {
          viewContext.showToast(
              msg: "Invalid Phone Number".i18n, bgColor: Colors.red);
        } else {
          viewContext.showToast(msg: e.message, bgColor: Colors.red);
        }
        //
        setBusyForObject(otpLogin, false);
      },
      codeSent: (String verificationId, int resendToken) async {
        firebaseVerificationId = verificationId;
        print("codeSent ==>  $firebaseVerificationId");
        showVerificationEntry();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("codeAutoRetrievalTimeout called");
      },
    );
    setBusyForObject(otpLogin, false);
  }

  processCustomOTPVerification() async {
    setBusyForObject(otpLogin, true);
    try {
      await authRequest.sendOTP(accountPhoneNumber);
      setBusyForObject(otpLogin, false);
      showVerificationEntry();
    } catch (error) {
      setBusyForObject(otpLogin, false);
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
  }

  //
  void showVerificationEntry() async {
    //
    setBusy(false);
    //
    await viewContext.push(
      (context) => AccountVerificationEntry(
        vm: this,
        phone: accountPhoneNumber,
        onSubmit: (smsCode) {
          //
          if (AppStrings.isFirebaseOtp) {
            verifyFirebaseOTP(smsCode);
          } else {
            verifyCustomOTP(smsCode);
          }

          viewContext.pop();
        },
        onResendCode: AppStrings.isCustomOtp
            ? () async {
                try {
                  final response = await authRequest.sendOTP(
                    accountPhoneNumber,
                  );
                  toastSuccessful(response.message);
                } catch (error) {
                  viewContext.showToast(msg: "$error", bgColor: Colors.red);
                }
              }
            : null,
      ),
    );
  }

  //
  void verifyFirebaseOTP(String smsCode) async {
    //
    setBusyForObject(otpLogin, true);

    // Sign the user in (or link) with the credential
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: firebaseVerificationId,
        smsCode: smsCode,
      );

      //
      finishOTPLogin(phoneAuthCredential);
    } catch (error) {
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
    //
    setBusyForObject(otpLogin, false);
  }

  void verifyCustomOTP(String smsCode) async {
    //
    setBusy(true);
    // Sign the user in (or link) with the credential
    try {
      final apiResponse = await authRequest.verifyOTP(
        accountPhoneNumber,
        smsCode,
        isLogin: true,
      );

      //
      handleDeviceLogin(apiResponse);
    } catch (error) {
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
    //
    setBusy(false);
  }

  //Login to with firebase token
  finishOTPLogin(AuthCredential authCredential) async {
    //
    print("Done 1");
    setBusyForObject(otpLogin, true);
    // Sign the user in (or link) with the credential
    try {
      //
      print("Done 2");
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        authCredential,
      );
      print("Done 3");

      //
      String firebaseToken = await userCredential.user.getIdToken();
      print("Done 4");
      final apiResponse = await authRequest.verifyFirebaseToken(
        accountPhoneNumber,
        firebaseToken,
      );
      //
      print("Done 5");
      handleDeviceLogin(apiResponse);
    } catch (error) {
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
    //
    setBusyForObject(otpLogin, false);
  }

  //REGULAR LOGIN
  void processLogin() async {
    // Validate returns true if the form is valid, otherwise false.
    if (formKey.currentState.validate()) {
      //

      setBusy(true);

      final apiResponse = await authRequest.loginRequest(
        email: emailTEC.text,
        password: passwordTEC.text,
      );

      //
      handleDeviceLogin(apiResponse);

      setBusy(false);
    }
  }

  ///
  ///
  ///
  handleDeviceLogin(ApiResponse apiResponse) async {
    try {
      if (apiResponse.hasError()) {
        //there was an error
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Login Failed".i18n,
          text: apiResponse.message,
        );
      } else {
        //everything works well
        //firebase auth
        final fbToken = apiResponse.body["fb_token"];
        await FirebaseAuth.instance.signInWithCustomToken(fbToken);
        await AuthServices.saveUser(apiResponse.body["user"]);
        await AuthServices.setAuthBearerToken(apiResponse.body["token"]);
        await AuthServices.isAuthenticated();
        viewContext.pop(true);
      }
    } on FirebaseAuthException catch (error) {
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Login Failed".i18n,
        text: "${error.message}",
      );
    } catch (error) {
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Login Failed".i18n,
        text: "${error}",
      );
    }
  }

  ///

  void openRegister({
    String email,
    String name,
    String phone,
  }) async {
    viewContext.push(
      (context) => RegisterPage(
        email: email,
        name: name,
        phone: phone,
      ),
    );
  }

  void openForgotPassword() {
    viewContext.navigator.pushNamed(
      AppRoutes.forgotPasswordRoute,
    );
  }
}
