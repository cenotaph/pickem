class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
      if @user
        if @user.persisted?
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
          sign_in_and_redirect @user, :event => :authentication
        else
          session["devise.google_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      else
        flash[:error] = 'Your account is not found'
        redirect_to '/'
      end
  end
  #
  # def google_oauth2
  #
  #   user = ::User.from_omniauth(request.env["omniauth.auth"])
  #
  #   if user.persisted?
  #     flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: user.provider)
  #     sign_in_and_redirect user, event: :authentication
  #   else
  #     session["devise.google_data"] = oauth_response.except(:extra)
  #     params[:error] = :account_not_found
  #     do_failure_things
  #   end
  # end

end