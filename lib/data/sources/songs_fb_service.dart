import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:harmony/data/models/song_model.dart';
import 'package:harmony/domain/entities/song/song.dart';

abstract class SongsFirebaseService {

  Future<Either> getNewSongs();

  Future<Either> createTopPicksBlock();
}

class SongsFirebaseServiceImplementation implements SongsFirebaseService {

    @override
    Future<Either> getNewSongs() async {

      try { 

        List<SongEntity> songs = [];
        
        var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(5).get();    

        for(var element in data.docs) {
          var songModel = SongModel.fromJson(element.data());
          songs.add(songModel.toEntity());
        }

        return Right(songs);

      } catch (e) {

    return Left('An error occured, try again');

    } 

  }
  
  @override
  Future<Either> createTopPicksBlock() async {
    
    try { 

      

        List<SongEntity> allSongs = [];
        
        var data = await FirebaseFirestore.instance.collection('Songs').get();    

        for(var element in data.docs) {
          var songModel = SongModel.fromJson(element.data());
          allSongs.add(songModel.toEntity());
        }

        var random = Random();
        allSongs.shuffle(random);

        List<SongEntity> pickedSongs = allSongs.take(10).toList();

        return Right(pickedSongs);

      } catch (e) {

    return Left('An error occured, try again');

    } 

  }

}

  



