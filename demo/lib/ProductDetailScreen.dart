import 'package:flutter/material.dart';
import 'category.dart';
import 'account_page.dart';
import 'main.dart';
import 'explore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginPage.dart';


User? getCurrentUser() {
  return FirebaseAuth.instance.currentUser;
}

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final double productRating;

  ProductDetailScreen({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productRating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            productImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '\$$productPrice',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '$productRating',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        handleBuyButton(context);
                      },
                      child: Text('Buy'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        handleAddToCartButton(context);
                      },
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Switch Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'TRENDin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          // Handle bottom navigation item clicks
          switch (index) {
            case 0:
            // Handle 'Switch Stores' action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
              break;
            case 1:
            // Handle 'Explore' action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Explore()),
              );
              break;
            case 2:
            // Handle 'TRENDin' action
              break;
            case 3:
            // Navigate to the category section page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategorySection()),
              );
              break;
            case 4:
            // Handle 'Account' action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
              break;
            default:
          }
        },
      ),
    );
  }

  void handleBuyButton(BuildContext context) {
    final user = getCurrentUser();
    if (user != null) {
      // User is logged in, store product details in Firestore
      storeProductDetails('buy');
    } else {
      // User is not logged in, navigate to login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  void handleAddToCartButton(BuildContext context) {
    final user = getCurrentUser();
    if (user != null) {
      // User is logged in, store product details in Firestore
      storeProductDetails('cart');
    } else {
      // User is not logged in, navigate to login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  void storeProductDetails(String collection) {
    final user = getCurrentUser();
    if (user != null) {
      // Add product details along with user email to Firestore
      FirebaseFirestore.instance.collection(collection).add({
        'productName': productName,
        'productImage': productImage,
        'productPrice': productPrice,
        'productRating': productRating,
        'userEmail': user.email,
      }).then((value) {
        // Successfully stored product details
        print('Product details stored successfully');
      }).catchError((error) {
        // Failed to store product details
        print('Failed to store product details: $error');
      });
    }
  }
}
