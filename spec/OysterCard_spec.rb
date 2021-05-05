require 'OysterCard'

describe OysterCard do
  let(:station){ double :station }
  describe '#journey' do
    it "is not initially in journey" do
      expect(subject.in_journey?) == false
    end

    it "can touch in" do
      subject.topup(10)
      subject.touchin(station)
      expect(subject.in_journey?) == true
    end

    it "won't touch in if below MIN_BALANCE" do
      expect { subject.touchin(station) }.to raise_error "Balance too low"
    end

    it "stores the entry station" do
      subject.topup(10)
      subject.touchin(station)
      expect(subject.entrystation).to eq station
    end

    it "can touchout" do
      subject.topup(10)
      subject.touchin(station)
      subject.touchout(station)
      expect(subject.in_journey?) == false
    end

    it "deducts minimum charge on touch out" do
      subject.topup(10)
      subject.touchin(station)
      expect { subject.touchout(station) }.to change { subject.balance }.by(-OysterCard::MIN_CHARGE)
    end

    it "forgets entry station on touchout" do
      subject.topup(10)
      subject.touchin(station)
      subject.touchout(station)
      expect(subject.entrystation).to eq nil
    end

    it "stores the exit station" do
      subject.topup(10)
      subject.touchout("euston")
      expect(subject.exitstation).to eq "euston"
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
