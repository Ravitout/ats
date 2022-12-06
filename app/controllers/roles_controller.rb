class RolesController < ApplicationController
	# before_action :require_login, except: [:new, :create, :show]
	def index
		@roles = Role.all
	end
	def show 
		@roles = Role.find(params[:id])
	end
end
