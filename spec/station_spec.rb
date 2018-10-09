require 'station'
describe Station do
  subject{described_class.new(name: "station_name", zone:3)}
  it 'has a name' do
    expect(subject.name).to eq "station_name"
  end
  it 'station has a zone' do
    expect(subject.zone).to eq 3
  end
end
