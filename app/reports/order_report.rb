# TODO: пистаь отчеты в БД и доставать их оттуда
# TODO: добавить самую продаваемую позицию
# TODO: подумать над передачей временного диапазона генерации отчета в качестве аргумента
class OrderReport
  attr_reader :items

  def initialize
    @from = Utils::Calendar.saturday
    @till = (@from + 1.day).end_of_day
    @items = OrderQuery.new(from: @from, till: @till).execute
  end

  def generate
    total_count = items.size
    total_price = items.sum(:total_price)
    average_price = items.average(:total_price).to_i
    max_price = items.maximum(:total_price)

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

    query =  'SELECT products.name, categories.name, COUNT(*) AS count_all FROM products '
    query += 'INNER JOIN order_items ON products.id = order_items.product_id '
    query += 'LEFT OUTER JOIN categories ON categories.id = products.category_id '
    query += 'LEFT OUTER JOIN orders ON orders.id = order_items.order_id '
    query += "WHERE order_items.order_id IN (#{item_ids.join(',')}) "
    query += 'GROUP BY products.name, categories.name ORDER BY count_all DESC;'

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
