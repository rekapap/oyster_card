require "journey"
describe Journey do
subject{described_class.new("entry_station")}
it "stores the entry station" do
  expect(subject.entry_station).to eq "entry_station"
end
end
