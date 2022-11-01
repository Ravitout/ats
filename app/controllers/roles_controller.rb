class RolesController < ApplicationController
	def index
		@roles = Role.all
	end
	def show 
		@roles = Role.find(params[:id])
	end
end
