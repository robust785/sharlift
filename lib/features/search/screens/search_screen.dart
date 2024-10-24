import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharlift/common/loading_screen.dart';
import 'package:sharlift/features/search/lift%20details/screens/lift_details_screen.dart';
import 'package:sharlift/features/search/services/search_services.dart';
import 'package:sharlift/models/product_model.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-product";
  final String from;
  final String to;
  const SearchScreen({
    super.key,
    required this.from,
    required this.to,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // String from = '';
  // String to = '';
  List<ProductModel>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    // getShare();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, from: widget.from, to: widget.to);
    setState(() {});
  }

  // getShare() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     // widget.from = prefs.getString('from').toString();
  //     // widget.to = prefs.getString('to').toString();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.08,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search Results-",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'CaviarDreams',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              elevation: 2, // This ensures no default shadow
              backgroundColor: Colors.white, // Explicitly set to pure white
              shadowColor: Colors.grey,
              surfaceTintColor: Colors.transparent,
            ),
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, LiftDetailsScreen.routeName,
                            arguments: productData);
                      },
                      child: Container(
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
                        margin: const EdgeInsets.all(10),
                        height: 182,
                        width: 165,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("From: ${productData.from.toUpperCase()}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("To: ${productData.to.toUpperCase()}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                                "By- ${productData.firstName.toUpperCase()} ${productData.lastName.toUpperCase()}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
