class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def index
	end

	def our_story
	end

	def events
	end

  def accomodations
  end

	def bridal_party
	end

	def photos
	end

	private

		def permitted_params
			@permitted_params ||= PermittedParams.new(params)
		end
end
