 import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_wallet/modules/verification_screen.dart';
import 'package:password_wallet/shared/components.dart';
import 'package:password_wallet/shared/cubit/home_cubit.dart';
 // import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
 // import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import '../shared/cubit/home_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  CountryCode _countryCode = CountryCode(name: 'Eg', dialCode: '+2');

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery
        .of(context)
        .size
        .height;
    TextStyle style2 = Theme
        .of(context)
        .textTheme
        .subtitle1!
        .copyWith(
        fontSize: 14,
        height: 1.3,
        letterSpacing: 1.1,
        fontWeight: FontWeight.w400,
        color: Theme
            .of(context)
            .textSelectionColor);
    TextStyle style1 = Theme
        .of(context)
        .textTheme
        .headline1!
        .copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.3,
        wordSpacing: 1,
        height: 1.3,
        color: Theme
            .of(context)
            .textSelectionColor);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is PhoneNumberSubmittedState) {
          Navigator.pushNamed(
              context, VerificationScreen.routeName,
              arguments: controller.text);

        }
        else if (state is AuthErrorState) {
          MySnackBar.showSnack(message: state.error.toString(),
              title: 'Error',
              color: Colors.redAccent,
              context: context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: .15 * h,
                    ),
                    Text(
                      "Enter Your \nPhone Number",
                      style: style1,
                    ),
                    SizedBox(
                      height: .08 * h,
                    ),
                    Text("Your Phone Number won\'t \nbe Visible in Public",
                        style: style2),
                    SizedBox(
                      height: .12 * h,
                    ),
                    Text(
                      "Phone Number",
                      style: style2,
                    ),
                    SizedBox(
                      height: .01 * h,
                    ),
                    TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter Phone Number',
                        prefixIcon: CountryCodePicker(
                          initialSelection: 'EG',
                          dialogTextStyle:
                          Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                          dialogBackgroundColor:
                          Theme
                              .of(context)
                              .backgroundColor,
                          onChanged: (code) {
                            _countryCode = code;
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.length < 11) {
                          return 'Enter Valid Phone Number';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: h * .02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                         flatButton(context, onPressed: () {
                              String fullNumber =
                                  '${_countryCode.dialCode}${controller.text}';
                              if (formKey.currentState!.validate()) {
                                HomeCubit.get(context)
                                    .verifyPhone(context,phoneNumber: fullNumber);
                                print(_countryCode);
                              }
                            }, text: 'Send Code'),


                      ],
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .05,
                    ),
                    RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: const TextStyle(
                                height: 1.3,
                                fontSize: 17,
                                wordSpacing: 1.3,
                                letterSpacing: 1),
                            text: 'By Continuing you Agree on Our ',
                            children: [
                              TextSpan(
                                  text: 'Terms of Service',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      decoration: TextDecoration.underline),
                                  children: [
                                    TextSpan(
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Theme
                                                .of(context)
                                                .textSelectionColor),
                                        text: ' and Confirming that you read ',
                                        children: const [
                                          TextSpan(
                                              text: 'Privacy policy.',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  decoration: TextDecoration
                                                      .underline)),
                                        ]),
                                  ])
                            ]))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
