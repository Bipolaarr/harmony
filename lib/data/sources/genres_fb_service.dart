import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:harmony/data/models/genre_model.dart';
import 'package:harmony/domain/entities/genre/genre.dart';

abstract class GenresFirebaseService {

  Future<Either> getAllGenres();

}

class GenresFirebaseServiceImplementation implements GenresFirebaseService {

  @override
  Future<Either> getAllGenres() async {
    
    try { 

        List<GenreEntity> genres = [];
        
        var data = await FirebaseFirestore.instance.collection('Genres')
          .orderBy('name')
          .get();    

        for(var element in data.docs) {
          var genreModel = GenreModel.fromJson(element.data());
          genres.add(genreModel.toEntity());
        }

        return Right(genres);

      } catch (e) {
    
    return const Left('An error occured, try again');

    }

  }

}

  



