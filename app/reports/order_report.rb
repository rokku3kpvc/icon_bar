# писать период отчета и его ID |
# сколько всего заказов |
# на какую сумму |
# самый большой заказ |
# средняя стоимость заказа |
# полный список товаров и скок было продано (писать даже если 0, сортировка по убыванию) |
# список тех, кто создавал отчеты с количествов по убыванию |
# диапазон от 00:00 субботы до 23:59 воскресенья. при запросе показывать последнюю субботу |
#
#     # icon_bar=# SELECT COUNT(*) AS count_all, "products"."name" AS products_name FROM "products" INNER JOIN "order_items" ON
#     # "products"."id" = "order_items"."product_id" WHERE "order_items"."order_id" IN (1,2,3,4,5,7,8,10) GROUP BY "products"."name";
#     #  count_all |     products_name
#     # -----------+------------------------
#     #          1 | 🌶 Табаско Шот
#     #          2 | 🥃 Лонг Айленд
#     #          1 | 🍋 Грейпфрут сплэш
#     #          1 | 🍭 Карамельное Яблоко
#     #          1 | 🥒 Джин Тоник с Огурцом
#     #          3 | 🥒 Огуречная
#     #          1 | 🍓 Ягодная
#     #          1 | 🍶 Водка
#     #          2 | 🍋 Лимончело
#     #          1 | 🍫 Шоколадная
#     #
#     #     #icon_bar=# SELECT COUNT(*) AS count_all, "users"."first_name" AS first_name FROM "orders" LEFT OUTER JOIN "users"
#     #     # ON "users"."id" = "orders"."user_id" WHERE "orders"."state" = 'confirmed' GROUP BY "users"."first_name";
#     #     #  count_all |   first_name
#     #     # -----------+----------------
#     #     #          1 | Adelina
#     #     #          1 | Elvine
#     #     #          2 | Ni
#     #     #          2 | pridumaisam.og
#     #     #          1 | Дрейк
#     #     #          1 | Егор
#     #     # (6 строк)
# TODO: пистаь отчеты в БД и доставать их оттуда
# TODO: добавить самую продаваемую позицию
class OrderReport
  attr_reader :items

  def initialize
    @from = Utils::Calendar.saturday
    # @from = Time.zone.now - 5.days
    @till = (@from + 1.day).end_of_day
    # @till = Time.zone.now + 1.day
    @items = OrderQuery.new(from: @from, till: @till).execute
  end

  def generate
    total_count = items.size # 8
    total_price = items.sum(:total_price) # 3750
    average_price = items.average(:total_price).to_i # 468
    max_price = items.maximum(:total_price) # 1000

    text_report = "📆 Отчёт о продажах\n\n"
    text_report += "⏰ Период: __#{format_time(@from)} - #{format_time(@till)}__\n\n"
    text_report += "💪🏻 Всего заказов оформлено: #{total_count}\n"
    text_report += "💰 Общая сумма всех заказов: #{total_price}₽\n"
    text_report += "💵 Средняя сумма заказа: #{average_price}₽\n"
    text_report += "🤑 Максимальная сумма заказа: #{max_price}₽\n\n"
    text_report += "📊 Статистика по позициям:\n#{products_sales_chart}\n"
    text_report += "👨🏼‍💻 Статистика по пользователям:\n#{users_sales_chart}\n"

    text_report
  end

  private

  def format_time(time)
    time.strftime('%d-%m-%Y %H:%M:%S')
  end

  def products_sales_chart
    item_ids = []
    items.each { |i| item_ids << i.id }

    return '' if item_ids.empty?

    # query =  'SELECT COUNT(*) AS count_all, products.name FROM products '
    # query += 'INNER JOIN order_items ON products.id = order_items.product_id '
    # query += "WHERE order_items.order_id IN (#{item_ids.join(',')}) GROUP BY products.name ORDER BY count_all DESC;"
    query =  'SELECT products.name, categories.name, COUNT(*) AS count_all FROM products '
    query += 'INNER JOIN order_items ON products.id = order_items.product_id '
    query += 'LEFT OUTER JOIN categories ON categories.id = products.category_id '
    query += 'LEFT OUTER JOIN orders ON orders.id = order_items.order_id '
    query += "WHERE order_items.order_id IN (#{item_ids.join(',')}) "
    query += 'GROUP BY products.name, categories.name ORDER BY count_all DESC;'

    # .map { |v| "#{v.second} - #{v.first} шт.\n" }
    ActiveRecord::Base.connection.execute(query)
                      .values
                      .map { |v| "#{v.first} (__#{v.second}__) - **#{v.third} шт.**\n" }
                      .join
  end

  def users_sales_chart
    query =  'SELECT COUNT(*) AS count_all, users.first_name FROM orders '
    query += 'LEFT OUTER JOIN users ON users.id = orders.user_id '
    query += "WHERE orders.state = 'confirmed' AND orders.updated_at BETWEEN '#{format_time(@from)}' AND '#{format_time(@till)}' "
    query += 'GROUP BY users.first_name ORDER BY count_all DESC;'

    ActiveRecord::Base.connection.execute(query)
                      .values
                      .map { |v| "[#{v.second}](tg://user?id=#{v.first}) - #{v.first}\n" }
                      .join
  end
end
