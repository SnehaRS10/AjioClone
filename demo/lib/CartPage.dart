import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartPage extends StatelessWidget {
  final CollectionReference cartCollection =
  FirebaseFirestore.instance.collection('cart');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: FutureBuilder(
        future: _getUserCartData(),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data![index];
                  return ListTile(
                    title: Text(data['productName']),
                    subtitle: Text('Price: \$${data['productPrice']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeFromCart(data.id);
                      },
                    ),
                    leading: Image.network(data['productImage']),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> _getUserCartData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final cartSnapshot =
      await cartCollection.where('userEmail', isEqualTo: user.email).get();
      return cartSnapshot.docs;
    }
    return [];
  }

  Future<void> _removeFromCart(String productId) async {
    await cartCollection.doc(productId).delete();
  }
}
