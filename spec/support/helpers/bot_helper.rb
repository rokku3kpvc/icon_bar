def reply
  bot.requests[:sendMessage].last
end

def keyboard
  reply[:reply_markup][:keyboard]
end

def inline_keyboard
  reply[:reply_markup][:inline_keyboard]
end
