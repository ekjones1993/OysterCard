class OysterCard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1
  attr_reader :balance
  attr_reader :journeys
  attr_reader :in_journey

  def initialize
    @balance = 0
    @journeys = {}
    @in_journey = false

  end

  def topup(money)
    fail "Max Balance of #{MAX_BALANCE} Exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touchin(entrystation)
    fail "Balance too low" if balance < MIN_BALANCE
    @journeys[:entrystation] = entrystation
    @in_journey = true
  end

  def touchout(exitstation)
    deduct(MIN_CHARGE)
    @journeys[:exitstation] = exitstation
    @in_journey = false
  end

  private

  def deduct(money)
    @balance -= money
  end

end
