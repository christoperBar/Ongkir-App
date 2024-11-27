import 'package:equatable/equatable.dart';


class Detailcost extends Equatable {
  final int? value;
  final String? etd;
  final String? note;

  const Detailcost({this.value, this.etd, this.note});

  factory Detailcost.fromJson(Map<String, dynamic> json) => Detailcost(
        value: json['value'] as int?,
        etd: json['etd'] as String?,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'etd': etd,
        'note': note,
      };

  @override
  List<Object?> get props => [value, etd, note];
}
