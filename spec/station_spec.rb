require 'station'
describe Station do
  subject{described_class.new"station_name", 3}
  it 'has a name' do
    expect(subject.name).to eq "station_name"
  end
  it 'station has a zone' do
    expect(subject.zone).to eq 3
  end
end
