abstract class Person {
  final String name;

  Person({required this.name});

  void printInfo() {
    print('Имя: $name');
  }
}

class Footballer extends Person {
  String team;

  // позиция на поле
  String position;

  // количество забитых голов
  int goals;

  Footballer({
    required String name,
    required this.team,
    required this.position,
    required this.goals
    }) : super(name: name);

  @override
  void printInfo() {
    super.printInfo();
    print('Команда: $team');
    print('Позиция: $position');
    print('Голы: $goals');
  }
}

class Coach extends Person {
  String team;

  // количество выигранных матчей
  int wins;

  Coach({
    required String name,
    required this.team,
    required this.wins
    }) : super(name: name);

  @override
  void printInfo() {
    super.printInfo(); // Вызов метода родителя
    print('Команда: $team');
    print('Победы: $wins');
  }
}

void main() {
  final footballer1 = Footballer(name: 'Leo', team: 'Barcelona', position: 'Forward', goals: 10);
  final coach1 = Coach(name: 'Pep', team: 'Manchester City', wins: 15);

  footballer1.printInfo();
  coach1.printInfo();
}
