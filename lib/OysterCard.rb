class OysterCard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1
  attr_reader :balance
  attr_reader :entrystation
  attr_reader :exitstation
  attr_reader :journey

  def initialize
    @balance = 0
    @journey

  end

  def topup(money)
    fail "Max Balance of #{MAX_BALANCE} Exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touchin(station)
    fail "Balance too low" if balance < MIN_BALANCE
    @entrystation = station
  end

  def touchout(station)
    deduct(MIN_CHARGE)
    @exitstation = station
    @entrystation = nil
  end

  def in_journey?
    !!entrystation
  end

  private

  def deduct(money)
    @balance -= money
  end

end
