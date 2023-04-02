import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerCare {
  int? rating;
  String? comment;
  String? report;

  CustomerCare({this.rating, this.comment, this.report});

  factory CustomerCare.fromJson(Map<dynamic, dynamic> json) {
    return CustomerCare(
        rating: json['rating'],
        comment: json['comment'],
        report: json['report']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'rating': rating,
      'comment': comment,
      'report': report
    };
  }

  factory CustomerCare.fromSnapshots(DocumentSnapshot snapshot) {
    final custoemrCare =
        CustomerCare.fromJson(snapshot.data() as Map<String, dynamic>);
    return custoemrCare;
  }
}
