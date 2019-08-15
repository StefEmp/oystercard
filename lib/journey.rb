class Journey
    MAX_CONSTANT = 90
    MIN_CONSTANT = 1
    MIN_FARE = 5
    attr_reader :entry_station, :exit_station
  def initialize
   
  end

  def touch_in(station)
    @entry_station = station
    # fail 'You are too poor' if @balance < MIN_CONSTANT
  end
  def touch_out(station)
    @exit_station = station
    store_journey_history
    @entry_station = nil
    @exit_station = nil
    deduct(MIN_FARE)
  end

  def store_journey_history
    @journey_history.push({ start: @entry_station, end: @exit_station })
  end
end