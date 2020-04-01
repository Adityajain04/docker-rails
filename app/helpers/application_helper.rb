# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      text = '<script>'
      text += "toastr.#{type}('#{message}', '', {
                  closeButton: true, progressBar: true })</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end

  def active_nav(arr)
    nav_class = ''
    arr.each do |child_arr|
      if (child_arr[0] == controller.controller_name) &&
         (child_arr[1] == controller.action_name)
        nav_class = 'active'
      end
    end
    nav_class
  end
end
