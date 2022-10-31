// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_app/constants/global_colors.dart';
import 'package:store_app/models/products_model.dart';
import 'package:store_app/screens/category_screen.dart';
import 'package:store_app/screens/feeds_screen.dart';
import 'package:store_app/screens/users_screen.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/appbar_icons.dart';
import 'package:store_app/widgets/feeds_grid.dart';
import 'package:store_app/widgets/feeds_widget.dart';
import 'package:store_app/widgets/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<ProductsModel> prouductList = [];
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }
/*   @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }
  Future<void> getData () async{
    prouductList = await ApiHandler.getAllProduct();
    setState(() {
      
    });
  } */

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          //elevation: 4,
          title: Text('Home'),
          leading: AppBarIcons(
            icon: IconlyBold.category,
            function: () {
              Navigator.push(
                context,
                PageTransition(
                    child: CategoryScreen(), type: PageTransitionType.fade),
              );
            },
          ),
          actions: [
            AppBarIcons(
              icon: IconlyBold.user3,
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: UsersScreen(), type: PageTransitionType.fade),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 18.0,
              ),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: lightIconsColor,
                    )),
              ),
              SizedBox(
                height: 18.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Swiper(
                          autoplay: true,
                          pagination: SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.white,
                              activeColor: Colors.red,
                              //  activeSize: 15,
                            ),
                          ),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return SaleWidget();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Latest Products',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppBarIcons(
                                icon: IconlyBold.arrowRight2,
                                function: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        child: FeedsScreen(),
                                        type: PageTransitionType.fade),
                                  );
                                })
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductsModel>>(
                        future: ApiHandler.getAllProduct(limit: 3.toString()),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          return FeedsGrid(
                            prouductList: snapshot.data!,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
