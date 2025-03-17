class Auth::AuthenticatedSessionController < ApplicationController
  include RedirectIfAuthenticated

  skip_authenticate only: %i[new create]
  skip_redirect_if_authenticated only: :destroy
  skip_ensure_email_is_verified only: :destroy

  def new
    render inertia: 'auth/login', props: {
      status: flash[:status],
      canResetPassword: true
    }
  end

  def create
    form = Auth::LoginForm.new(params.permit(:email, :password, :remember))

    form.authenticate

    return redirect_back_or_to login_path, inertia: { errors: form.error_messages } if Current.auth.user.nil?

    redirect_to dashboard_path
  end

  def destroy
    Current.auth.logout

    reset_session

    redirect_to '/'
  end
end
