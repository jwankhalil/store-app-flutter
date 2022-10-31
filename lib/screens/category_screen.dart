// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/category_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: FutureBuilder<List<Categories>>(
        future: ApiHandler.getAllCategories(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text("An error occured${snapshot.error}"),
            );
          } else if (snapshot.data == null) {
            Center(
              child: Text("An error occured2"),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 1.2),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: CategoryWidget());
            },
          );
        }),
      ),
    );
  }
}
