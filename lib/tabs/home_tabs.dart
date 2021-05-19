import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mystore/constants.dart';
import 'package:mystore/screens/product_page.dart';
import 'package:mystore/widgets/custom_action_bar.dart';
import 'package:mystore/widgets/product_card.dart';

class HomeTabs extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  backgroundColor: Colors.blueAccent,
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // ketika data siap akan muncul ke display
              if (snapshot.connectionState == ConnectionState.done) {
                // data akan muncul ke layar list view
                return ListView(
                  padding: EdgeInsets.only(
                      top: 108.0,
                      bottom: 12.0),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document.data()['nama'],
                      imageUrl: document.data()['images'][0],
                      price: "${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
