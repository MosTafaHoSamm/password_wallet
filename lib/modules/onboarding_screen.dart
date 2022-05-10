import 'package:flutter/material.dart';
class OnBoardingScreen extends StatelessWidget{
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.deepOrange,
            width: 400,
            height: 400,
          )
        ],
      ),
    );

  }
}