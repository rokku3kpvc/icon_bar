def reply
  bot.requests[:sendMessage].last
end

def keyboard
  reply[:reply_markup][:keyboard]
end
