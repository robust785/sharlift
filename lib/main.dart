import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharlift/common/bottom_bar.dart';
import 'package:sharlift/common/loading_screen.dart';

import 'package:sharlift/features/admin/screens/admin_screen.dart';
import 'package:sharlift/features/auth/screens/auth_screen.dart';
import 'package:sharlift/features/auth/services/auth_services.dart';
import 'package:sharlift/provider/user_provider.dart';
import 'package:sharlift/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authService = AuthServices();
  // ignore: unused_field
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    await authService.getUserData(context);
    setState(() {
      _isLoading = false; // Set loading to false once data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        return generateRoute(settings);
      },
      debugShowCheckedModeBanner: false,
      title: "SharLift",
      theme: ThemeData(
        colorSchemeSeed: Colors.white,
        useMaterial3: true,
        fontFamily: 'CaviarDreams',
      ),
      home: FutureBuilder(
        future: authService.getUserData(context), // Get user data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen(); // Loading indicator
          } else {
            return Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? Provider.of<UserProvider>(context).user.type == "user"
                    ? const BottomBar()
                    : const AdminScreen()
                : const AuthScreen();
          }
        },
      ),
    );
  }
}
