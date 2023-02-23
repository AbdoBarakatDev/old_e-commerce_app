import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_ecommerce_app/admin/add_product.dart';
import 'package:my_first_ecommerce_app/admin/edit_products.dart';
import 'package:my_first_ecommerce_app/admin/manage_product.dart';
import 'package:my_first_ecommerce_app/admin/view_orders.dart';
import 'package:my_first_ecommerce_app/providers/CheckUserType.dart';
import 'package:my_first_ecommerce_app/providers/loginloading.dart';
import 'package:my_first_ecommerce_app/providers/password_icon_visibility_provider.dart';
import 'file:///J:/FlutterFullProjects/my_first_ecommerce_app/lib/admin/admin_homeScreen.dart';
import 'package:my_first_ecommerce_app/screens/home_screen.dart';
import 'package:my_first_ecommerce_app/screens/login_screen.dart';
import 'package:my_first_ecommerce_app/screens/signup_sreen.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IconVisibilityProvider>(
            create: (_) => IconVisibilityProvider()),
        ChangeNotifierProvider<MyModelHud>(create: (_) => MyModelHud()),
        ChangeNotifierProvider<CheckIsAdmin>(create: (_) => CheckIsAdmin()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          AdminHomeScreen.id: (context) => AdminHomeScreen(),
          AddProduct.id: (context) => AddProduct(),
          ManageProducts.id: (context) => ManageProducts(),
          ViewOrders.id: (context) => ViewOrders(),
          EditProducts.id: (context) => EditProducts(),

        },
      ),
    );
  }
}
