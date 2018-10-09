# Oystercard
class Oystercard
  attr_reader :balance, :entry_station, :journeys
  DEFAULT_MAXIMUM_AMOUNT = 90
  DEFAULT_MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
    @max_amount = DEFAULT_MAXIMUM_AMOUNT
    @min_amount = DEFAULT_MINIMUM_AMOUNT
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "Maximum amount = #{DEFAULT_MAXIMUM_AMOUNT}" if @balance + amount > @max_amount
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'you have been fined for not touching out' unless @entry_station.nil?
    raise 'You do not have the minimum amount for a journey' if @balance < @min_amount
    @entry_station = entry_station
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_out(exit_station)
    deduct(@min_amount)
    @journeys << { 'entry station' => @entry_station, 'exit station' => exit_station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
