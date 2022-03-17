class Quantative {
  int? id;
  String? instituteName;
  String? universityName;
  String? courseName;
  String? courseDiscipline;
  String? graduationYearandMonth;
  String? certificationId;
  String? fileName;
  String? file;
  String? isActive;

  Quantative(
      {this.id,
        this.instituteName,
        this.universityName,
        this.courseName,
        this.courseDiscipline,
        this.graduationYearandMonth,
        this.certificationId,
        this.fileName,
        this.file,
        this.isActive});

  Quantative.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteName = json['instituteName'];
    universityName = json['universityName'];
    courseName = json['courseName'];
    courseDiscipline = json['courseDiscipline'];
    graduationYearandMonth = json['graduationYearandMonth'];
    certificationId = json['certificationId'];
    fileName = json['fileName'];
    file = json['file'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['instituteName'] = instituteName;
    data['universityName'] = universityName;
    data['courseName'] = courseName;
    data['courseDiscipline'] = courseDiscipline;
    data['graduationYearandMonth'] = graduationYearandMonth;
    data['certificationId'] = certificationId;
    data['fileName'] = fileName;
    data['file'] = file;
    data['is_active'] = isActive;
    return data;
  }
}