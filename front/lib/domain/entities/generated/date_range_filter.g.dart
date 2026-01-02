// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../date_range_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DateRangeFilter _$DateRangeFilterFromJson(Map<String, dynamic> json) =>
    _DateRangeFilter(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$DateRangeFilterToJson(_DateRangeFilter instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
