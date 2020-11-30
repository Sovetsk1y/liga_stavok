import 'package:equatable/equatable.dart';

class LiveEvent extends Equatable {
  final String statement;
  final LiveEventType type;

  LiveEvent(this.statement, this.type);

  @override
  List<Object> get props => [statement, type];

  @override
  String toString() => 'Live event: statement - $statement, iconResId - $type';
}

enum LiveEventType { goal, cornerKick, yellowCard, redCard, change }
