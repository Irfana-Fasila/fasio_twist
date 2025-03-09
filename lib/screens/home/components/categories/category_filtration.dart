import 'package:fasio_twist/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = Provider<Map<String, Map<String, dynamic>>>((ref) {
  final int age = ref.watch(authVM).age ?? 0;

  if (age >= 13 && age <= 25) {
    return Map.fromEntries(allCategories.entries.where((entry) => ['Trendy', 'Pakistani', 'Formal', 'Western', 'Modest'].contains(entry.key)));
  } else if (age > 25 && age <= 35) {
    return Map.fromEntries(allCategories.entries.where((entry) => ['Pakistani', 'Casual', 'Gown', 'Modest'].contains(entry.key)));
  } else if (age > 35 && age <= 50) {
    return Map.fromEntries(allCategories.entries.where((entry) => ['Traditional', 'Casual', 'Modest'].contains(entry.key)));
  } else if (age > 50) {
    return Map.fromEntries(allCategories.entries.where((entry) => ['Traditional'].contains(entry.key)));
  }
  return allCategories;
});

final allCategories = {
  'Casual': {
    'images': ['assets/images/casual1.jpeg', 'assets/images/casual2.jpeg', 'assets/images/casual3.jpeg', 'assets/images/casual4.jpeg', 'assets/images/casual5.jpeg'],
    'color': const Color(0xFFE3F2FD),
    'icon': Icons.weekend,
    'description': 'Comfortable everyday wear',
    'itemCount': 43,
  },
  'Trendy': {
    'images': ['assets/images/trendy1.jpeg', 'assets/images/trendy2.jpeg', 'assets/images/trendy3.jpeg'],
    'color': const Color(0xFFF3E5F5),
    'icon': Icons.trending_up,
    'description': 'Latest fashion trends',
    'itemCount': 28,
  },
  'Traditional': {
    'images': ['assets/images/tred1.jpeg', 'assets/images/tred2.jpeg', 'assets/images/tred3.jpeg', 'assets/images/tred4.jpeg', 'assets/images/tred5.jpeg', 'assets/images/tred6.jpeg'],
    'color': const Color(0xFFFFF3E0),
    'icon': Icons.auto_awesome,
    'description': 'Heritage collection',
    'itemCount': 37,
  },
  'Pakistani': {
    'images': ['assets/images/pak1.jpeg', 'assets/images/pak2.jpeg', 'assets/images/pak3.jpeg', 'assets/images/pak4.jpg'],
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
    'images': ['assets/images/west1.jpeg', 'assets/images/west2.jpeg', 'assets/images/west3.jpeg', 'assets/images/west4.jpeg', 'assets/images/west5.jpg'],
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
