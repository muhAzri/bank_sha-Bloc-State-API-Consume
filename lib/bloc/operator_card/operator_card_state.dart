part of 'operator_card_bloc.dart';

abstract class OperatorCardState extends Equatable {
  const OperatorCardState();

  @override
  List<Object> get props => [];
}

class OperatorCardInitial extends OperatorCardState {}

class OperatorCardLoading extends OperatorCardState {}

class OperatorCardFailed extends OperatorCardState {
  final String e;

  OperatorCardFailed(this.e);

  @override
  List<Object> get props => [e];
}

class OperatorCardSucess extends OperatorCardState {
  final List<OperatorCardModel> operatorCards;

  OperatorCardSucess(this.operatorCards);

  @override
  List<Object> get props => [operatorCards];
}
