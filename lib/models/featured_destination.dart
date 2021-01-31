class FeaturedDestination {

  final String name;
  final DateTime arrival;

  FeaturedDestination({ this.name, this.arrival });

  factory FeaturedDestination.fromJson(Map<String, dynamic> json) {
    return FeaturedDestination(
      name: json['name'],
      arrival: json['arrival'] != null ? DateTime.parse(json['arrival']) : null
    );
  }
}