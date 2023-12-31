// booking_model.dart
class BookingModel {
  final String id;
  final String userId;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentStatus;
  final String paymentStatus;
  final String preferredPathologist;
  final String gender;

  BookingModel({
    required this.id,
    required this.userId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
    required this.paymentStatus,
    required this.preferredPathologist,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentStatus': appointmentStatus,
      'paymentStatus': paymentStatus,
      'preferredPathologist': preferredPathologist,
      'gender': gender,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      userId: map['userId'],
      appointmentDate: map['appointmentDate'],
      appointmentTime: map['appointmentTime'],
      appointmentStatus: map['appointmentStatus'],
      paymentStatus: map['paymentStatus'],
      preferredPathologist: map['preferredPathologist'],
      gender: map['gender'],
    );
  }
}
