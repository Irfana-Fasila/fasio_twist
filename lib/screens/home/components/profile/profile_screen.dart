import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data - in a real app, this would come from your user authentication/database
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver app bar with profile header
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Profile picture
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(userData['profileImage']),
                        ),
                        const SizedBox(height: 12),
                        // User name
                        Text(
                          userData['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // User email
                        Text(
                          userData['email'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.all(0),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to edit profile
                },
                tooltip: 'Edit Profile',
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Navigate to settings
                },
                tooltip: 'Settings',
              ),
            ],
          ),

          // Stats cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _buildStatCard(
                    context,
                    Icons.shopping_bag,
                    userData['orderCount'].toString(),
                    'Orders',
                    Colors.blue.shade50,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    context,
                    Icons.favorite,
                    userData['wishlistCount'].toString(),
                    'Wishlist',
                    Colors.red.shade50,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    context,
                    Icons.diamond,
                    userData['loyaltyPoints'].toString(),
                    'Points',
                    Colors.amber.shade50,
                  ),
                ],
              ),
            ),
          ),

          // Section divider
          SliverToBoxAdapter(
            child: _buildSectionTitle(context, 'Account Information'),
          ),

          // Account info cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  _buildInfoCard(
                    context,
                    Icons.phone_android,
                    'Phone',
                    userData['phone'],
                    () {},
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    context,
                    Icons.calendar_today,
                    'Member Since',
                    userData['memberSince'],
                    () {},
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    context,
                    Icons.location_on,
                    'Delivery Address',
                    userData['address'],
                    () {},
                  ),
                ],
              ),
            ),
          ),

          // Payment methods
          SliverToBoxAdapter(
            child: _buildSectionTitle(context, 'Payment Methods'),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: userData['paymentMethods'].map<Widget>((method) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildPaymentMethodCard(
                      context,
                      method['type'],
                      method['number'],
                      method['isDefault'],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Recent orders
          SliverToBoxAdapter(
            child: _buildSectionTitle(context, 'Recent Orders'),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: _buildOrderCard(context, recentOrders[index]),
                );
              },
              childCount: recentOrders.length,
            ),
          ),

          // Action buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildActionButton(
                    context,
                    'View All Orders',
                    Icons.receipt_long,
                    () {},
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
                    () {},
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

  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color backgroundColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildPaymentMethodCard(
    BuildContext context,
    String type,
    String number,
    bool isDefault,
  ) {
    IconData icon;
    if (type == 'Credit Card') {
      icon = Icons.credit_card;
    } else if (type == 'UPI') {
      icon = Icons.account_balance;
    } else {
      icon = Icons.payment;
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Row(
          children: [
            Text(type),
            if (isDefault)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'DEFAULT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(number),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined, size: 20),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    Map<String, dynamic> order,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Order ID and date row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order['id']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  order['date'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Order details row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order['items']} items',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  order['amount'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Status and action row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: order['statusColor'],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      order['status'],
                      style: TextStyle(
                        color: order['statusColor'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
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
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: isOutlined
              ? textColor ?? Theme.of(context).primaryColor
              : Colors.white,
          backgroundColor:
              isOutlined ? Colors.transparent : Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isOutlined
                ? BorderSide(
                    color: borderColor ?? Theme.of(context).primaryColor,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
