// ignore_for_file: await_only_futures

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony/data/models/song_model.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/domain/usecases/is_favourite.dart';
import 'package:harmony/service_locator.dart';

abstract class SongsFirebaseService {

  Future<Either> getNewSongs();

  Future<Either> createTopPicksBlock();

  Future<Either<String, List<SongEntity>>> getSongsByArtist(String artist);

  Future<Either<String, List<SongEntity>>> getSongsByGenre(String genre);

  Future<Either> addOrRemoveFavourites(String songId);

  Future <bool> isFavourite(String songId);

  Future<Either> getUserFavouriteSongs();

  Future<Either> getAllSongs();

  Future<Either<String, void>> deleteSong(String songId);

  //---

  Future<Either<String, List<SongEntity>>> searchSongs(String query);

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
          bool isFavourite = await serviceLocator<IsFavouriteUseCase>().call(params: element.reference.id);
          songModel.isFavourite = isFavourite;
          songModel.songId = element.reference.id;
          songs.add(songModel.toEntity());
        }

        return Right(songs);

      } catch (e) {

    return const Left('An error occured, try again');

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
          bool isFavourite = await serviceLocator<IsFavouriteUseCase>().call(params: element.reference.id);
          songModel.isFavourite = isFavourite;
          songModel.songId = element.reference.id;
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

    return const Left('An error occured, try again');

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
        bool isFavourite = await serviceLocator<IsFavouriteUseCase>().call(params: element.reference.id);
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id;
        genreSongs.add(songModel.toEntity());
      }

      return Right(genreSongs);
    } catch (e) {
      return const Left('An error occurred, try again');
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
        bool isFavourite = await serviceLocator<IsFavouriteUseCase>().call(params: element.reference.id);
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id;
        artistSongs.add(songModel.toEntity());
      }

      return Right(artistSongs);
    } catch (e) {
      return const Left('An error occurred, try again');
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
      return const Left('An Error Occured');
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
  
  @override
  Future < Either > getUserFavouriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSongs = [];
      String uId = user!.uid;
      QuerySnapshot favoritesSnapshot = await firebaseFirestore.collection(
        'Users'
      ).doc(uId)
      .collection('Favourites')
      .get();
      
      for (var element in favoritesSnapshot.docs) { 
        String songId = element['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavourite = true;
        songModel.songId = songId;
        favoriteSongs.add(
           songModel.toEntity()

        );
      }

      return Right(favoriteSongs);

    } catch (e) {
      print(e);
      return const Left(
        'An error occurred'
      );
    }
  }
  
  @override
  Future<Either> getAllSongs() async {
    
    try { 

        List<SongEntity> allSongs = [];
        
        var data = await FirebaseFirestore.instance.collection('Songs').get();    

        for(var element in data.docs) {
          var songModel = SongModel.fromJson(element.data());
          bool isFavourite = await serviceLocator<IsFavouriteUseCase>().call(params: element.reference.id);
          songModel.isFavourite = isFavourite;
          songModel.songId = element.reference.id;
          allSongs.add(songModel.toEntity());
        }

        return Right(allSongs);

      } catch (e) {

    return const Left('An error occured, try again');

    }

  }

  Future<Either<String, void>> deleteSong(String songId) async {
    try {
      
      await FirebaseFirestore.instance.collection('Songs').doc(songId).delete();

      return const Right(null); 

    } catch (e) {
      return Left('Failed to delete song: ${e.toString()}');
    }
  }

  Future<Either<String, List<SongEntity>>> searchSongs(String query) async {
    if (query.isEmpty) {
      return Right([]); 
    }

    try {
      List<SongEntity> searchResults = [];
      String lowerCaseQuery = query.toLowerCase();

      var allSongsData = await FirebaseFirestore.instance.collection('Songs').get();
      
      for (var element in allSongsData.docs) {
        var data = element.data();

         String songId = element.id;

        var songModel = SongModel.fromJson(data); 

        SongEntity songEntity = songModel.toEntity()..songId = songId;

        String title = songEntity.title.toLowerCase(); 
        String artist = songEntity.artist.toLowerCase();
        
        if (title.startsWith(lowerCaseQuery) || artist.startsWith(lowerCaseQuery)) {
          searchResults.add(songEntity);
        }
      }

      print('Total search results: ${searchResults.length}'); // Debugging line
      return Right(searchResults);
    } catch (e) {
      print('Error occurred: $e'); // Debugging line
      return const Left('An error occurred, try again');
    }
  }
  

}

  



