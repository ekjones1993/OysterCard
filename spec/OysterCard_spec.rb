require 'OysterCard'

describe OysterCard do

  describe '#journey' do
    it "is not initially in journey" do
      expect(subject.in_journey) == false
    end

    it "can touch in" do
      subject.topup(10)
      subject.touchin
      expect(subject.in_journey) == true
    end

    it "won't touch in if below MIN_BALANCE" do
      expect { subject.touchin }.to raise_error "Balance too low"
    end

    it "can touchout" do
      subject.topup(10)
      subject.touchin
      subject.touchout
      expect(subject.in_journey) == false
    end

    it "deducts minimum charge on touch out" do
      subject.topup(10)
      subject.touchin
      expect { subject.touchout }.to change { subject.balance }.by(-OysterCard::MIN_CHARGE)
    end
  end

  describe '#balance' do
    it "has a balance of 0" do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#topup' do
    it { is_expected.to respond_to(:topup).with(1).argument }
    
    it "can add to the balance" do
      
      expect{ subject.topup(1) }.to change{ subject.balance }.by 1
    end

    it "will cause an error if at maximum balance" do
      max_balance = OysterCard::MAX_BALANCE
      subject.topup(max_balance)
      expect { subject.topup(1) }.to raise_error "Max Balance of #{max_balance} Exceeded"
    end
  end
end