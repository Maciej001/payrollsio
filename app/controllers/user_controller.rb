class UserController < ActionController::Base
	respond_to :json

	before_action :authenticate_user!, only: [:update]

  def show
		@user = User.find params[:id]
	end

	def create
		@user = User.new new_user_params

		if @member.save
			render 'user/show'
		else 
			respond_with @user
		end
	end

	private 

		def new_user_params
			params.require(:user).permit(:name, :email)
		end
end