import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:password_wallet/models/site_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget flatButton(
  BuildContext context, {
  required Function() onPressed,
  required String text,
}) {
  return Container(
    height: MediaQuery.of(context).size.height * .06,
    width: MediaQuery.of(context).size.width - 40,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    ),
  );
}

class MySnackBar extends Flushbar {
  MySnackBar({Key? key}) : super(key: key);

  static Flushbar showSnack({
    required String message,
    required String title,
    required Color color,
    required context,
  }) {
    return Flushbar(
      icon: Icon(Icons.notifications),
      title: title,
      margin: EdgeInsets.all(10),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      messageText: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Theme.of(context).textSelectionColor,
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
      ),
      backgroundColor: color,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      animationDuration: const Duration(milliseconds: 1000),
      duration: const Duration(milliseconds: 3000),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
    )..show(context);
  }
}

Widget snackBar(
  context, {
  required String text,
}) {
  return Flushbar(
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    animationDuration: Duration(seconds: 3),
    borderRadius: BorderRadius.all(Radius.circular(10)),
    backgroundColor: Colors.green,
    message: text,
    textDirection: TextDirection.ltr,
    messageSize: 16,
  )..show(context);
  // return SnackBar(
  //   content: Text(text),
  //   shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(10))),
  //   dismissDirection: DismissDirection.startToEnd,
  //  );
}

Widget defaultTextForm(
  context, {
  required TextInputType type,
  required TextEditingController controller,
  required Function(String value) onChange,
  required Function(String value) onSubmit,
  required String? Function(String? value) validate,
  required IconData icon,
  required String text,
}) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      gradient: LinearGradient(
          colors: [Colors.green, Colors.yellow],
          tileMode: TileMode.clamp,
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          stops: [0.1, .5]),
    ),
    child: TextFormField(
        validator: validate,
        keyboardType: type,
        onChanged: onChange,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textCapitalization: TextCapitalization.sentences,
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          errorMaxLines: 4,
          errorBorder: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Colors.grey,
                fontSize: 17,
              ),
          prefixIcon: Icon(icon),
          hintText: text,
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          border: InputBorder.none,
        )),
  );
}

Widget siteItem(context, SiteModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(2.5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          gradient: LinearGradient(colors: [Colors.green, Colors.yellow])),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                height: 100,
                width: 100,
                child: Image.asset('${model.siteImage}')),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  '${model.siteName}',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${model.sitePassword}',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Column(
                children: [
                  Text(
                    '${model.siteCategory}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Material(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.transparent,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: IconButton(
                            splashRadius: 20,
                            color: Theme.of(context).textSelectionColor,
                            highlightColor: Colors.amber,
                            splashColor: Colors.pinkAccent,
                            onPressed: () {},
                            icon: const Icon(Icons.copy)),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget itemSetting(
  context, {
  IconData? preIcon,
  IconData? suffixIcon,
  required String text,
  required Function() function,
  Function()? function2,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      onTap: function,
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(2.5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            gradient: LinearGradient(colors: [Colors.green, Colors.yellow])),
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(preIcon),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                  style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                IconButton(
                    onPressed: function2,
                    icon: Icon(
                      suffixIcon,
                      color: Colors.green,
                    ))
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

List<DropdownMenuItem<int>> passLengthItems = const [
  DropdownMenuItem(
    child: Text('6 Items'),
    value: 6,
  ),
  DropdownMenuItem(
    child: Text('8 Items'),
    value: 8,
  ),
  DropdownMenuItem(
    child: Text('16 Items'),
    value: 16,
  ),
];
List<DropdownMenuItem<String>> categories = const [
  DropdownMenuItem(
    child: Text('Social'),
    value: 'Social',
  ),
  DropdownMenuItem(
    child: Text('Finance'),
    value: 'Finance',
  ),
  DropdownMenuItem(
    child: Text('Others'),
    value: 'Others',
  ),
];
List<DropdownMenuItem<String>> subCategories = [
  DropdownMenuItem(
    child: Container(
      height: 100,
      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/facebook.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Text(
            'FaceBook',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Facebook',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/instagram.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Text(
            'Instagram',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Instagram',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/linkedin.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Text(
            'Linkedin',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Linkedin',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/twitter.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Text(
            'Twitter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Twitter',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/amazonpay.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Text(
            'AmazonPay',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'AmazonPay',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/applepay.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Text(
            'ApplePay',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),

        ],
      ),
    ),
    value: 'ApplePay',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,
      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/ebay.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          Text(
            'Ebay',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Ebay',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/netflix.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
         const  Text(
            'Netflix',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Netflix',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/paypal.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          const  Text(
            'Paypal',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),

        ],
      ),
    ),
    value: 'Paypal',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/mega.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          const  Text(
            'Mega',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Mega',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/spotify.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          const  Text(
            'Spotify',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Spotify',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,

      child: Row(
        children: [
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/drive.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          const  Text(
            'Drive',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Drive',
  ),
  DropdownMenuItem(
    child: Container(
      height: 100,
      child: Row(
        children: [
          Container(
               child: Image.asset(
                'assets/images/check.png',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 20),
          const  Text(
            'Check',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
    value: 'Check',
  ),
];
