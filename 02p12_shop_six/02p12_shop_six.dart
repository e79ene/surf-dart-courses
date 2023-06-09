import 'dart:convert';

import 'input.dart';

class RawProductItem {
  final String name;
  final String categoryName;
  final String subcategoryName;
  final DateTime expirationDate;
  final int qty;

  RawProductItem({
    required this.name,
    required this.categoryName,
    required this.subcategoryName,
    required this.expirationDate,
    required this.qty,
  }) {}
}

extension MapDefaultInsert<K, V> on Map<K, V> {
  V getOrCreate(K key, V Function() valueGenerator) {
    if (containsKey(key)) {
      return this[key]!;
    } else {
      final value = valueGenerator();
      this[key] = value;
      return value;
    }
  }
}

typedef Category = Map<String, List<String>>;

void main() {
  final today = DateTime(2022, 12, 20);

  final actualProducts =
      input.where((p) => p.qty > 0 && p.expirationDate.isAfter(today));

  final catalog = Map<String, Category>();

  for (final p in actualProducts) {
    catalog
        .getOrCreate(p.categoryName, () => Category())
        .getOrCreate(p.subcategoryName, () => [])
        .add(p.name);
  }

  print(JsonEncoder.withIndent('  ').convert(catalog));
}
