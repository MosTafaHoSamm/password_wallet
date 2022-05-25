import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_wallet/models/site_model.dart';

import '../../shared/components.dart';
import '../../shared/cubit/home_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .12,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              gradient:
                  LinearGradient(colors: [Colors.amber.shade300, Colors.green]),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Material(
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundColor: Colors.amber.shade500,
                      radius: 38,
                      child: const CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/instagram.png')),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome User Number',
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      '+201017242252',
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .12,
          ),
          itemSetting(context,
              function: () {},
              text: 'Change Password',
              preIcon: Icons.lock,
              suffixIcon: Icons.arrow_forward_ios_rounded),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          itemSetting(context,
              function: () {},
              text: 'Change Pin',
              preIcon: Icons.vpn_key_sharp,
              suffixIcon: Icons.arrow_forward_ios_rounded),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(2.5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  gradient:
                      LinearGradient(colors: [Colors.green, Colors.yellow])),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.brightness_4_outlined),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Switch(
                          activeColor: Colors.green,
                          value: cubit.isDark,
                          onChanged: (val) {
                            cubit.changeDarkMode();
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          itemSetting(context, function: () {
            debugPrint('SignOuted');
          }, function2: () {
            debugPrint('SignOuted');
          },
              text: 'Sign Out',
              preIcon: Icons.logout_outlined,
              suffixIcon: Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
