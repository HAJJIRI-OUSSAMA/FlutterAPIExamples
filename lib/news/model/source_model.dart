class Source {
  final String id;
  final String name;

  // Constructor with named parameters
  Source({required this.id, required this.name});

  // Factory method to create a Source instance from JSON
  factory Source.fromJson(Map<String, dynamic>? json) {
    return Source(
      id: json?['id'] as String? ?? '',
      name: json?['name'] as String? ?? '',
    );
  }
}
