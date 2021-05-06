require 'OysterCard'
describe OysterCard do

  let(:entrystation) { double :station }
  let(:exitstation) { double :station }

  describe '#journey' do
    it "is not initially in journey" do
      expect(subject.in_journey?) == false
    end
  end

  describe '#touchin' do
    before do
      subject.topup(10)
      subject.touchin(entrystation)
    end
    it "can touch in" do
      expect(subject.in_journey?) == true
    end
    it "stores the entry station" do
      expect(subject.entrystation).to eq entrystation
    end
  end

  describe '#touchout' do
    before do
      subject.topup(10)
      subject.touchin(entrystation)
      subject.touchout(exitstation)
    end

    it "can touchout" do
      expect(subject.in_journey?) == false
    end

    it "deducts minimum charge on touch out" do
      expect { subject.touchout(exitstation) }.to change { subject.balance }.by(-OysterCard::MIN_CHARGE)
    end

    it "forgets entry station on touchout" do
      expect(subject.entrystation).to eq nil
    end

    it "stores the exit station" do
      expect(subject.exitstation).to eq exitstation
    end
  end
  
  describe '#balance' do
    it "has a balance of 0" do
      expect(subject.balance).to eq(0)
    end

    it "won't touch in if below MIN_BALANCE" do
      expect { subject.touchin(entrystation) }.to raise_error "Balance too low"
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
