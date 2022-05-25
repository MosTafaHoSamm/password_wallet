import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:password_wallet/models/site_model.dart';
import 'package:password_wallet/modules/home_layout.dart';
import 'package:password_wallet/modules/pages/add_password_page.dart';
import 'package:password_wallet/modules/pages/generator_page.dart';
import 'package:password_wallet/modules/pages/passwords_page.dart';
import 'package:password_wallet/modules/pages/settings_page.dart';
import 'package:password_wallet/shared/components.dart';
import 'package:password_wallet/shared/cubit/home_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../local/CacheHelper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  bool isDark = false;

  static HomeCubit get(context) => BlocProvider.of(context);

  changeDarkMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeDarkState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark);

      emit(ChangeDarkState());
    }
  }

  int currentIndex = 0;

  changePage(index) {
    currentIndex = index;
    emit(OnPageChangeState());
  }

  String verificationId = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  void verifyPhone(context, {required String phoneNumber}) async {
    await auth
        .verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) {
              auth.signInWithCredential(credential).then((value) {
                emit(AuthSuccessState());
              }).catchError((error) {
                emit(AuthErrorState(
                    error:
                        'Something Error Please Check Your Internet and Try Again'));
              });
            },
            verificationFailed: (FirebaseAuthException e) {
              MySnackBar.showSnack(
                  message: e.message!.trimLeft().toString(),
                  title: 'Error',
                  color: Colors.red,
                  context: context);
              print("error is $e");
            },
            codeSent: (verificationId, code) {
              this.verificationId = verificationId;
              emit(PhoneNumberSubmittedState());
            },
            codeAutoRetrievalTimeout: (code) {})
        .then((value) {})
        .catchError((error) {
      print('Error is $error');
    });
  }

  void submitOtp({
    context,
    required String smsCode,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      await CacheHelper.saveData(key: 'token', value: value.user?.uid);
//j8wNq9lloaU4qRTp0OYRaDBs2Ok1     aVBgtLdisUfUfNy0FkogHQtuOR32
      print('token is : ${token}');
      emit(AuthSuccessState());
    }).catchError((error) {
      debugPrint('error is ${error}');

      emit(AuthErrorState(
          error: 'Something Error Please Check Your Internet and Try Again'));
    });
  }

  void logOut() {
    auth.signOut().then((value) {
      CacheHelper.clearCache(key: 'token');
      emit(SignOutSuccessState());
    }).catchError((error) {
      print(error);
    });
  }

  int currentIndexNav = 0;

  void changeIndex(index) {
    currentIndexNav = index;
    emit(ChangeIndexState());
  }

  List<GButton> gButtonNav = [
    const GButton(
      icon: LineIcons.key,
      text: 'Passwords',
      padding: EdgeInsets.all(6),
      iconActiveColor: Colors.green,
      iconColor: Colors.grey,
    ),
    const GButton(
      icon: LineIcons.lock,
      text: 'Generator',
      padding: EdgeInsets.all(6),
      iconActiveColor: Colors.green,
      iconColor: Colors.grey,
    ),
    const GButton(
      icon: LineIcons.plusCircle,
      text: 'Add Password',
      padding: EdgeInsets.all(6),
      iconActiveColor: Colors.green,
      iconColor: Colors.grey,
    ),
    const GButton(
      icon: LineIcons.cog,
      text: 'Settings',
      padding: EdgeInsets.all(6),
      iconActiveColor: Colors.green,
      iconColor: Colors.grey,
    ),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.vpn_key_rounded), label: 'Passwords'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.vpn_key_rounded), label: 'Passwords'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.vpn_key_rounded), label: 'Passwords'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.vpn_key_rounded), label: 'Passwords'),
  ];

  List<Widget> pages = [
    PasswordsScreen(),
    GeneratorScreen(
      fromAddPass: true,
    ),
      AddPasswordScreen(),
    const SettingsScreen()
  ];
  List<String> category_elements = ['All', 'Social', 'Finance', 'Others'];
  int cIndex = 0;

  void changeIndexList(index) {
    cIndex = index;
    emit(ChangeColorLisViewState());
  }

  List<SiteModel> siteList = [
    SiteModel(
        siteName: 'Instagram',
        siteCategory: 'Social',
        sitePassword: '01017&*#mM',
        siteImage: 'assets/images/instagram.png'),
    SiteModel(
        siteName: 'Facebook',
        siteCategory: 'Social',
        sitePassword: '01017&*99#mM',
        siteImage: 'assets/images/facebook.png'),
    SiteModel(
        siteName: 'Instagram',
        siteCategory: 'Social',
        sitePassword: '0101fhhfh7&*#mM',
        siteImage: 'assets/images/instagram.png'),
    SiteModel(
        siteName: 'LinKedIn',
        siteCategory: 'Social',
        sitePassword: '01017&*#mM',
        siteImage: 'assets/images/linkedin.png'),
    SiteModel(
        siteName: 'Netflix',
        siteCategory: 'Others',
        sitePassword: '010241&&*&*#mM',
        siteImage: 'assets/images/netflix.png'),
    SiteModel(
        siteName: 'applepay',
        siteCategory: 'Finance',
        sitePassword: '010241&&*&*#mM',
        siteImage: 'assets/images/applepay.png'),
    SiteModel(
        siteName: 'Check',
        siteCategory: 'Others',
        sitePassword: '010241&&*&*#mM',
        siteImage: 'assets/images/applepay.png'),
  ];
  List<SiteModel> categories = [];

  getSiteItems({required String category}) {
    if (categories.isNotEmpty) {
      categories = [];
    }
    if (category == 'All') {
      categories = siteList;
    } else {
      categories.addAll(
          siteList.where((element) => element.siteCategory == category));
    }
    emit(ChangeCategoryScreenState());

    // return siteList.where((element) {
    //    return element.siteCategory == category;
  }

  List<bool> checked = [true, true, true];

  changeCheckList(index) {
    checked[index] = !checked[index];
    print('$index+${checked[index]}');
    emit(ChangeCheckedBoxState());
  }
  int passLength=6;
  changePassLength(index){
    passLength=index;
    emit(PassLengthChangeState());


  }
String password='';
  generatePassword(context) {
    var checkList = HomeCubit.get(context).checked;
    const String lowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const String upperCase = 'ABCDEFGHIJKLMNOPQRSTUVXYZ';
    const String special = '!@#\$%^&*()_+{}[]';
    const String numbers = '1234567890';
    String chars = '';
    if (checkList[2]) {
      chars += upperCase + lowerCase;
    }
    if (checkList[1]) {
      chars += numbers;
    }
    if (checkList[0]) {
      chars += special;
    }
     password= List.generate(passLength, (index) {
      int randomIndex = Random.secure().nextInt(chars.length);
      return chars[randomIndex];
    }).join('');

    emit(GeneratePassword());

  }


}
