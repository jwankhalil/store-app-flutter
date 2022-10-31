// ignore_for_file: prefer_const_constructors

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store_app/constants/global_colors.dart';
import 'package:store_app/models/user_model.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersModel usersModelProvider = Provider.of<UsersModel>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        width: size.width * 0.15,
        height: size.width * 0.15,
        errorWidget: Icon(
          IconlyBold.danger,
          color: Colors.red,
          size: 30,
        ),
        imageUrl: usersModelProvider.avatar.toString(),
        boxFit: BoxFit.fill,
      ),
      title: Text('${usersModelProvider.name}'),
      subtitle: Text(
        '${usersModelProvider.email}',
        //   style: TextStyle(color: lightTextColor, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        usersModelProvider.role.toString(),
        style: TextStyle(color: lightIconsColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
