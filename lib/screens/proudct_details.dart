// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:store_app/constants/global_colors.dart';
import 'package:store_app/models/products_model.dart';
import 'package:store_app/services/api_handler.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductsModel? productsModel;
  bool isError = false;
  Future<void> getProductInfo() async {
    try {
      productsModel = await ApiHandler.getProdutById(widget.id);
    } catch (error) {
      log("error $error");
      setState(() {
        isError = true;
      });
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isError
            ? Center(
                child: Text('error'),
              )
            : productsModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 18.0,
                        ),
                        BackButton(),
                        //   SizedBox(height: 18.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productsModel!.category!.name.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      productsModel!.title.toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: RichText(
                                      text: TextSpan(
                                          text: '\$',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  33, 150, 243, 1)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '${productsModel!.price.toString()}',
                                                style: TextStyle(
                                                    color: lightTextColor,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                          child: Swiper(
                            itemBuilder: (context, index) {
                              return FancyShimmerImage(
                                width: double.infinity,
                                boxFit: BoxFit.fill,
                                imageUrl:
                                    productsModel!.images![index].toString(),
                              );
                            },
                            itemCount: 3,
                            autoplay: true,
                            pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                    activeColor: Colors.red,
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              Text(
                                productsModel!.description.toString(),
                                style: TextStyle(fontSize: 25.0),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
