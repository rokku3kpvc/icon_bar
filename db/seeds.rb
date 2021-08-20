tinctures = Category.create(name: 'Настойки')
cocktails = Category.create(name: 'Коктейли')
shots = Category.create(name: 'Шоты')
rest = Category.create(name: 'Остальное')

# настойки
Product.create(category: tinctures, name: '🍋 Лимончело', price: 200)
Product.create(category: tinctures, name: '🍫 Шоколадная', price: 200)
Product.create(category: tinctures, name: '🥒 Огуречная', price: 200)
Product.create(category: tinctures, name: '🍎 Яблочная', price: 200)
Product.create(category: tinctures, name: '🍓 Ягодная', price: 250)

# коктейли
Product.create(category: cocktails, name: '🍭 Карамельное Яблоко', price: 400)
Product.create(category: cocktails, name: '🍒 Кранберри', price: 350)
Product.create(category: cocktails, name: '🍋 Грейпфрут сплэш', price: 350)
Product.create(category: cocktails, name: '🍊 Оранж', price: 300)
Product.create(category: cocktails, name: '🥒 Джин Тоник с Огурцом', price: 300)
Product.create(category: cocktails, name: '🥃 Лонг Айленд', price: 450)

# шоты и пиво
Product.create(category: shots, name: '🍶 Водка', price: 150)
Product.create(category: shots, name: '🥃 Виски', price: 300)
Product.create(category: shots, name: '🥃 Jim Beam', price: 400)
Product.create(category: shots, name: '🍉 5 шт. Арбуз-Текила', price: 1000)
Product.create(category: shots, name: '🧆 3 шт. с Соком Зёрен Граната', price: 400)
Product.create(category: shots, name: '🌶 Табаско Шот', price: 200)
Product.create(category: shots, name: '🤠 Зелёный Мексиканец', price: 200)

# остальное
Product.create(category: rest, name: '🧃 Сок', price: 100)
Product.create(category: rest, name: '🥤 Кола / Спрайт', price: 100)
Product.create(category: rest, name: '💦 Бутылка Воды', price: 100)
Product.create(category: rest, name: '💥 Энергетик', price: 150)
Product.create(category: rest, name: '🍾 Шампанское', price: 1200)
Product.create(category: rest, name: '🍺 Пиво', price: 250)
