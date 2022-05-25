import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:password_wallet/modules/pages/passwords_page.dart';
import 'package:password_wallet/modules/register_screen.dart';
import 'package:password_wallet/shared/components.dart';
import 'package:password_wallet/shared/cubit/home_states.dart';

import '../shared/cubit/home_cubit.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return SafeArea(

            child: Scaffold(
                bottomNavigationBar: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(),
                  child: GNav(
                    // padding: EdgeInsets.all(0),
                    textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textSelectionColor),
                    iconSize: 26,
                    gap: 5,
                    tabBorderRadius: 5,
                    tabMargin: EdgeInsets.all(5),
                    onTabChange: (index) {
                      cubit.changeIndex(index);
                    },
                    tabs: cubit.gButtonNav,
                    selectedIndex: cubit.currentIndexNav,
                    activeColor: Colors.green,

                    tabActiveBorder: Border.all(color: Colors.amber, width: 2),
                  ),
                )

                //
                ,
                body: cubit.pages[cubit.currentIndexNav]));
      },
    );
  }
}
