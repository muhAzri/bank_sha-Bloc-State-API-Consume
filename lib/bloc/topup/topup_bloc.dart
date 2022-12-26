import 'package:bank_sha/models/top_up_form_model.dart';
import 'package:bank_sha/services/transaction_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'topup_event.dart';
part 'topup_state.dart';

class TopupBloc extends Bloc<TopupEvent, TopupState> {
  TopupBloc() : super(TopupInitial()) {
    on<TopupEvent>((event, emit) async {
      if (event is TopupPost) {
        try {
          emit(
            TopupLoading(),
          );

          final redirectUrl = await TransactionService().topUp(event.data);

          emit(TopupSuccess(redirectUrl));
        } catch (e) {
          emit(TopUpFailed(e.toString()));
        }
      }
    });
  }
}
