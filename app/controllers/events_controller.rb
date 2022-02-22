class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @events = Event.all
    @id = params[:id] #pour chercher l'event en fonction de l'id saisi
  end

  def new
    @event = Event.new
  end

  def edit
  end
  
end
