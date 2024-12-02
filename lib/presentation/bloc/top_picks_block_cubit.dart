import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/usecases/create_top_picks_block.dart';
import 'package:harmony/presentation/bloc/top_pick_blocks_state.dart';
import 'package:harmony/service_locator.dart';

class TopPicksBlockCubit extends Cubit<TopPickBlocksState> {

  TopPicksBlockCubit() : super(TopPicksBlockLoading()); 

  Future<void> buildTopPicksBlock() async {
    var pickedSongs = await serviceLocator<CreateTopPicksBlock>().call();

    pickedSongs.fold(
      (error) {
        emit(TopPicksBlockFailed()); 
      },
      (data) {
        emit(TopPicksBlockLoaded(pickedSongs: data)); 
      },
    );
  }
}