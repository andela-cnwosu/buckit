module Oauth
  class ApplicationsController < Doorkeeper::ApplicationsController
    include SessionsHelper

    before_action :application, only: [:show, :update, :destroy, :edit]

    def show
    end

    def edit
    end

    def index
      @applications = current_user.oauth_applications
    end

    def create
      @application = doorkeeper_application
      if @application.save
        flash_message(:create)
        redirect_to oauth_application_url(@application)
      else
        render :new
      end
    end

    def update
      if @application.update(application_params)
        flash_message(:update)
        redirect_to oauth_application_url(@application)
      else
        render :edit
      end
    end

    def destroy
      @application.destroy
      flash_message(:destroy)
      redirect_to oauth_applications_url
    end

    private

    def application
      @application = current_user.oauth_applications.find(params[:id])
    end

    def application_params
      params.require(:doorkeeper_application).permit(
        :name,
        :redirect_uri,
        :scopes
      )
    end

    def doorkeeper_application
      app = Doorkeeper::Application.new(application_params)
      if Doorkeeper.configuration.confirm_application_owner?
        app.owner = current_user
      end
      app
    end

    def flash_message(action)
      scope = [:doorkeeper, :flash, :applications, action]
      flash[:notice] = I18n.t(:notice, scope: scope)
    end
  end
end
