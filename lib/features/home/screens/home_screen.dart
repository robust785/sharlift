import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharlift/constants/toast_msg.dart';
import 'package:sharlift/features/add%20lift/screens/add_lift_screen.dart';
import 'package:sharlift/features/auth/screens/auth_screen.dart';
import 'package:sharlift/features/auth/services/auth_services.dart';
import 'package:sharlift/features/drawer/about_us.dart';
import 'package:sharlift/features/profile/screens/profile_update_screen.dart';
import 'package:sharlift/features/search/screens/search_screen.dart';
import 'package:sharlift/provider/user_provider.dart';

//check ontap of the button
class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthServices authService = AuthServices();

  void navigateToAboutUs() {
    Navigator.pushNamed(context, AboutUs.routeName);
  }

  void navigateToAddLiftScreen() {
    Navigator.pushNamed(context, AddLiftScreen.routeName);
  }

  void navigateToProfileUpdate() {
    Navigator.pushNamed(context, ProfileUpdate.routeName);
  }

  void saveShared(String f, String t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('from', f);
    prefs.setString('to', t);
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
    debugPrint("inside home page");
  }

  Future<void> _getUserData() async {
    await authService.getUserData(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController fromController = TextEditingController();
    final TextEditingController toController = TextEditingController();
    final user = Provider.of<UserProvider>(context).user;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    debugPrint(user.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              accountName: Text(
                user.firstName.toUpperCase(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              accountEmail: Text(
                user.email,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 228, 228, 228),
                child: ClipOval(
                    child: Image.network(userProvider.user.profilePhoto)
                    // : const Icon(Icons.percent_outlined),
                    ),
                // child: Image.network(userProvider.user.profilePhoto)),
              ),
            ),
            // const Divider(
            //   color: Color.fromARGB(123, 158, 158, 158),
            // ),
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Profile Update"),
              onTap: () => navigateToProfileUpdate(),
            ),
            ListTile(
                title: const Text("About Us"), onTap: () => navigateToAboutUs()
                //  {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => const AboutUs()));
                // },
                ),
            ListTile(
              title: const Text("Logout"),
              onTap: () async {
                try {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Alert",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          "You really want to logout ?",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                              child: const Text("Yes"),
                              onPressed: () async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.setString(
                                    'x-auth-token', '');
                                Navigator.popAndPushNamed(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  AuthScreen.routeName,
                                );
                              }),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  toastMsg(msg: e.toString());
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  _getUserData();
                });
              },
              child: const Text(
                "SharLift",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'CaviarDreams',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                const Text(
                  "hi,  ",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'CaviarDreams',
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  user.firstName.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'CaviarDreams',
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        elevation: 2, // This ensures no default shadow
        backgroundColor: Colors.white, // Explicitly set to pure white
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    padding: const EdgeInsets.all(5),
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const Text(
                            //   "want to ",
                            //   style: TextStyle(
                            //       fontSize: 40,
                            //       fontFamily: 'CaviarDreams',
                            //       fontWeight: FontWeight.w500),
                            // ),
                            // Text(
                            //   "SharLift ?",
                            //   style: TextStyle(
                            //       fontSize: 50,
                            //       fontFamily: 'CaviarDreams',
                            //       fontWeight: FontWeight.w600),
                            // )
                            //
                            AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  speed: const Duration(milliseconds: 200),
                                  'want to ',
                                  textStyle: const TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'CaviarDreams',
                                  ),
                                  colors: [Colors.black, Colors.white],
                                ),
                              ],
                              isRepeatingAnimation: true,
                              totalRepeatCount: 5,
                              displayFullTextOnTap: true,
                            ),
                            // AnimatedTextKit(
                            //   animatedTexts: [
                            //     ColorizeAnimatedText(
                            //       'SharLift ?',
                            //       textStyle: TextStyle(
                            //           fontSize: 50,
                            //           fontFamily: 'CaviarDreams',
                            //           fontWeight: FontWeight.w600),
                            //       colors: [Colors.black, Colors.white],
                            //     ),
                            //   ],
                            //   isRepeatingAnimation: true,
                            //   onTap: () {
                            //     print("Tap Event");
                            //   },
                            // )

                            const Text(
                              "SharLift ?",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontFamily: 'CaviarDreams',
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          height: 50, //height of input field
                          child: TextField(
                            controller: fromController,
                            enabled: true,
                            style: const TextStyle(
                              fontSize:
                                  20.0, //size badhega isse jo text type hoga uska
                            ),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.start_outlined),
                              filled: true,
                              hintText: "From",
                              hintStyle:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          height: 50, //height of input field
                          child: TextField(
                            controller: toController,
                            enabled: true,
                            style: const TextStyle(
                              fontSize:
                                  20.0, //size badhega isse jo text type hoga uska
                            ),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.stop_circle_outlined),
                              filled: true,
                              hintText: "To",
                              hintStyle:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.black),
                            ),
                            onPressed: () {
                              if (fromController.text == "") {
                                toastMsg(
                                    msg: "Please enter starting point",
                                    color_bg: Colors.yellow,
                                    color_text: Colors.black);
                                return;
                              }

                              if (toController.text == "") {
                                toastMsg(
                                    msg: "Please enter destination point",
                                    color_bg: Colors.yellow,
                                    color_text: Colors.black);
                                return;
                              }
                              saveShared(
                                  fromController.text, toController.text);
                              Navigator.pushNamed(
                                  context, SearchScreen.routeName, arguments: {
                                'from': fromController.text,
                                'to': toController.text
                              });
                            },
                            child: const Text(
                              "Search Lift",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Provider.of<UserProvider>(context, listen: false)
                  .user
                  .vehicalName
                  .isEmpty ||
              Provider.of<UserProvider>(context, listen: false)
                  .user
                  .phone
                  .isEmpty) {
            toastMsg(msg: "Please update your profile.");
          } else {
            navigateToAddLiftScreen();
          }
        },
        tooltip: "Give Lift",
        backgroundColor: const Color.fromARGB(255, 98, 202, 216),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
