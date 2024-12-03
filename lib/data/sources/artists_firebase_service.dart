import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:harmony/data/models/artist_model.dart';
import 'package:harmony/domain/entities/artist/artist.dart';

abstract class ArtistsFirebaseService {

  Future<Either> getAllArtists();

}

class ArtistsFirebaseServiceImplementation implements ArtistsFirebaseService {

  @override
  Future<Either> getAllArtists() async {
    
    try { 

        List<ArtistEntity> artists = [];
        
        var data = await FirebaseFirestore.instance.collection('Artists')
          .orderBy('name')
          .get();    

        for(var element in data.docs) {
          var artistModel = ArtistModel.fromJson(element.data());
          artists.add(artistModel.toEntity());
        }

        print(data);

        return Right(artists);

      } catch (e) {

    return Left('An error occured, try again');

    }

  }

}

  



