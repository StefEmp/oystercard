
 MAX_CONSTANT = 90
 MIN_CONSTANT = 1
 MIN_FARE = 5
class Oystercard
  attr_reader :oystercard, :balance, :entry_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(money)
      if too_much?(money)
      raise "Too much money! Exceed limit!"
    else
      @balance += money
    end
  end

  def too_much?(money)
    @balance + money > MAX_CONSTANT
  end

  def in_journey?
    if @entry_station == nil 
      return false
    else
      return true
    end
  end


  def touch_in(station)
    @entry_station = station
    fail 'You are too poor' if @balance < MIN_CONSTANT
   
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
  private

  def deduct(money)
    @balance -= money
  end
end