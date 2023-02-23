import 'package:flutter/material.dart';
import 'package:my_first_ecommerce_app/models/Product.dart';
import 'package:my_first_ecommerce_app/my_custom_widgets/custom_text_field.dart';
import 'package:my_first_ecommerce_app/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = "addProductScreen";
  String _prodName, _prodPrice, _prodDescription, _prodCategory, _prodLocation;
  GlobalKey<FormState> _formKey = GlobalKey();
  Product product = Product();
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:[
          SizedBox(height: 20,),
          Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                hint: "Product Name",
                onClick: (value) {
                  _prodName = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Product Price",
                onClick: (value) {
                  _prodPrice = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Product Description",
                onClick: (value) {
                  _prodDescription = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Product Category",
                onClick: (value) {
                  _prodCategory = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Product Location",
                onClick: (value) {
                  _prodLocation = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _store.addProduct(Product(
                        productName: _prodName,
                        productPrice: _prodPrice,
                        productDescription: _prodDescription,
                        productCategory: _prodCategory,
                        productLocation: _prodLocation,
                      ));
                    }
                  },
                  child: Text("Add Product")),
            ],
          ),
        ),],
      ),
    );
  }
}
