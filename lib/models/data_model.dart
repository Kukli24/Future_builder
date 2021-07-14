class Launch {
  String? id, details, imageSmall, imageLarge;
  bool? success;
  DateTime? date;
  bool isExpanded = false;

  Launch.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.details = json['details'];
    this.success = json['success'];
    this.date = DateTime.fromMillisecondsSinceEpoch(json['date_unix'] * 1000);
    this.imageSmall = json['links']['patch']['small'];
    this.imageLarge = json['links']['patch']['large'];
    this.isExpanded = false;
  }
}
