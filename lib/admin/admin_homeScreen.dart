import 'package:flutter/material.dart';
import 'package:my_first_ecommerce_app/admin/add_product.dart';
import 'package:my_first_ecommerce_app/admin/manage_product.dart';
import 'package:my_first_ecommerce_app/constants.dart';

class AdminHomeScreen extends StatelessWidget {
  static String id = "AdminHomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppAdminColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AddProduct.id),
              child: Text("Add Product")),
          ElevatedButton(onPressed: () => Navigator.pushNamed(context, ManageProducts.id), child: Text("Edit Product")),
          ElevatedButton(onPressed: () => null, child: Text("View Orders")),
        ],
      ),
    );
  }
}
