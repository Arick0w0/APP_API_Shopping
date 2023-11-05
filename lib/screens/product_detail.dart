import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:store_api_flutter_course/constands/global_colors.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Gap(18),
              BackButton(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Gap(18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          "Lorem Ipsum",
                          textAlign: TextAlign.start,
                          style: titleStyle,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: RichText(
                          text: TextSpan(
                              text: '\$',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "168.00",
                                    style: TextStyle(
                                        color: lightTextColor,
                                        fontWeight: FontWeight.bold))
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const Gap(18),
                ],
              ),
              SizedBox(
                height: size.height * 0.4,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return FancyShimmerImage(
                      imageUrl: "https://i.ibb.co/vwB46Yq/shoes.png",
                      boxFit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: 3,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      )),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: titleStyle,
                  ),
                  const Gap(18),
                  const Text(
                    "Alignment: Check if there is any alignment specified for the parent widgets. For example, if the parent Column is inside another widget with alignment properties, it could affect the layout.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 25),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
