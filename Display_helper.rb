module Display_helper

  def failed(msg)
    screen_msg_fail = msg.gsub(/[^A-Za-z0-9]+/, '_')
    path = "screenshots/#{screen_msg_fail}#{Time.now.to_s}.png"
    page.save_screenshot(path, full: true)
    @logs.puts("[FAILED] #{msg}")
  end

  def complete(msg)
    screen_msg_complete = msg.gsub(/[^A-Za-z0-9]+/, '_')
    @logs.puts("[COMPLETE] #{msg}")
  end

  def reset
    visit '/'
  end
end
