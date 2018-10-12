# Oystercard
class Oystercard
  attr_reader :balance, :entry_station
  DEFAULT_MAXIMUM_AMOUNT = 90
  DEFAULT_MINIMUM_AMOUNT = 1
  BEEN_FINED = 'You have been fined'
  NO_MIN_AMOUNT = 'You do not have the minimum amount for a journey'

  def initialize(journey_log)
    @balance = 0
    @max_amount = DEFAULT_MAXIMUM_AMOUNT
    @min_amount = DEFAULT_MINIMUM_AMOUNT
    @journeylog = journey_log
  end

  def top_up(amount)
    raise "Maximum amount = #{DEFAULT_MAXIMUM_AMOUNT}" if @balance + amount > @max_amount
    @balance += amount
  end

  def touch_in(entry_station)
    fine unless @journeylog.current_journey.complete?
    raise NO_MIN_AMOUNT if @balance < @min_amount
    @journeylog.start(entry_station)
  end

  def touch_out(exit_station)
    return fine unless @journeylog.current_journey.complete?
    @journeylog.finish(exit_station)
    deduct(@journeylog.current_journey.fare)
  end

  def in_journey?
    @journeylog.current_journey.complete?
  end

  def journeys
    @journeylog.journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def fine
    deduct(@journeylog.current_journey.fare)
    @journeylog.finish(nil)
    raise BEEN_FINED
  end
end
