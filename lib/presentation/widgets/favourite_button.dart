
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/bloc/favourite_button_cubit.dart';
import 'package:harmony/presentation/bloc/favourite_button_state.dart';

class FavouriteButton extends StatelessWidget {
  final SongEntity song;
  final Function ? function;
  final double ? size;
  const FavouriteButton({
    required this.song,
    this.function,
    this.size,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteButtonCubit(),
      child: BlocBuilder<FavouriteButtonCubit,FavouriteButtonState>(
        builder: (context, state) {
          if(state is FavouriteButtonInitial) {
            return IconButton(
              onPressed: () async {
                await context.read<FavouriteButtonCubit>().favouriteButtonUpdated(
                  song.songId
                );
                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                song.isFavourite ? Icons.favorite : Icons.favorite_outline_outlined,
                size: size,
                color: song.isFavourite ? Colors.white : Colors.grey,
              )
            );
          }

          if(state is FavouriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                 context.read<FavouriteButtonCubit>().favouriteButtonUpdated(
                  song.songId
                );
              },
              icon: Icon(
                state.isFavourite ? Icons.favorite : Icons.favorite_outline_outlined,
                size: size,
                color: state.isFavourite ? Colors.white : Colors.grey,
              )
            );
          }

          return Container();

        },
      ),
    );
  }
}