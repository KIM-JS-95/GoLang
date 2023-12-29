class FlightData {
  final String departureShort;
  final String departure;
  final String date;
  final String destinationShort;
  final String destination;
  final String flightNumber;
  final String duration;
  final String time;
  final String time2;
  final int id;
  final String? activity;

  FlightData({
    required this.departureShort,
    required this.departure,
    required this.date,
    required this.destinationShort,
    required this.destination,
    required this.flightNumber,
    required this.duration,
    required this.time,
    required this.time2,
    required this.id,
    this.activity,
  });

  FlightData copyWith({
    String? departureShort,
    String? departure,
    String? date,
    String? destinationShort,
    String? destination,
    String? flightNumber,
    String? duration,
    String? time,
    String? time2,
    int? id,
    String? activity,
  }) =>
      FlightData(
        departureShort: departureShort ?? this.departureShort,
        departure: departure ?? this.departure,
        date: date ?? this.date,
        destinationShort: destinationShort ?? this.destinationShort,
        destination: destination ?? this.destination,
        flightNumber: flightNumber ?? this.flightNumber,
        duration: duration ?? this.duration,
        time: time ?? this.time,
        time2: time2 ?? this.time2,
        id: id ?? this.id,
        activity: activity ?? this.activity,
      );
}
