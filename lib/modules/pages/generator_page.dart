import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_wallet/shared/cubit/home_states.dart';

import '../../shared/components.dart';
import '../../shared/cubit/home_cubit.dart';

class GeneratorScreen extends StatelessWidget {
  final bool fromAddPass;

  const GeneratorScreen({Key? key, required this.fromAddPass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: media.height * .05,
                  ),
                  Container(),
                  Text(
                    'Password Length',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textSelectionColor,
                    ),
                  ),
                  SizedBox(
                    height: media.height * .02,
                  ),
                  DropdownButtonFormField(
                    value: HomeCubit.get(context).passLength,
                    onChanged: (val) {
                      HomeCubit.get(context).changePassLength(val);
                    },
                    items: passLengthItems,
                    focusColor: Colors.green,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor),
                  ),
                  SizedBox(
                    height: media.height * .02,
                  ),
                  Text(
                    'Symbols',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textSelectionColor,
                    ),
                  ),
                  SizedBox(
                    height: media.height * .01,
                  ),
                  buildPass(context, '\$/%^&@#_+^&^":><?', 0),
                  SizedBox(
                    height: media.height * .01,
                  ),
                  Text('Numbers',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textSelectionColor,
                      )),
                  buildPass(context, '234567890856312', 1),
                  SizedBox(
                    height: media.height * .01,
                  ),
                  Text('UpperCase',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textSelectionColor,
                      )),
                  buildPass(context, 'ABCDEFGHIJKLMNO', 2),
                  Text('Generated Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textSelectionColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: () {},
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.all(2.5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            gradient: LinearGradient(
                                colors: [Colors.green, Colors.yellow])),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .06,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  generatePassword(context),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                            text: HomeCubit.get(context)
                                                .password))
                                        .then((value) {
                                      MySnackBar.showSnack(
                                          message:
                                              'Password copied to ClipBoard !',
                                          title: '',
                                          color: Colors.green,
                                          context: context);

                                    });
                                  },
                                  icon: const Icon(Icons.copy),
                                  color: Colors.green,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ))),
                      onPressed: () {
                        HomeCubit.get(context).generatePassword(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Generate Password',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget checkBox(context, index) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: () {
        HomeCubit.get(context).changeCheckList(index);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(2.5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            gradient: LinearGradient(colors: [Colors.green, Colors.yellow])),
        child: Container(
          width: MediaQuery.of(context).size.height * .06,
          height: MediaQuery.of(context).size.height * .06,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
            color: (HomeCubit.get(context).checked[index])
                ? Colors.lightGreen
                : Theme.of(context).backgroundColor,
            child: Icon(
              Icons.check,
              size: 24,
              color: Theme.of(context).textSelectionColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPass(context, text, index) {
    var media = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 8,
          child: itemSetting(context,
              suffixIcon: null, text: text, function: () {}),
        ),
        SizedBox(
          width: media.width * .04,
        ),
        checkBox(context, index),
      ],
    );
  }

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
    return List.generate(HomeCubit.get(context).passLength, (index) {
      int randomIndex = Random.secure().nextInt(chars.length);
      return chars[randomIndex];
    }).join('');
  }
}
