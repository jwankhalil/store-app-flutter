// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:store_app/constants/global_colors.dart';
import 'package:store_app/models/products_model.dart';
import 'package:store_app/screens/proudct_details.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsModel productsModelProvider =
        Provider.of<ProductsModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: ProductDetails(id: productsModelProvider.id.toString(),), type: PageTransitionType.fade));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                            text: '\$',
                            style: TextStyle(
                              color: Color.fromRGBO(33, 150, 243, 1),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${productsModelProvider.price}",
                                  style: TextStyle(
                                      color: lightTextColor,
                                      fontWeight: FontWeight.w600))
                            ]),
                      ),
                    ),
                    Icon(IconlyBold.heart)
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FancyShimmerImage(
                  width: double.infinity,
                  height: size.height * 0.2,
                  errorWidget: Icon(
                    IconlyBold.danger,
                    color: Colors.red,
                    size: 30,
                  ),
                  imageUrl: productsModelProvider.images![0],
                  boxFit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                productsModelProvider.title.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
