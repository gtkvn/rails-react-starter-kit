class Auth::PasswordResetLinkController < ApplicationController
  include RedirectIfAuthenticated

  skip_authenticate

  def new
    render inertia: 'auth/forgot-password', props: {
      status: flash[:status]
    }
  end

  def create
    form = Auth::SendPasswordResetLinkForm.new(params.permit(:email))

    return redirect_back_or_to password_request_path, flash: { status: 'We have emailed your password reset link.' } if form.send_reset_link?

    redirect_back_or_to password_request_path, inertia: { errors: form.error_messages }
  end
end
