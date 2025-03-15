class WelcomeController < ApplicationController
  skip_authenticate

  def index
    render inertia: 'welcome', props: {
      railsVersion: Rails.version,
      rubyVersion: RUBY_DESCRIPTION
    }
  end
end
