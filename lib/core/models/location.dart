class Location {
  final String building;
  final int buildingId;
  double? cordX;
  double? cordY;

  Location({
    required this.building,
    required this.buildingId,
    this.cordX,
    this.cordY,
  });

  static Location? fromJson(Map<String, dynamic> json) {
    if (json['building'] == null) return null;
    final waze = json['waze'] ?? {};
    return Location(
      building: json['building'] ?? '',
      buildingId: json['building_id'] ?? 0,
      cordX: double.tryParse(waze['cord_x'] ?? ''),
      cordY: double.tryParse(waze['cord_y'] ?? ''),
    );
  }
}
