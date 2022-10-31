// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:store_app/models/products_model.dart';
import 'package:store_app/widgets/feeds_widget.dart';

class FeedsGrid extends StatelessWidget {
  const FeedsGrid({
    Key? key,
    required this.prouductList,
  }) : super(key: key);
  final  List<ProductsModel> prouductList;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 0.6),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: prouductList[index],
          child: FeedWidget(
        
          ),
        );
      },
    );
  }
}
