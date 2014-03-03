class EventsController < ApplicationController
  before_action :get_user
  before_action :set_event, only: [:edit, :update, :destroy, :show]

  def show
  end

  def index
    @events = @user.events
  end

  def new
    # just show the new event form view
    @event = @user.events.new
  end

  def edit
    # implicit set_event, and then show the view
  end

  def create
    @event = @user.events.new(event_params)

    if @event.save
      redirect_to user_events_path , notice: 'Event was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @event.update(event_params)
      @user.events.reload
      redirect_to user_events_path, notice: 'Event was successfully updated.' 
    else
      render action: 'edit'
    end
  end

  def destroy
    @event.destroy
      redirect_to user_events_path
  end

  private

    def get_user
      if !signed_in?
        redirect_to(:controller => 'welcome', :action => 'index')
      else
        @user = current_user
      end
    end

    def set_event
      @event = @user.events.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:description, :date, :details, :url, :picture, :id, :user_id)
    end
end
