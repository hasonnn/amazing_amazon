class ContactsController < ApplicationController
    def new
    end
    def create
        @name=params[:name]
        @email=params[:email]
        @message=params[:message]
    end
end
