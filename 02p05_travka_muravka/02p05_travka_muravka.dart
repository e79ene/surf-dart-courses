import 'provided_code.dart';

void main() {
  final territoryLists = [...mapBefore2010.values, ...mapAfter2010.values];
  final territories = [for (final list in territoryLists) ...list];
  final machineSet = {for (final t in territories) ...t.machineries};
  final now = DateTime.now();
  final ages = [for (final m in machineSet) now.difference(m.releaseDate)]
    ..sort();

  final wholeAvg = avgDuration(ages);

  // Просто просуммировать половину списка нельзя, т.к количество элементов
  // может быть нечётным. Поэтому скопируем хвост в голову и получится что
  // средний элемент будет учтён с весом 1/2. Он это заслужил, т.к. не понятно
  // к старшей или младшей половине техники он относится.
  for (int i = 0; i <= ages.length / 2; i++) {
    ages[i] = ages[ages.length - 1 - i];
  }

  final oldestAvg = avgDuration(ages);

  print("Средний возраст по всем: ${durationInYears(wholeAvg)} лет");
  print("Средний возраст старейших: ${durationInYears(oldestAvg)} лет");
}

Duration avgDuration(Iterable<Duration> durationList) =>
    durationList.reduce((sum, age) => sum + age) ~/ durationList.length;

double durationInYears(Duration duration) => duration.inDays / 365.25;
