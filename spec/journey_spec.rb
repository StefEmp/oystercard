require 'journey'
describe Journey do
    it 'does it create an entry station' do
        expect(subject.touch_in).to be(station) 
    end
end