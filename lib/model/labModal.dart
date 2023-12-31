class LabModel {
  final String id;
  final String name;
  final String address;
  final List<LabTestModel> tests; // List of TestModels
  final String timings;

  LabModel({
    required this.id,
    required this.name,
    required this.address,
    required this.tests,
    required this.timings,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'tests': tests.map((test) => test.toMap()).toList(),
      'timings': timings,
    };
  }

  factory LabModel.fromMap(Map<String, dynamic> map) {
    return LabModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      tests: (map['tests'] as List<dynamic>? ?? [])
          .map((testMap) => LabTestModel.fromMap(testMap))
          .toList(),
      timings: map['timings'],
    );
  }
}

class LabTestModel {
  final String testName;
  final double testPrice;

  LabTestModel({
    required this.testName,
    required this.testPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'testName': testName,
      'testPrice': testPrice,
    };
  }

  factory LabTestModel.fromMap(Map<String, dynamic> map) {
    return LabTestModel(
      testName: map['testName'],
      testPrice: map['testPrice'],
    );
  }
}
