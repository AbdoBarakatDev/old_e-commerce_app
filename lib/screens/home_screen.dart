import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_ecommerce_app/constants.dart';
import 'package:my_first_ecommerce_app/models/Product.dart';
import 'package:my_first_ecommerce_app/services/store.dart';

class HomeScreen extends StatefulWidget {
  static final id = "homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabBarIndex = 0;
  int bottomNavIndex = 0;
  var _store = Store();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          initialIndex: tabBarIndex,
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              // fixedColor:mainAppColor ,
              selectedItemColor: mainAppColor,
              unselectedItemColor: secondAppColor,
              selectedIconTheme: IconThemeData(color: Colors.blue),
              onTap: (value) {
                setState(() {
                  bottomNavIndex = value;
                });
              },
              currentIndex: bottomNavIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Person",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Person",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Person",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Person",
                ),
              ],
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: mainAppColor,
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                onTap: (value) {
                  setState(() {
                    tabBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    "Jackets",
                    style: TextStyle(
                      fontSize: tabBarIndex == 0 ? 16 : null,
                      color: tabBarIndex == 0 ? kactiveColor : kinActiveColor,
                    ),
                  ),
                  Text(
                    "Pantalons",
                    style: TextStyle(
                      fontSize: tabBarIndex == 1 ? 16 : null,
                      color: tabBarIndex == 1 ? kactiveColor : kinActiveColor,
                    ),
                  ),
                  Text(
                    "Trousers",
                    style: TextStyle(
                      fontSize: tabBarIndex == 2 ? 16 : null,
                      color: tabBarIndex == 2 ? kactiveColor : kinActiveColor,
                    ),
                  ),
                  Text(
                    "T-shirts",
                    style: TextStyle(
                      fontSize: tabBarIndex == 3 ? 16 : null,
                      color: tabBarIndex == 3 ? kactiveColor : kinActiveColor,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                drawJackets(),
                Text("Test2"),
                Text("Test3"),
                Text("Test4"),
              ],
            ),
          ),
        ),
        Material(
          color: mainAppColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget drawJackets() {
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
