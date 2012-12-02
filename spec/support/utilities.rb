include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in I18n.t(:user_email),    :with => user.email
  fill_in I18n.t(:user_password), :with => user.password
  click_button I18n.t(:url_sign_in)
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end