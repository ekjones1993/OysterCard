class OysterCard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1
  attr_reader :balance
  attr_reader :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def topup(money)
    fail "Max Balance of #{MAX_BALANCE} Exceeded" if money + balance > MAX_BALANCE
    @balance += money 
  end

  def touchin
    fail "Balance too low" if balance < MIN_BALANCE
    @in_journey == true
  end

  def touchout
    deduct(MIN_CHARGE)
    @in_journey == false
  end

  private

  def deduct(money)
    @balance -= money
  end

end