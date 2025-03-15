class Settings::AppearanceController < ApplicationController
  skip_ensure_email_is_verified

  def edit
    render inertia: 'settings/appearance'
  end
end
