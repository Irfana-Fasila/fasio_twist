import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final Map<String, Map<String, dynamic>> categories = {
    'Casual': {
      'images': [
        'assets/images/casual1.jpeg',
        'assets/images/casual2.jpeg',
        'assets/images/casual3.jpeg',
        'assets/images/casual4.jpeg',
        'assets/images/casual5.jpeg'
      ],
      'color': const Color(0xFFE3F2FD),
      'icon': Icons.weekend,
      'description': 'Comfortable everyday wear',
      'itemCount': 43,
    },
    'Trendy': {
      'images': [
        'assets/images/trendy1.jpeg',
        'assets/images/trendy2.jpeg',
        'assets/images/trendy3.jpeg'
      ],
      'color': const Color(0xFFF3E5F5),
      'icon': Icons.trending_up,
      'description': 'Latest fashion trends',
      'itemCount': 28,
    },
    'Traditional': {
      'images': [
        'assets/images/tred1.jpeg',
        'assets/images/tred2.jpeg',
        'assets/images/tred3.jpeg',
        'assets/images/tred4.jpeg',
        'assets/images/tred5.jpeg',
        'assets/images/tred6.jpeg'
      ],
      'color': const Color(0xFFFFF3E0),
      'icon': Icons.auto_awesome,
      'description': 'Heritage collection',
      'itemCount': 37,
    },
    'Pakistani': {
      'images': [
        'assets/images/pak1.jpeg',
        'assets/images/pak2.jpeg',
        'assets/images/pak3.jpeg',
        'assets/images/pak4.jpg'
      ],
      'color': const Color(0xFFE8F5E9),
      'icon': Icons.stars,
      'description': 'Elegant Pakistani designs',
      'itemCount': 22,
    },
    'Modest': {
      'images': ['assets/images/mod1.jpeg', 'assets/images/mod2.jpeg', 'assets/images/mod3.jpeg'],
      'color': const Color(0xFFE0F7FA),
      'icon': Icons.sentiment_satisfied_alt,
      'description': 'Graceful modest collection',
      'itemCount': 18,
    },
    'Gown': {
      'images': ['assets/images/gown3.jpeg', 'assets/images/gown2.jpeg'],
      'color': const Color(0xFFFFEBEE),
      'icon': Icons.theater_comedy,
      'description': 'Elegant evening wear',
      'itemCount': 12,
    },
    'Western': {
      'images': [
        'assets/images/west1.jpeg',
        'assets/images/west2.jpeg',
        'assets/images/west3.jpeg',
        'assets/images/west4.jpeg',
        'assets/images/west5.jpg'
      ],
      'color': const Color(0xFFE8EAF6),
      'icon': Icons.explore,
      'description': 'Contemporary western styles',
      
      'itemCount': 31,
    },
    'Formal': {
      'images': ['assets/images/form1.jpeg', 'assets/images/form2.jpeg'],
      'color': const Color(0xFFEFEBE9),
      'icon': Icons.business,
      'description': 'Professional attire',
      'itemCount': 16,
    },
  };

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Hero header
        SliverToBoxAdapter(
          child: Container(
            height: 180,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/category_banner.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                // Text content
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "NEW ARRIVALS",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Find Your Style",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Explore our extensive collection",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Category section title
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Browse Categories",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Find perfect outfits by category",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // Categories grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                String categoryName = categories.keys.elementAt(index);
                Map<String, dynamic> categoryData = categories[categoryName]!;
                return _buildCategoryCard(
                  context,
                  categoryName,
                  categoryData['images'] as List<String>,
                  categoryData['color'] as Color,
                  categoryData['icon'] as IconData,
                  categoryData['description'] as String,
                  categoryData['itemCount'] as int,
                );
              },
              childCount: categories.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String categoryName,
    List<String> imagePaths,
    Color backgroundColor,
    IconData icon,
    String description,
    int itemCount,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailPage(
              category: categoryName,
              imagePaths: imagePaths,
              backgroundColor: backgroundColor,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container with count overlay
            Stack(
              children: [
                // Main image
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: AssetImage(imagePaths.isNotEmpty
                          ? imagePaths[0]
                          : 'assets/placeholder.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Item count overlay
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "$itemCount items",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Category info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        size: 16,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        categoryName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: Theme.of(context).primaryColor,
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
}

class CategoryDetailPage extends StatelessWidget {
  final String category;
  final List<String> imagePaths;
  final Color backgroundColor;

  const CategoryDetailPage({
    super.key,
    required this.category,
    required this.imagePaths,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Custom app bar with image
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '$category Collection',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  imagePaths.isNotEmpty
                      ? Image.asset(
                          imagePaths[0],
                          fit: BoxFit.cover,
                        )
                      : Container(color: backgroundColor),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {},
              ),
            ],
          ),

          // Filter chips
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 8),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip("All Items", true),
                  _buildFilterChip("New Arrivals", false),
                  _buildFilterChip("Bestsellers", false),
                  _buildFilterChip("Price: Low to High", false),
                  _buildFilterChip("Price: High to Low", false),
                ],
              ),
            ),
          ),

          // Products grid
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildEnhancedProductCard(
                  context,
                  '$category ${index + 1}',
                  '₹${999 - index * 50}',
                  imagePaths[index % imagePaths.length],
                  index % 3 == 0, // Every third item is marked as new
                ),
                childCount: imagePaths.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool value) {},
        backgroundColor: Colors.white,
        selectedColor: Colors.pink[50],
        labelStyle: TextStyle(
          color: isSelected ? Colors.pink : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.pink : Colors.grey[300]!,
          ),
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
          // Product image with wishlist icon
          Stack(
            children: [
              // Main image - Modified to take the full width and a proportional height
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 1,  // This makes the image square
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // New tag
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
              // Wishlist button
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
          // Product info
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
                // Rating
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
                // Price row with add button
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