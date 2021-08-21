module Utils
  class Calendar
    # эта штука показывает либо прошедшуюю, либо текущую субботу от сегодняшнего дня
    # например, в пятницу она покажет субботу на той неделе, как и в другие дни, кроме субботы
    # запутанно, но работает, так что не трогать
    def self.saturday
      now = Time.zone.now
      now_index = now.wday
      return now.beginning_of_day if now_index == 6

      sat_index = Date::DAYNAMES.reverse.index('Saturday')
      days_before = (now.wday + sat_index) % 7 + 1

      (now - days_before.days).beginning_of_day
    end
  end
end
