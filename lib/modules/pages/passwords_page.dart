import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_wallet/models/site_model.dart';
import 'package:password_wallet/shared/cubit/home_states.dart';

import '../../shared/components.dart';
import '../../shared/cubit/home_cubit.dart';

class PasswordsScreen extends StatelessWidget {
  PasswordsScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
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
                text: 'search websites',
                icon: Icons.search,
                controller: searchController,
                onChange: (value) {
                  print(value);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                height: MediaQuery.of(context).size.height * .05,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  itemBuilder: (context, index) {
                    return categoryElement(
                        context, index, cubit.category_elements[index]);
                  },
                  itemCount: cubit.category_elements.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: cubit.categories.length,
                    itemBuilder: (context, index) {
                      return siteItem(context, cubit.categories[index]);
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget categoryElement(context, index, model) {
  HomeCubit cubit = HomeCubit.get(context);
  return Padding(
    padding: const EdgeInsets.all(.0),
    child: InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: () {
        cubit.getSiteItems(category: model);
        cubit.changeIndexList(index);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(colors: [Colors.green, Colors.yellow])),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: index == cubit.cIndex
                ? Colors.green.shade900
                : Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          height: 10,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          )),
        ),
      ),
    ),
  );
}

