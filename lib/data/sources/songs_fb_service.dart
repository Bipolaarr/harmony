import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony/data/models/song_model.dart';
import 'package:harmony/domain/entities/song/song.dart';

abstract class SongsFirebaseService {

  Future<Either> getNewSongs();

  Future<Either> createTopPicksBlock();

  Future<Either<String, List<SongEntity>>> getSongsByArtist(String artist);

  Future<Either<String, List<SongEntity>>> getSongsByGenre(String genre);

  Future<Either> addOrRemoveFavourites(String songId);

  Future <bool> isFavourite(String songId);

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
        List<List<SongEntity>> pickedSongs = [];
        
        var data = await FirebaseFirestore.instance.collection('Songs').get();    

        for(var element in data.docs) {
          var songModel = SongModel.fromJson(element.data());
          allSongs.add(songModel.toEntity());
        }

        var random = Random();

        for (int i = 0; i < 5; i++) {
          
          allSongs.shuffle(random);
          List<SongEntity> buff = allSongs.take(10).toList();
          pickedSongs.add(buff);

        }

        return Right(pickedSongs);

      } catch (e) {

    return Left('An error occured, try again');

    } 

  }
  
  @override
  Future<Either<String, List<SongEntity>>> getSongsByGenre(String genre) async {
    try {
      List<SongEntity> genreSongs = [];
      var data = await FirebaseFirestore.instance.collection('Songs')
          .where('genre', isEqualTo: genre)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        genreSongs.add(songModel.toEntity());
      }

      return Right(genreSongs);
    } catch (e) {
      return Left('An error occurred, try again');
    }
  }
  
   @override
  Future<Either<String, List<SongEntity>>> getSongsByArtist(String artist) async {
    try {
      List<SongEntity> artistSongs = [];
      var data = await FirebaseFirestore.instance.collection('Songs')
          .where('artist', isEqualTo: artist)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        artistSongs.add(songModel.toEntity());
      }

      return Right(artistSongs);
    } catch (e) {
      return Left('An error occurred, try again');
    }
  }
  
  @override
  Future<Either> addOrRemoveFavourites(String songId) async {

    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavourite;

      var user = await firebaseAuth.currentUser;
      String uid = user!.uid;
      
      QuerySnapshot favouriteSongs = await firebaseFirestore.collection('Users').doc(uid).collection('Favourites').where(
        'songId', isEqualTo: songId
      ).get();
      
      if(favouriteSongs.docs.isNotEmpty) {
        await favouriteSongs.docs.first.reference.delete();
        isFavourite = false;
      } else {
      
        firebaseFirestore.collection('Users')
        .doc(uid)
        .collection('Favourites')
        .add(
          {
            'songId':songId,
            'addedDate':Timestamp.now()
          }
        );
        isFavourite = true;
      }

    return Right(isFavourite);

    } on Exception {
      return Left('An Error Occured');
    }

  }
  
  @override
  Future<bool> isFavourite(String songId) async {
    try {

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseAuth.currentUser;
      String uid = user!.uid;
      
      QuerySnapshot favouriteSongs = await firebaseFirestore.collection('Users').doc(uid).collection('Favourites').where(
        'songId', isEqualTo: songId
      ).get();
      
      if(favouriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false; 
      }

    } on Exception {
      return false;
    }

  }

}

  



