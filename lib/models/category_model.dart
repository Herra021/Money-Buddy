import 'package:flutter/material.dart';

class CategoryModel {
  final int? id;
  final String name;
  final String icon;
  final String colorHex;
  final String type; // 'expense' | 'income'

  const CategoryModel({
    this.id,
    required this.name,
    required this.icon,
    required this.colorHex,
    required this.type,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      icon: map['icon'] as String,
      colorHex: map['color_hex'] as String,
      type: map['type'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'icon': icon,
        'color_hex': colorHex,
        'type': type,
      };

  Color get color {
    final hex = colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  IconData get iconData {
    return _iconMap[icon] ?? Icons.category;
  }

  static const _iconMap = <String, IconData>{
    'restaurant': Icons.restaurant,
    'shopping_bag': Icons.shopping_bag,
    'directions_car': Icons.directions_car,
    'movie': Icons.movie,
    'medical_services': Icons.medical_services,
    'receipt_long': Icons.receipt_long,
    'school': Icons.school,
    'flight': Icons.flight,
    'local_grocery_store': Icons.local_grocery_store,
    'more_horiz': Icons.more_horiz,
    'payments': Icons.payments,
    'laptop': Icons.laptop,
    'trending_up': Icons.trending_up,
    'card_giftcard': Icons.card_giftcard,
    'local_cafe': Icons.local_cafe,
    'fitness_center': Icons.fitness_center,
    'home': Icons.home,
    'bolt': Icons.bolt,
  };
}
