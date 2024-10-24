import 'package:flutter/material.dart';
import 'package:sharlift/features/cart%20tab/screens/view_all_details.dart';
import 'package:sharlift/features/cart%20tab/services/cart_services.dart';

import 'package:sharlift/models/product_model.dart';

class CartPage extends StatefulWidget {
  static const String routeName = "/cart-page";
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductModel>? product;
  final CartServices cartServices = CartServices();

  @override
  void initState() {
    super.initState();
    fetchPendingPlease();
    // debugPrint('hello $product');
  }

  fetchPendingPlease() async {
    product = await cartServices.fetchPending(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  fetchPendingPlease();
                });
              },
              child: const Text(
                "Your Cart -",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'CaviarDreams',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        elevation: 2, // This ensures no default shadow
        backgroundColor: Colors.white, // Explicitly set to pure white
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.transparent,
      ),
      body: product == null
          ? const Center(
              child:
                  CircularProgressIndicator()) // or any widget you want to show when product is null
          : ListView.builder(
              itemCount: product!.length,
              itemBuilder: (context, index) {
                final currProduct = product![index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("From: ${currProduct.from.toUpperCase()}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("To: ${currProduct.to.toUpperCase()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Date: ${currProduct.date_of_start.toUpperCase()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Time: ${currProduct.time_of_start.toUpperCase()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Point : ${currProduct.pickUpPoint.toUpperCase()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            height: 50,
                            width: MediaQuery.of(context)
                                .size
                                .width, //height of button
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Color.fromARGB(255, 0, 0, 0)),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ViewAllDetails.routeName,
                                    arguments: currProduct);
                              },
                              child: const Text(
                                "View All Details",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ], //this is end
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
