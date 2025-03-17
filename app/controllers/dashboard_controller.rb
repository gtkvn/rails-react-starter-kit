class DashboardController < ApplicationController
  def index
    render inertia: 'dashboard'
  end
end
