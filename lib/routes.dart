import 'package:flutter/material.dart';
import 'package:sharlift/common/bottom_bar.dart';
import 'package:sharlift/features/add%20lift/screens/add_lift_screen.dart';
import 'package:sharlift/features/auth/screens/auth_screen.dart';
import 'package:sharlift/features/cart%20tab/screens/cart_page.dart';
import 'package:sharlift/features/cart%20tab/screens/view_all_details.dart';
import 'package:sharlift/features/drawer/about_us.dart';
import 'package:sharlift/features/home/screens/home_screen.dart';
import 'package:sharlift/features/search/lift%20details/screens/lift_details_screen.dart';
import 'package:sharlift/features/profile/screens/profile_update_screen.dart';
import 'package:sharlift/features/request%20page%20tab/screens/other_details.dart';
import 'package:sharlift/features/request%20page%20tab/screens/request_page.dart';
import 'package:sharlift/features/search/screens/search_screen.dart';
import 'package:sharlift/models/product_model.dart';
import 'package:sharlift/models/request_model.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case HomeScreen.routeName:
      {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const HomeScreen();
            });
      }
    case AboutUs.routeName:
      {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const AboutUs();
            });
      }
    case ProfileUpdate.routeName:
      {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const ProfileUpdate();
            });
      }
    case AddLiftScreen.routeName:
      {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const AddLiftScreen();
            });
      }
    case SearchScreen.routeName:
      {
        final args = routeSettings.arguments as Map;

        // Destructure the arguments
        String from = args['from'];
        String to = args['to'];
        // var to = routeSettings.arguements as String;
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return SearchScreen(
                from: from,
                to: to,
              );
            });
      }
    case LiftDetailsScreen.routeName:
      {
        var product = routeSettings.arguments as ProductModel;
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return LiftDetailsScreen(
                product: product,
              );
            });
      }
    case RequestPage.routeName:
      {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const RequestPage();
            });
      }
    case OtherDetailsScreen.routeName:
      {
        var curRequest = routeSettings.arguments as RequestModel;
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return OtherDetailsScreen(
                curRequest: curRequest,
              );
            });
      }
    case CartPage.routeName:
      {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const CartPage();
            });
      }

    case ViewAllDetails.routeName:
      {
        var curProduct = routeSettings.arguments as ProductModel;
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) {
              return ViewAllDetails(
                curProduct: curProduct,
              );
            });
      }

    default:
      {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text("Error occured."),
                  ],
                ),
              ),
            );
          },
        );
      }
  }
}
