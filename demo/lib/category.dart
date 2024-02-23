import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'account_page.dart';
import 'main.dart';
import 'explore.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Shop by Category',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
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
        ],// Omitted other app bar actions
      ),
      body: FutureBuilder(
        future: loadImagesFromFirebase(), // Fetch image URLs from Firebase Storage
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading images'));
          }
          List<String> imageUrls = snapshot.data as List<String>;
          return Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(imageUrls.length, (index) {
                    return CategoryItem(imageUrl: imageUrls[index], name: 'Category ${index + 1}');
                  }),
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Center(
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/flat.jpg', // Replace with the path to your image asset
                        width: double.infinity, // Set width to match container width
                        fit: BoxFit.cover, // Make the image cover the entire container width
                      ),
                    ),
                  ),
                ),
              ),


            ],
          );
        },
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
      // Omitted bottom navigation bar
    );
  }

  Future<List<String>> loadImagesFromFirebase() async {
    // Fetch image URLs from Firebase Storage
    List<String> imageUrls = [];
    try {
      // Example: Fetching all files from a specific folder in Firebase Storage
      final ref = FirebaseStorage.instance.ref().child('category_images');
      final result = await ref.listAll();
      for (var item in result.items) {
        final url = await item.getDownloadURL();
        imageUrls.add(url);
      }
    } catch (e) {
      print('Error loading images from Firebase Storage: $e');
    }
    return imageUrls;
  }
}

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String name;

  CategoryItem({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            imageUrl,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
