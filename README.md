// Шаблон Flyweight - це структурний шаблон проектування, який дозволяє
// ефективно використовувати об'єкти з великою кількістю дрібної грануляції.
// Це досягається шляхом розділення об'єктів на дві категорії: внутрішні та
// зовнішні. Внутрішні об'єкти містять дані, які є загальними для декількох
// об'єктів, тоді як зовнішні об'єкти містять дані, які є унікальними для
// кожного об'єкту. Внутрішні об'єкти зберігаються в спільному буфері, і кожний
// зовнішній об'єкт містить посилання на відповідний внутрішній об'єкт.