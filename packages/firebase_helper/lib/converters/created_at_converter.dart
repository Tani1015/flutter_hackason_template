import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class CreatedAtConverter implements JsonConverter<DateTime?, dynamic> {
  const CreatedAtConverter();

  @override
  DateTime? fromJson(dynamic value) =>
      value is Timestamp ? value.toDate() : null;

  @override
  dynamic toJson(DateTime? object) => object == null
      ? FieldValue.serverTimestamp()
      : Timestamp.fromDate(object);
}

class UpdatedAtConverter implements JsonConverter<DateTime?, dynamic> {
  const UpdatedAtConverter();

  @override
  DateTime? fromJson(dynamic value) =>
      value is Timestamp ? value.toDate() : null;

  @override
  dynamic toJson(DateTime? _) => FieldValue.serverTimestamp();
}
