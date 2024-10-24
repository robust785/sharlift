import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharlift/common/loading_screen.dart';
import 'package:sharlift/features/lifts%20posted%20tab/services/lift_posted_services.dart';
import 'package:sharlift/models/product_model.dart';
import 'package:sharlift/provider/user_provider.dart';

class LiftPosted extends StatefulWidget {
  static const String routeName = "/lift-posted";

  const LiftPosted({super.key});

  @override
  State<LiftPosted> createState() => _LiftPostedState();
}

class _LiftPostedState extends State<LiftPosted> {
  String email = '';

  List<ProductModel>? products;
  final LiftPostedServices liftServices = LiftPostedServices();

  @override
  void initState() {
    super.initState();
    getShare();
    fetchLiftPosted();
  }

  fetchLiftPosted() async {
    products =
        await liftServices.fetchPostedLift(context: context, email: email);
    setState(() {
      //debugPrint("heppoQQQQQQQQQQQQQQQQQQQ $products!.length.toString()");
    });
  }

  void getShare() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = Provider.of<UserProvider>(context, listen: false).user.email;
    });
  }

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
                    "Lifts Posted-",
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
            body: ListView.builder(
              itemCount: products!.length,
              physics: const BouncingScrollPhysics(),
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 1),
              itemBuilder: (context, index) {
                final productData = products![index];
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
                      height: 182,
                      width: MediaQuery.of(context).size.width,
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
                  ],
                );
              },
            ),
          );
  }
}
