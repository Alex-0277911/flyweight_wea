// Шаблон Flyweight - це структурний шаблон проектування, який дозволяє
// ефективно використовувати об'єкти з великою кількістю дрібної грануляції.
// Це досягається шляхом розділення об'єктів на дві категорії: внутрішні та
// зовнішні. Внутрішні об'єкти містять дані, які є загальними для декількох
// об'єктів, тоді як зовнішні об'єкти містять дані, які є унікальними для
// кожного об'єкту. Внутрішні об'єкти зберігаються в спільному буфері, і кожний
// зовнішній об'єкт містить посилання на відповідний внутрішній об'єкт.

// У Dart можна реалізувати шаблон Flyweight наступним чином:

// клас Flyweight містить внутрішній стан (в даному випадку, рядок _sharedState)
// і метод operation(), який демонструє спільний стан та унікальний стан об'єкта.

class Flyweight {
  final String _sharedState; // внітрішній стан
  Flyweight(this._sharedState);

  void operation(String uniqueState) {
    print(
        'Flyweight: Displaying shared ($_sharedState) and unique ($uniqueState) state.');
  }
}

class FlyweightFactory {
  final _flyweights = <String, Flyweight>{};

// Клас FlyweightFactory містить метод getFlyweight(), який приймає рядок
// sharedState в якості параметру і повертає відповідний об'єкт Flyweight.
// Якщо такий об'єкт вже існує, метод повертає його, інакше створює новий об'єкт
// Flyweight, додає його до списку внутрішніх об'єктів і повертає його.

  Flyweight? getFlyweight(String sharedState) {
    if (_flyweights.containsKey(sharedState)) {
      return _flyweights[sharedState]; // повертаємо існуючий об'єкт
    } else {
      final flyweight = Flyweight(sharedState);
      _flyweights[sharedState] = flyweight;
      return flyweight; // повертаємо новий об'єкт
    }
  }

// Метод listFlyweights() виводить список всіх внутрішніх об'єктів Flyweight,
// що містяться в FlyweightFactory.

  void listFlyweights() {
    final count = _flyweights.length;
    print('\nFlyweightFactory: I have $count flyweights:');
    for (final flyweight in _flyweights.entries) {
      print(flyweight.key);
    }
  }
}

// У функції clientCode() відбувається взаємодія з об'єктами Flyweight.
// При створенні об'єкту Flyweight, який має загальний стан (наприклад,
// 'foo' у першому та третьому виклику), метод getFlyweight() повертає
// відповідний об'єкт, який вже був створений. При створенні об'єкту Flyweight,
// який має унікальний стан (наприклад, 'one' та 'two' у викликах operation()),
// метод getFlyweight() створює новий об'єкт Flyweight.

void clientCode(FlyweightFactory flyweightFactory) {
  final flyweight1 = flyweightFactory.getFlyweight('foo');
  flyweight1!.operation('one');

  final flyweight2 = flyweightFactory.getFlyweight('bar');
  flyweight2!.operation('two');

  final flyweight3 = flyweightFactory.getFlyweight('foo');
  flyweight3!.operation('three');

  flyweightFactory.listFlyweights();
}

void main() {
  final flyweightFactory = FlyweightFactory();
  clientCode(flyweightFactory);
}
