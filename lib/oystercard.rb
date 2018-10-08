class Oystercard
  attr_reader :balance
  DEFAULT_MAXIMUM_AMOUNT = 90

  def initialize(max_amount = DEFAULT_MAXIMUM_AMOUNT)
    @balance = 0
    @max_amount = max_amount
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum amount = #{DEFAULT_MAXIMUM_AMOUNT}" if @balance + amount > @max_amount
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

end
