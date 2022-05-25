import 'package:flutter/material.dart';

import '../../shared/components.dart';
import '../../shared/cubit/home_cubit.dart';

class AddPasswordScreen extends StatelessWidget {
    AddPasswordScreen({Key? key}) : super(key: key);
TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: media.height * .05,
            ),
            Container(),
            Text(
              'Category',
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
              value: 'Social',
              onChanged: (val) {},
              items: categories,
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
              'Websites',
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
              value: 'Facebook',
              onChanged: (val) {},
              items: subCategories,
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
            defaultTextForm(
              context,
              onSubmit: (val) {
                print(val);
              },
              validate: (val) {
                if (val!.isEmpty) {
                  return 'Enter search word';
                }
              },
              type: TextInputType.text,
              text: 'Enter your password',
              icon: Icons.password_outlined,
              controller: controller,
              onChange: (value) {
                print(value);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
          ],
        ),
      ),
    );
  }
}
