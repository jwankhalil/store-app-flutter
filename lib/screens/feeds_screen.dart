// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:store_app/models/products_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductsModel> prouductList = [];
  int limit = 10;
  // bool _isLoading = false;
  bool _isLimit = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(() async {
      if (limit == 200) {
        _isLimit = true;
        setState(() {});
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //  _isLoading = true;
        limit += 10;

        log('limit $limit');
        await getData();

        // _isLoading = false;
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    prouductList = await ApiHandler.getAllProduct(limit: limit.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Product'),
      ),
      body: prouductList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: prouductList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          childAspectRatio: 0.7),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: prouductList[index],
                          child: FeedWidget(),
                        );
                      }),
                  if (!_isLimit)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            ),
    );
  }
}
