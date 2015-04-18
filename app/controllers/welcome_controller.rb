class WelcomeController < ApplicationController
  def index
    @zones = get_current_zone
  end

  def get_current_zone

  end
end
