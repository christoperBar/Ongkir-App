import 'package:equatable/equatable.dart';
import 'detailcost.dart';
class Cost extends Equatable {
  final String? service;
  final String? description;
  final List<Detailcost>? cost;

  const Cost({this.service, this.description, this.cost});

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        service: json['service'] as String?,
        description: json['description'] as String?,
        cost: (json['cost'] as List<dynamic>?)
            ?.map((e) => Detailcost.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'service': service,
        'description': description,
        'cost': cost?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [service, description, cost];
}
