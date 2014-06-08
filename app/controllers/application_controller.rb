class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, :if => Proc.new {
    |c| c.request.format == 'text/javascript'
  }

	def index
	end

	def our_story
	end

	def events
	end

  def accomodations
  end

	def wedding_party
	end

	def photos
	end

	private

		def permitted_params
			@permitted_params ||= PermittedParams.new(params)
		end
end
