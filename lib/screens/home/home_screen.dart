import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/product.dart';
import '../details/details_screen.dart';
import 'components/categories.dart';
import 'components/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = ["Home", "Categories", "Offers", "Account"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 16), // Replaced kDefaultPaddin / 2
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Replaced kDefaultPaddin
            child: Text(
              "Fasio Twist",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Categories(
            selectedIndex: selectedIndex,
            onCategorySelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(child: _buildSelectedScreen()),
        ],
      ),
    );
  }

  /// Returns the widget for the selected category
  Widget _buildSelectedScreen() {
    switch (selectedIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildCategoryScreen();
      case 2:
        return _buildOffersScreen();
      case 3:
        return _buildAccountScreen();
      default:
        return _buildHomeScreen();
    }
  }

  /// Home Screen (Product Grid)
  Widget _buildHomeScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) => ItemCard(
          product: products[index],
          press: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(product: products[index]),
            ),
          ),
        ),
      ),
    );
  }

  /// Placeholder screens for other categories
  Widget _buildCategoryScreen() {
    return const Center(child: Text("Categories Screen", style: TextStyle(fontSize: 20)));
  }

  Widget _buildOffersScreen() {
    return const Center(child: Text("Offers Screen", style: TextStyle(fontSize: 20)));
  }

  Widget _buildAccountScreen() {
    return const Center(child: Text("Account Screen", style: TextStyle(fontSize: 20)));
  }
}
