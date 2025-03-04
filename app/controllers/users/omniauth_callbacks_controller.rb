class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: [:google_oauth2]
    
    # def google_oauth2
    #   user = User.from_google(request.env['omniauth.auth'])
  
    #   if user.persisted?
    #     sign_in_and_redirect user, event: :authentication
    #     set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    #   else
    #     redirect_to new_user_registration_url, alert: 'Something went wrong'
    #   end
    # end

    def google_oauth2
        user = User.from_google(request.env['omniauth.auth'])

        if user
            sign_in_and_redirect user, event: :authentication
            set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
        else
            flash[:alert] = 'Access denied: Your email is not authorized.'
            redirect_to new_user_session_path
        end
    end
  
    def failure
      flash[:alert] = 'Google authentication failed.'
      redirect_to new_user_session_path
    end
  end
  