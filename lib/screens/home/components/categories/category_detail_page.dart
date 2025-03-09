import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDetailPage extends ConsumerWidget {
  final String category;
  final List imagePaths;
  final Color backgroundColor;

  const CategoryDetailPage({
    super.key,
    required this.category,
    required this.imagePaths,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            elevation: 4,
            backgroundColor: backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                '$category Collection',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  imagePaths.isNotEmpty
                      ? Image.asset(
                          imagePaths[0],
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.1),
                          colorBlendMode: BlendMode.darken,
                        )
                      : Container(color: backgroundColor),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip("All Items", true),
                  const SizedBox(width: 8),
                  _buildFilterChip("New Arrivals", false),
                  const SizedBox(width: 8),
                  _buildFilterChip("Bestsellers", false),
                  const SizedBox(width: 8),
                  _buildFilterChip("Price: Low to High", false),
                  const SizedBox(width: 8),
                  _buildFilterChip("Price: High to Low", false),
                ],
              ),
            ),
          ),
          // Wrap layout version
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                children: List.generate(
                  imagePaths.length,
                  (index) => SizedBox(
                    width: (MediaQuery.of(context).size.width - 48) / 2,
                    child: _buildEnhancedProductCard(
                      context,
                      '$category ${index + 1}',
                      '₹${999 - index * 50}',
                      imagePaths[index % imagePaths.length],
                      index % 3 == 0,
                    ),
                  ),
                ),
              ),
            ),
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
