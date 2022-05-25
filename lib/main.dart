import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_wallet/modules/home_layout.dart';
import 'package:password_wallet/modules/verification_screen.dart';
import 'package:password_wallet/shared/bloc_observer.dart';
import 'package:password_wallet/shared/connectivity_cubit/connectivity_cubit.dart';
import 'package:password_wallet/shared/constants.dart';
import 'package:password_wallet/shared/constants.dart';
import 'package:password_wallet/shared/cubit/home_cubit.dart';
import 'package:password_wallet/shared/cubit/home_states.dart';
import 'package:password_wallet/shared/local/CacheHelper.dart';
import 'package:password_wallet/shared/themes/themes.dart';

import 'modules/onboarding_screen.dart';
import 'modules/register_screen.dart';

void main() async {
   late Widget widget;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getSavedData(key: 'isDark');
  token = CacheHelper.getSavedData(key: 'token');
  // CacheHelper.clearCache(key: 'token');
 bool onBoarding = CacheHelper.getSavedData(key: 'onBoarding')??true;
  if(onBoarding){
  widget=OnBoardingScreen();
}
  else if(token!=null)
    {
      widget=HomeLayout();

    }
  else{
    widget =RegisterScreen();
}
  // print('${isDark}===========');
  print('token is : ${token}');

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark,
        starWidget: widget,
      ));
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? starWidget;

  const MyApp({Key? key, required this.isDark, this.starWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            HomeCubit()
              ..changeDarkMode(fromShared: isDark)..getSiteItems(category: 'All'),
          ),
          BlocProvider(
            create: (context) => ConnectivityCubit(),
          )
        ],
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) => {},
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                // theme: ThemeOption.theme(isDark: false),
                // darkTheme: ThemeOption.theme(isDark: true),
                // themeMode: CacheHelper.getSavedData(key: 'isDark')
                //     ? ThemeMode.dark
                //     : ThemeMode.light,
                routes:{
                  VerificationScreen.routeName:(context)=>VerificationScreen(),

                },
                theme: ThemeOption.theme(isDark: HomeCubit
                    .get(context)
                    .isDark),
                home: starWidget);
          },
        ));
  }
}
