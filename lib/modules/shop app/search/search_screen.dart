// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/modules/shop%20app/search/cubit/cubit.dart';
import 'package:sallla_app/modules/shop%20app/search/cubit/states.dart';
import 'package:sallla_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                  children:
                  [
                Container(
                  child: defaultForm(
                    controller: searchController,
                    type: TextInputType.text,
                    lapel: 'Search',
                    prefix: Icons.search_sharp,
                    onTap: () {},
                    onChange: () {},
                    onSup: (String text)
                    {
                      SearchCubit.get(context).search(text);
                    },
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Text To Search';
                      }
                      return null;
                    },
                  ),
                ),
                    const SizedBox(height: 30.0,),
                    if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                    const SizedBox(height:15.5 ,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).model!.data!.data![index],
                            context,
                            isOldPrice: false
                        ),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
              ]),
            ),
          ),
        );
        },
      ),
    );
  }
}
