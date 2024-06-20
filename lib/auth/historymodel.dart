class Patienthistory {
  bool? admit;
  String? sId;
  String? patient;
  String? doctor;
  String? description;
  String? visitorName;
  String? visitorAge;
  String? visitorNumber;
  int? iV;

  Patienthistory(
      {this.admit,
      this.sId,
      this.patient,
      this.doctor,
      this.description,
      this.visitorName,
      this.visitorAge,
      this.visitorNumber,
      this.iV});

  Patienthistory.fromJson(Map<String, dynamic> json) {
    admit = json['admit'];
    sId = json['_id'];
    patient = json['patient'];
    doctor = json['doctor'];
    description = json['description'];
    visitorName = json['visitor_name'];
    visitorAge = json['visitor_age'];
    visitorNumber = json['visitor_number'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admit'] = this.admit;
    data['_id'] = this.sId;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    data['description'] = this.description;
    data['visitor_name'] = this.visitorName;
    data['visitor_age'] = this.visitorAge;
    data['visitor_number'] = this.visitorNumber;
    data['__v'] = this.iV;
    return data;
  }
}