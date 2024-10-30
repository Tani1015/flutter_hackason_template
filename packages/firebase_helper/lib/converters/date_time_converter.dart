import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeTimestampNullableConverter
    implements JsonConverter<DateTime?, Timestamp?> {
  const DateTimeTimestampNullableConverter();

  @override
  DateTime? fromJson(Timestamp? value) => value?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

class DateTimeTimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeTimestampConverter();

  @override
  DateTime fromJson(Timestamp value) => value.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}
