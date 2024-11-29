import 'package:dartz/dartz.dart';
import 'package:harmony/data/sources/artists_firebase_service.dart';
import 'package:harmony/domain/repositories/artist/artist.dart';
import 'package:harmony/service_locator.dart';

class ArtistsRepostioryImplementation extends ArtistsRepository{
  
  @override
  Future<Either> getAllArtists() async {
    
    return await serviceLocator<ArtistsFirebaseService>().getAllArtists();

  }



}