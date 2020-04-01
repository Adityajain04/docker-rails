# frozen_string_literal: true

# Root HomeController
class HomeController < ApplicationController
  skip_authorization_check
  def index; end
end
