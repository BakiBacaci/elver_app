import 'package:flutter/material.dart';

enum CategoryType { saglik, engellilik, hayvan, egitim, diger }

class CategoryItem {
  final String id;
  final String label;
  final String icon;
  final Color color;

  const CategoryItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
}

final Map<CategoryType, CategoryItem> appCategories = {
  CategoryType.saglik: const CategoryItem(
    id: 'saglik', label: 'Sağlık', icon: '❤️', color: Color(0xFFEF4444),
  ),
  CategoryType.engellilik: const CategoryItem(
    id: 'engellilik', label: 'Engellilik', icon: '♿', color: Color(0xFF8B5CF6),
  ),
  CategoryType.hayvan: const CategoryItem(
    id: 'hayvan', label: 'Sokak Hayvanları', icon: '🐾', color: Color(0xFFF59E0B),
  ),
  CategoryType.egitim: const CategoryItem(
    id: 'egitim', label: 'Eğitim', icon: '📚', color: Color(0xFF3B82F6),
  ),
  CategoryType.diger: const CategoryItem(
    id: 'diger', label: 'Diğer', icon: '🌟', color: Color(0xFF6B7280),
  ),
};