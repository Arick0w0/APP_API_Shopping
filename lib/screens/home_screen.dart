import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_api_flutter_course/constands/global_colors.dart';
import 'package:store_api_flutter_course/models/products_model.dart';
import 'package:store_api_flutter_course/screens/categories_screen.dart';
import 'package:store_api_flutter_course/screens/feeds_screen.dart';
import 'package:store_api_flutter_course/screens/user_screen.dart';
import 'package:store_api_flutter_course/services/api_handler.dart';
import 'package:store_api_flutter_course/widgets/appbar_icons.dart';
import 'package:store_api_flutter_course/widgets/feeds_grid.dart';
import 'package:store_api_flutter_course/widgets/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController = TextEditingController();
  // List<ProductModel> productsList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  // Future<void> getProducts() async {
  //   productsList = await APIHandler.getAllProducts();
  //   setState(() {});
  // }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // for TextField Scope
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          leading: AppBarIcons(
            function: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const CategoriesScreen(),
                      type: PageTransitionType.fade));
            },
            icon: IconlyBold.category,
          ),
          actions: [
            AppBarIcons(
              function: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const UserScreen(),
                        type: PageTransitionType.fade));
              },
              icon: IconlyBold.user3,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Gap(18),
              // ---------- Search Bar ----------
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search ...",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Theme.of(context).cardColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: lightIconsColor,
                  ),
                ),
              ),

              // ---------- Sale Menu ---------------
              const Gap(18),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                      child: Swiper(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const SaleWidget();
                        },
                        pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                                color: Colors.white, activeColor: Colors.red)),
                        // control: SwiperControl(),
                      ),
                    ),
                    // const Gap(15),

                    // ------Category Menu ------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Latest Products",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          AppBarIcons(
                              function: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const FeedsScreen(),
                                        type: PageTransitionType.fade));
                              },
                              icon: IconlyBold.arrowDown2)
                        ],
                      ),
                    ),
                    // ---- Feed Grid -------------
                    FutureBuilder<List<ProductModel>>(
                        future: APIHandler.getAllProducts(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            Center(
                              child: Text("An error occured ${snapshot.error}"),
                            );
                          } else if (snapshot.data == null) {
                            const Center(
                              child: Text("No products has been added yet"),
                            );
                          }
                          return FeedsGridWidget(productsList: snapshot.data!);
                        }))
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
