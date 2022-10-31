// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/user_model.dart';
import 'package:store_app/services/api_handler.dart';

import 'package:store_app/widgets/user_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: ApiHandler.getAllUsers(),
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
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: UserWidget(),
                );
              }));
        }),
      ),
    );
  }
}
