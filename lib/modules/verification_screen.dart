import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_wallet/modules/home_layout.dart';

import 'package:password_wallet/shared/components.dart';
import 'package:password_wallet/shared/cubit/home_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../shared/cubit/home_states.dart';

class VerificationScreen extends StatelessWidget {
  static String routeName = '/VerificationScreen';

  VerificationScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String? phoneNumber =
        ModalRoute.of(context)?.settings.arguments.toString();

    var h = MediaQuery.of(context).size.height;
    TextStyle style2 = Theme.of(context).textTheme.subtitle1!.copyWith(
        fontSize: 14,
        height: 1.3,
        letterSpacing: 1.1,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).textSelectionColor);
    TextStyle style1 = Theme.of(context).textTheme.headline1!.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.3,
        wordSpacing: 1,
        height: 1.3,
        color: Theme.of(context).textSelectionColor);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeLayout()),
              (route) => false);
        } else if (state is AuthErrorState) {
          MySnackBar.showSnack(
              message: state.error.toString(),
              title: 'Error',
              color: Colors.redAccent,
              context: context);
          // snackBar(text: state.error);
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
                      "Enter Your \nVerification Code",
                      style: style1,
                    ),
                    SizedBox(
                      height: .08 * h,
                    ),
                    FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("A text Message with 6 digits code",
                              style: style2.copyWith()),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("was sent to ", style: style2.copyWith()),
                              Text("+2$phoneNumber",
                                  style: style2.copyWith(color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: .12 * h,
                    ),
                    PinCodeTextField(
                      obscureText: false,
                      enableActiveFill: true,
                      length: 6,
                      onChanged: (String value) {},
                      appContext: context,
                      controller: controller,
                      animationType: AnimationType.slide,
                      pinTheme: const PinTheme.defaults(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        activeFillColor: Colors.grey,
                        selectedFillColor: Colors.grey,
                        inactiveFillColor: Colors.white,
                        inactiveColor: Colors.green,

                        // activeColor: Colors.white
                      ),
                      animationDuration: const Duration(milliseconds: 100),
                      validator: (value) {},
                      keyboardType: TextInputType.number,
                      animationCurve: Curves.fastLinearToSlowEaseIn,
                      boxShadows: const [
                        BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.grey,
                            blurRadius: 2)
                      ],
                      onSubmitted: (codeSubmitted) {},
                    ),
                    SizedBox(height: h * .02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        flatButton(context, onPressed: () {
                          HomeCubit.get(context).submitOtp(
                              context: context, smsCode: controller.text);
                        }, text: 'Verify'),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
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
