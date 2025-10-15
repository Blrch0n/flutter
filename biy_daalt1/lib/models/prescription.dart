class PrescriptionItem {
  String medName; String strength; String form; String sig; String route; String duration;
  PrescriptionItem({required this.medName, required this.strength, required this.form, required this.sig, required this.route, required this.duration});
}
class Patient {
  String fullName; String sex; String diagnosis; String regNo; DateTime date;
  Patient({required this.fullName, required this.sex, required this.diagnosis, required this.regNo, required this.date});
}
class Prescription {
  Patient patient;
  String doctorName; String doctorPhone;
  List<PrescriptionItem> items;
  Prescription({required this.patient, required this.doctorName, required this.doctorPhone, required this.items});
}
