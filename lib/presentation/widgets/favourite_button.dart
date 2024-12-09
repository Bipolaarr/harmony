
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/bloc/favourite_button_cubit.dart';
import 'package:harmony/presentation/bloc/favourite_button_state.dart';

class FavouriteButton extends StatelessWidget {
  final SongEntity song;
  final double size;

  const FavouriteButton({super.key, required this.song, required this.size});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteButtonCubit(),
      child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
        builder: (context, state) {
          bool isFavourite = song.isFavourite; // Default state

          // Check if the state is updated
          if (state is FavouriteButtonUpdated) {
            isFavourite = state.isFavourite; // Update based on new state
          }

          return IconButton(
            onPressed: () {
              context.read<FavouriteButtonCubit>().favouriteButtonUpdated(song.songId);
            },
            icon: Icon(
              isFavourite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: isFavourite ? Colors.white : Colors.grey,
              size: size,
            ),
          );
        },
      ),
    );
  }
}