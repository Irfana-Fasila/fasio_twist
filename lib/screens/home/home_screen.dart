import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fasio_twist/screens/home/components/categories/category_section.dart';
import 'package:fasio_twist/screens/home/components/offers/offer_screen.dart';
import 'package:fasio_twist/screens/home/components/profile/profile_screen.dart';

import '../../models/product.dart';
import '../details/details_screen.dart';
import 'components/categories/categories.dart';
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
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Replaced kDefaultPaddin
            child: Text(
              "Fasio Twist",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
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
    return const CategoriesPage();
  }

  Widget _buildOffersScreen() {
    return const OffersPage();
  }

  Widget _buildAccountScreen() {
    return const ProfileScreen();
  }
}
