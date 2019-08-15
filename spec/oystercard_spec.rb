    
require 'oystercard'
describe Oystercard do
    let(:station) { double(:station) }
    let(:exit_station) { double(:exit_station) }
  it 'can return the balance of 0' do
  oyster = Oystercard.new
  expect(oyster.balance).to eq(0)
  end


  it 'can top_up money to oyster card' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end


  it 'can return new balance' do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end

  it 'raise an exception when balance exceed the limit' do

  oyster = Oystercard.new
  oyster.top_up(80)
  expect { oyster.top_up(11) }.to raise_error("Too much money! Exceed limit!")
  end

  xit 'response to deduct method' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  xit 'can deduct the money' do
    subject.deduct(10)
    expect(subject.balance).to eq(-10)
  end

  it 'can check whether it is in use' do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject.in_journey?).to be(true)
  end
  it 'can touch out' do
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.in_journey?).to be(false)
  end
  it 'can check whether money is available to touch in' do
    expect { subject.touch_in(station) }.to raise_error('You are too poor')
  end
  it 'deduct at end of journey' do
    subject.top_up(5)
    subject.touch_in(station)
    expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-MIN_FARE)
  end
  it 'defines an entry station on card' do
    subject.top_up(5)
    subject.touch_in(station)
    expect(subject.entry_station).to eq(station)
  end
  it 'forget entry station on card' do
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.entry_station).to be_nil
  end
  xit 'defines an exit station on card' do
    subject.top_up(5)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end
  it 'storing exit and entry stations' do
    subject.top_up(5)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.journey_history).to include({ start: station, end: exit_station })
  end
  it 'has an empty journey history by default' do
    expect(subject.journey_history).to be_empty
  end
end