class EventsController < ApplicationController

  before_action :require_login!
  before_action :set_venue!, only: %i[new create]
  before_action :set_event!, only: %i[show edit update destroy]

  def show
    authorize @event
  end

  def new
    @event = @venue.events.new
    authorize @event
  end

  def create
    @event = @venue.events.new event_params
    authorize @event

    if @event.save
      redirect_to @event, flash: { success: 'Created event' }
    else
      render :new
    end
  end

  def edit
    authorize @event
  end

  def update
    authorize @event
    if @event.update event_params
      redirect_to [:edit, @event], flash: { success: 'Saved event' }
    else
      render :edit
    end
  end

  def destroy
    authorize @event
    @event.destroy
  end

  private

    def set_venue!
      @venue = Venue.find(params[:venue_id])
    end

    def set_event!
      @event = Event.find(params[:id])
      @venue = @event.venue
    end

    def event_params
      params.fetch(:event, {}).permit(
        :name, :description, :room, :category,
        :recurrence, :start_date, :end_date, :start_time, :end_time,
        manager: {},
        languages: [],
      )
    end

end
