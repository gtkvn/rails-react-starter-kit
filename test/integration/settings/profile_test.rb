require 'test_helper'

class ProfileTest < ActionDispatch::IntegrationTest
  test 'profile page is displayed' do
    user = FactoryBot.create(:user)

    acting_as(user).get settings_profile_edit_path

    assert_response :success
  end

  test 'profile information can be updated' do
    user = FactoryBot.create(:user)

    acting_as(user).patch settings_profile_edit_path, params: {
      name: 'Test User',
      email: 'test@example.com'
    }

    assert_redirected_to settings_profile_edit_path

    user.reload

    assert_equal 'Test User', user.name
    assert_equal 'test@example.com', user.email
  end

  test 'email verification status is unchanged when the email address is unchanged' do
    user = FactoryBot.create(:user)

    acting_as(user).patch settings_profile_edit_path, params: {
      name: 'Test User',
      email: user.email
    }

    assert_redirected_to settings_profile_edit_path
    assert_not user.reload.email_verified_at.blank?
  end

  test 'user can delete their account' do
    user = FactoryBot.create(:user)

    acting_as(user).delete settings_profile_destroy_path, params: {
      password: 'password'
    }

    assert_redirected_to '/'

    assert_guest
    assert_raise(ActiveRecord::RecordNotFound) { user.reload }
  end

  test 'correct password must be provided to delete account' do
    user = FactoryBot.create(:user)

    acting_as(user).delete settings_profile_destroy_path, params: {
      password: 'wrong-password'
    }

    assert_redirected_to settings_profile_edit_path
    assert_not_nil user.reload
  end
end
