// *cart_data.dart*

// ignore: unused_import
import 'package:flutter/material.dart';

class CartData {
  // الليستة اللي هتحتفظ بكل البرودكتس في الكارت
  static List<Map<String, dynamic>> items = [];

  // إضافة منتج للكارت
  static void add(Map<String, dynamic> product) {
    items.add(product);
  }

  // إزالة منتج من الكارت
  static void remove(Map<String, dynamic> product) {
    items.remove(product);
  }

  // مسح كل العناصر في الكارت
  static void clear() {
    items.clear();
  }
}