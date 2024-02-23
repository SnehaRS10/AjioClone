import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'category.dart';
import 'account_page.dart';
import 'main.dart';
import 'ProductDetailScreen.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/ajio.png', // Replace with your image asset
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            SizedBox(width: 16),
            Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            SizedBox(width: 16),
            Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFCDB1), Color(0xFFE99A6B)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Hurry up! Sale is live!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 10, // Change this to your actual number of products
              itemBuilder: (BuildContext context, int index) {
                return _buildProductItem(context, index);
              },
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

  Widget _buildProductItem(BuildContext context, int index) {
    String productName = "Product $index";
    String productImage = "explore/product_$index.jpg";
    double productPrice = 20.0;
    double productRating = 4.5;

    return GestureDetector(
      onTap: () {
        _getImageUrl(productImage).then((imageUrl) {
          if (imageUrl != null && imageUrl.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  productName: productName,
                  productImage: imageUrl,
                  productPrice: productPrice,
                  productRating: productRating,
                ),
              ),
            );
          } else {
            print('Error: Image URL is null or empty');
          }
        });
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: _getImageUrl(productImage),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Text('Error: Image URL is empty');
                }
                return AspectRatio(
                  aspectRatio: 1.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$$productPrice',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 4),
                      Text(
                        '$productRating',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getImageUrl(String imagePath) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref(imagePath);
    return await ref.getDownloadURL();
  }
}
