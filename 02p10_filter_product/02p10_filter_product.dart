class Product {
  int id;
  String category;
  String name;
  double price;
  int quantity;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  String toString() =>
      "<${this.id}, ${this.category}, ${this.name}, ${this.price}, ${this.quantity}>";
}

abstract class Filter<T> {
  bool call(T object);
}

abstract class FilterByField<T, FieldType> extends Filter<T> {
  final FieldType Function(T) fieldGetter;

  FilterByField(this.fieldGetter);
}

class EqualsTo<T, FieldType> extends FilterByField<T, FieldType> {
  final FieldType value;
  
  EqualsTo(super.fieldGetter, this.value);

  @override
  bool call(T object) {
    return fieldGetter(object) == value;
  }
}

class LessThen<T, FieldType extends Comparable> extends FilterByField<T, FieldType> {
  final FieldType value;
  
  LessThen(super.fieldGetter, this.value);

  @override
  bool call(T object) {
    return fieldGetter(object).compareTo(value) < 0;
  }
}

Iterable<T> applyFilter<T>(Iterable<T> objects, Filter<T> filter) =>
    objects.where(filter);

const articles = '''
1,хлеб,Бородинский,500,5
2,хлеб,Белый,200,15
3,молоко,Полосатый кот,50,53
4,молоко,Коровка,50,53
5,вода,Апельсин,25,100
6,вода,Бородинский,500,5
''';

List<Product> parseProducts(String articles) {
  return articles
      .split(RegExp(r"\s*\n\s*"))
      .where((l) => l.isNotEmpty)
      .map((l) => l.split(','))
      .map((l) => Product(
            id: int.parse(l[0]),
            category: l[1],
            name: l[2],
            price: double.parse(l[3]),
            quantity: int.parse(l[4]),
          ))
      .toList();
}

void main() {
  final products = parseProducts(articles);
  print('All products:');
  products.forEach(print);
  
  print('\nFiltered price == 500:');
  applyFilter(products, EqualsTo((Product p) => p.price, 500)).forEach(print);

  print('\nFiltered category == "вода":');
  applyFilter(products, EqualsTo((Product p) => p.category, "вода")).forEach(print);

  print('\nFiltered quantity < 50:');
  applyFilter(products, LessThen((Product p) => p.quantity, 50)).forEach(print);
}
