import 'package:fasio_twist/screens/home/components/categories/category_filtration.dart';
import 'package:fasio_twist/screens/home/components/categories/category_section.dart';
import 'package:fasio_twist/screens/home/components/offers/offer_screen.dart';
import 'package:fasio_twist/screens/home/components/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/categories/categories.dart';

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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Fasio Twist",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        leadingWidth: 120, // Added to accommodate wider title
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              height: 24, // Added for consistent icon size
            ),
            onPressed: () {},
            tooltip: 'Search', // Added for accessibility
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              height: 24, // Added for consistent icon size
            ),
            onPressed: () {},
            tooltip: 'Cart', // Added for accessibility
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
    return HomePage();
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

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final allImages = categories.values.expand((category) => category['images'] as List<String>).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Featured Collections",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Discover styles curated for you",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Products using Wrap for better responsiveness
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 16, // horizontal spacing
                runSpacing: 16, // vertical spacing
                children: List.generate(
                  allImages.length,
                  (index) {
                    final imagePath = allImages[index];
                    final categoryName = categories.entries.firstWhere((entry) => (entry.value['images'] as List<String>).contains(imagePath)).key;

                    // Calculate width based on screen size
                    final screenWidth = MediaQuery.of(context).size.width;
                    // Adjust number of items per row based on screen width
                    final itemsPerRow = screenWidth > 600 ? 3 : 2;
                    final itemWidth = (screenWidth - (32 + (16 * (itemsPerRow - 1)))) / itemsPerRow;

                    return SizedBox(
                      width: itemWidth,
                      child: _buildEnhancedProductCard(
                        context,
                        '$categoryName ${index + 1}',
                        '₹${999 - (index * 50)}',
                        imagePath,
                        index % 3 == 0,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEnhancedProductCard(
    BuildContext context,
    String productName,
    String price,
    String imagePath,
    bool isNew,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (isNew)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "NEW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 18,
                    ),
                    onPressed: () {},
                    constraints: const BoxConstraints(
                      minHeight: 32,
                      minWidth: 32,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Icon(
                        index < 4 ? Icons.star : Icons.star_border,
                        size: 14,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "4.0",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_shopping_cart,
                          size: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {},
                        constraints: const BoxConstraints(
                          minHeight: 32,
                          minWidth: 32,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
