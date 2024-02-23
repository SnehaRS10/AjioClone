import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuyPage extends StatelessWidget {
  final CollectionReference buyCollection =
  FirebaseFirestore.instance.collection('buy');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy History'),
      ),
      body: FutureBuilder(
        future: _getUserBuyData(),
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
                    trailing: Text('Rating: ${data['productRating']}'),
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

  Future<List<DocumentSnapshot>> _getUserBuyData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final buySnapshot =
      await buyCollection.where('userEmail', isEqualTo: user.email).get();
      return buySnapshot.docs;
    }
    return [];
  }
}
