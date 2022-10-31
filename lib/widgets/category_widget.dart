// ignore_for_file: prefer_const_constructors

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:store_app/constants/global_colors.dart';
import 'package:store_app/models/category_model.dart';
import 'package:store_app/screens/feeds_screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Categories categoriesProvider = Provider.of<Categories>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: FeedsScreen(), type: PageTransitionType.fade));
          },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FancyShimmerImage(
                width: size.width * 0.45,
                height: size.width * 0.45,
                errorWidget: Icon(
                  IconlyBold.danger,
                  color: Colors.red,
                  size: 30,
                ),
                imageUrl: categoriesProvider.image.toString(),
                boxFit: BoxFit.fill,
              ),
            ),
            Text(
              categoriesProvider.name.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                backgroundColor: lightCardColor.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
