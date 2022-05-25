import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_wallet/models/onboarding_variables.dart';
import 'package:password_wallet/modules/register_screen.dart';
import 'package:password_wallet/shared/components.dart';
import 'package:password_wallet/shared/local/CacheHelper.dart';
import 'package:password_wallet/shared/themes/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/cubit/home_cubit.dart';
import '../shared/cubit/home_states.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final PageController controller = PageController();
  final int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .2,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.height * .8,
                  child: PageView.builder(
                      onPageChanged: (index) {
                        cubit.changePage(index);
                        print(index);
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: OnBoardingVariables.onBoarding.length,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return boardingItem(
                            model: OnBoardingVariables.onBoarding[index]);
                      }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                cubit.currentIndex != 2
                    ? SmoothPageIndicator(
                        axisDirection: Axis.horizontal,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ThemeOption.primarySwatch,
                        ),
                        count: 3,
                        controller: controller,
                      )
                    : flatButton(context, onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                            (route) => false).then((value) async{

                        });
                          CacheHelper.saveData(key: 'onBoarding', value: false);



                }, text: "Get Started"),
                const Spacer(),
                Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: IconButton(
                        onPressed: () {
                          cubit.changeDarkMode();
                        },
                        icon: Icon(Icons.brightness_4_rounded)))
              ],
            ),
          );
        });
  }
}

Widget boardingItem({
  required OnBoardingVariables model,
}) {
  return Column(
    children: [
      SizedBox(height: 150, width: 150, child: Image.asset('${model.image}')),
      const SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Container(
        width: 300,
        child: Text(
          '${model.description}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
