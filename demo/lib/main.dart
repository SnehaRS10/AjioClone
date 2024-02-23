import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'account_page.dart';
import 'category.dart';
import 'explore.dart';
import 'menSection.dart'; // Import your desired section file
import 'kidsSection.dart';
import 'accessories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ajio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryItem(
                  image: 'assets/men_categories.jpg',
                  name: 'Men',
                  onTap: () {
                    // Add your onTap functionality for the Men category here
                    print('Men category tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenSection()),
                    );
                  },
                ),
                CategoryItem(
                  image: 'assets/women_categories.png',
                  name: 'Women',
                  onTap: () {
                    print('Women category tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Explore()),
                    );
                  },
                ),
                CategoryItem(
                  image: 'assets/kids_categories.png',
                  name: 'Kids',
                  onTap: () {
                    // Add your onTap functionality for the Kids category here
                    print('Kids category tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KidsSection()),
                    );
                  },
                ),
                CategoryItem(
                  image: 'assets/bags.png',
                  name: 'Accessories',
                  onTap: () {
                    // Add your onTap functionality for the Accessories category here
                    print('Accessories category tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Accessories()),
                    );
                  },
                ),
                CategoryItem(
                  image: 'assets/foots.png',
                  name: 'Footwear',
                  onTap: () {
                    // Add your onTap functionality for the Footwear category here
                    print('Footwear category tapped');
                    // Add navigation or other actions here
                  },
                ),
              ],
            ),
          ),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/sale_image.jpg', // Replace with your sale image asset
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.5, // Adjust the height as needed
              width: double.infinity,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: MediaQuery.of(context).size.height * 0.1, // Set to the same height as the "Hurry up!" container
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                PaymentBox(
                  logo: 'assets/paytm.png', // Replace with Paytm logo asset
                  message: 'Pay with Paytm\nfor exciting discounts!',
                ),
                PaymentBox(
                  logo: 'assets/sbi.png', // Replace with UPI logo asset
                  message: 'Get discounts on\nUPI payments!',
                ),
                // Add more payment options as needed
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
}

class CategoryItem extends StatelessWidget {
  final String image;
  final String name;
  final VoidCallback onTap;

  CategoryItem({required this.image, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentBox extends StatelessWidget {
  final String logo;
  final String message;

  PaymentBox({required this.logo, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              logo,
              width: 50,
              height: 50,
            ),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue, // Change to your desired gradient color
              decoration: TextDecoration.none, // Remove underline
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto', // Change to your desired font
              letterSpacing: 0.5, // Adjust spacing as needed
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
