import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_ecommerce_app/constants.dart';
import 'package:my_first_ecommerce_app/models/Product.dart';

class Store {
  // todo.. fire Store
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    firestore.collection(kProductCollection).add({
      kProductName: product.productName,
      kProductPrice: product.productPrice,
      kProductCategory: product.productCategory,
      kProductDescription: product.productDescription,
      kProductLocation: product.productLocation,
    });
  }

  // Future<List<Product>> loadProduct() async {
  //   List<Product> products = [];
  //   var snapshot = await firestore.collection(kProductCollection).get();
  //   for (var doc in snapshot.docs) {
  //     var data = doc.data();
  //     products.add(Product(
  //         productName: data[kProductName],
  //         productPrice: data[kProductPrice],
  //         productDescription: data[kProductDescription],
  //         productCategory: data[kProductCategory],
  //         productLocation: data[kProductLocation]));
  //   }
  //   return products;
  // }

  Stream<QuerySnapshot> loadProduct() {
    return firestore.collection(kProductCollection).snapshots();
  }

  deleteProduct(documentId) {
    firestore.collection(kProductCollection).doc(documentId).delete();
  }

  void editProduct(data, documentId) {
    firestore.collection(kProductCollection).doc(documentId).update(data);
  }
}
