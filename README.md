# Oyster Card

Oyster card project

## Run the tests

```sh
rspec
```

## Usage

Require the `lib` folder in your file.

```ruby
entry_station = Station.new(station_name: 'Piccadily', zone: 1)
exit_station = Station.new(station_name: 'Waterloo', zone: 1)
journeylog = JourneyLog.new(Journey)
oystercard = Oystercard.new(journeylog)
oystercard.touch_in(entry_station)
oystercard.touch_out(exit_station)
```
