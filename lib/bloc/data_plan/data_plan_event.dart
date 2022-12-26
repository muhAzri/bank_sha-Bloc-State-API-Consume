part of 'data_plan_bloc.dart';

abstract class DataPlanEvent extends Equatable {
  const DataPlanEvent();

  @override
  List<Object> get props => [];
}

class DataPlanPost extends DataPlanEvent {
  final DataPlanFormModel data;

  DataPlanPost(this.data);

  @override
  List<Object> get props => [data];
}
