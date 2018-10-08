class Oystercard
  attr_reader :balance
  DEFAULT_MAXIMUM_AMOUNT = 90
  DEFAULT_MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
    @max_amount = DEFAULT_MAXIMUM_AMOUNT
    @in_journey = false
    @min_amount = DEFAULT_MINIMUM_AMOUNT
  end

  def top_up(amount)
    raise "Maximum amount = #{DEFAULT_MAXIMUM_AMOUNT}" if @balance + amount > @max_amount
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "You do not have the minimum amount for a journey" if @balance < @min_amount
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    deduct(@min_amount)
    @in_journey = false
  end

end
