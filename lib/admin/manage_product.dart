import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_ecommerce_app/admin/edit_products.dart';
import 'package:my_first_ecommerce_app/constants.dart';
import 'package:my_first_ecommerce_app/models/Product.dart';
import 'package:my_first_ecommerce_app/services/store.dart';

class ManageProducts extends StatefulWidget {
  static String id = "manageProducts";

  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            List<Product> products = [];
            if (snapshot.hasData) {
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                products.add(Product(
                  productId: doc.id,
                    productName: data[kProductName],
                    productPrice: data[kProductPrice],
                    productDescription: data[kProductDescription],
                    productCategory: data[kProductCategory],
                    productLocation: data[kProductLocation]));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .9, crossAxisCount: 2),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width;
                      double dy2 = MediaQuery.of(context).size.height;
                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          items: [
                            MyPopupMenuItem(
                              child: Text("Edit"),
                              onClick: () {
                                Navigator.pushNamed(context, EditProducts.id,arguments: products[index]);
                              },
                            ),
                            MyPopupMenuItem(
                              child: Text("Delete"),
                              onClick: () {
                                _store.deleteProduct(products[index].productId);
                                Navigator.pop(context);
                              },
                            )
                          ]);
                    },
                    child: Stack(
                      children: [
                        products[index].productLocation != null
                            ? Positioned.fill(
                                child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        products[index].productLocation)))
                            : Container(),
                        Positioned(
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(products[index].productName),
                                  Text(
                                    products[index].productPrice,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(products[index].productDescription),
                                  Text(products[index].productCategory),
                                ],
                              ),
                            ),
                          ),
                          bottom: 0,
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: products.length,
              );
            } else {
              return Center(
                child: Text("Loading...."),
              );
            }
          }),
    );
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;

  MyPopupMenuItem({@required this.child, @required this.onClick})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    // TODO: implement createState
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    // TODO: implement handleTap
    widget.onClick();

  }
}

/*
Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Expanded(
                      child: Row(
                        children: [
                          products[index].productName != null
                              ? (Column(
                                  children: [
                                    Text(products[index].productName),
                                  ],
                                ))
                              : Container(),
                          products[index].productPrice != null
                              ? Column(
                                  children: [
                                    Text(products[index].productPrice),
                                  ],
                                )
                              : Container(),
                          products[index].productDescription != null
                              ?Column(
                            children: [
                              Text(products[index].productDescription),
                            ],
                          ):Container(),
                          products[index].productCategory != null
                              ?Column(
                            children: [
                              Text(products[index].productCategory),
                            ],
                          ):Container(),
                          // Column(
                          //   children: [
                          //     Text(snapshot.data[index].productLocation),
                          //   ],
                          // ),
                        ],
                      ),
                    )),
                  );
 */
