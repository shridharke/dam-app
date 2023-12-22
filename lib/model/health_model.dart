class HealthModel {
  final String icon;
  final String value;
  final String title;

  HealthModel({required this.icon, required this.value, required this.title});

  // Add a fromMap factory constructor
  factory HealthModel.fromMap(String icon, String value, String title) {
    // Extract the necessary fields from the map
    // This is highly dependent on how your data is structured in Firebase
    return HealthModel(
      icon: icon,
      value: value,
      title: title,
    );
  }
}
