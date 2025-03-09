import 'package:fasio_twist/route/route.dart';
import 'package:fasio_twist/route/route_list.dart';
import 'package:fasio_twist/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sample user data - in a real app, this would come from your providers
    final Map<String, dynamic> userData = {
      'name': 'Sophia Chen',
      'email': 'sophia.chen@example.com',
      'phone': '+91 9876543210',
      'memberSince': 'March 2023',
      'profileImage': 'assets/images/profile_avatar.jpg',
      'loyaltyPoints': 2450,
      'orderCount': 17,
      'wishlistCount': 32,
      'address': '42 Fashion Street, Silk Garden, Mumbai - 400001',
      'paymentMethods': [
        {
          'type': 'Credit Card',
          'number': '**** **** **** 5678',
          'isDefault': true,
        },
        {
          'type': 'UPI',
          'number': 'example@upi',
          'isDefault': false,
        }
      ],
    };

    // Order statuses for the Order History section
    final List<Map<String, dynamic>> recentOrders = [
      {
        'id': 'FT-6723',
        'date': 'Feb 24, 2025',
        'amount': '₹2,499',
        'status': 'Delivered',
        'statusColor': Colors.green,
        'items': 3,
      },
      {
        'id': 'FT-6589',
        'date': 'Feb 10, 2025',
        'amount': '₹1,799',
        'status': 'Processing',
        'statusColor': Colors.orange,
        'items': 2,
      },
      {
        'id': 'FT-6437',
        'date': 'Jan 27, 2025',
        'amount': '₹3,299',
        'status': 'Delivered',
        'statusColor': Colors.green,
        'items': 4,
      },
    ];

    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final accentColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Beautiful gradient app bar with profile image
          SliverAppBar(
            expandedHeight: 260.0,
            pinned: true,
            backgroundColor: primaryColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor,
                      accentColor,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile image with border
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(userData['profileImage']),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // User details with animations
                      Text(
                        ref.watch(authVM).name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ref.watch(authVM).email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Age: ${ref.watch(authVM).age}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.all(0),
            ),
          ),

          // Stats section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(context, 'Orders', userData['orderCount'].toString()),
                      _verticalDivider(),
                      _buildStatItem(context, 'Wishlist', userData['wishlistCount'].toString()),
                      _verticalDivider(),
                      _buildStatItem(context, 'Points', userData['loyaltyPoints'].toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Recent orders section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: _buildSectionHeader(context, 'Recent Orders'),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final order = recentOrders[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: order['statusColor'].withOpacity(0.1),
                        child: Text(
                          order['items'].toString(),
                          style: TextStyle(
                            color: order['statusColor'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            order['id'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: order['statusColor'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              order['status'],
                              style: TextStyle(
                                fontSize: 12,
                                color: order['statusColor'],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "${order['date']} • ${order['amount']}",
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  ),
                );
              },
              childCount: recentOrders.length,
            ),
          ),

          // Action buttons section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(context, 'Account'),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    context,
                    'View All Orders',
                    Icons.receipt_long,
                    () {},
                    gradient: LinearGradient(
                      colors: [primaryColor, accentColor],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    context,
                    'Customer Support',
                    Icons.headset_mic,
                    () {},
                    isOutlined: true,
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    context,
                    'Sign Out',
                    Icons.logout,
                    () async {
                      await ref.read(authVM).logout().then(
                            (value) => routeX.pushReplacementNamed(MainRoutes.login),
                          );
                    },
                    isOutlined: true,
                    textColor: Colors.red,
                    borderColor: Colors.red,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap, {
    bool isOutlined = false,
    Color? textColor,
    Color? borderColor,
    LinearGradient? gradient,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: !isOutlined ? gradient : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: !isOutlined
            ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          if (label == 'Sign Out') {
            // Show confirmation dialog for logout
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    'Are you sure you want to sign out of your account?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        onTap(); // Execute the logout function
                      },
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            onTap();
          }
        },
        icon: Icon(icon),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: isOutlined ? textColor ?? Theme.of(context).primaryColor : Colors.white,
          backgroundColor: isOutlined ? Colors.transparent : null,
          elevation: isOutlined ? 0 : null,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isOutlined
                ? BorderSide(
                    color: borderColor ?? Theme.of(context).primaryColor,
                    width: 2,
                  )
                : BorderSide.none,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }
}
