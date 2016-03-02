class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]

	def index
		@secrets = Secret.all
	end

	def create
		user = User.find(params[:id])
		user.secrets.create(content: params[:content])

		redirect_to "/users/#{user.id}"
	end

	def destroy
		secret = Secret.find(params[:id])
		secret.destroy if secret.user == current_user
		
		redirect_to "/users/#{current_user.id}"
	end

	def like
		secret = Secret.find(params[:secret_id])
		user = secret.user
		if user == current_user
		Like.create(user: user, secret: secret)
		redirect_to "/secrets"
		end	

	end

	def unlike
		secret = Secret.find(params[:secret_id])
		user = secret.user
		like = Like.find_by(secret: secret, user: user)
		like.destroy if user == current_user
		redirect_to  "/secrets"
	end

end
