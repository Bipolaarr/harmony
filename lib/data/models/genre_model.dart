
import 'package:harmony/domain/entities/genre/genre.dart';

class GenreModel { 

  String ? name;
  String ? about;

  GenreModel ({
    required this.name
  });

    GenreModel.fromJson(Map<String,dynamic> data) {

    name = data['name'];
    about = data['about'];

  }

}

extension ArtistModelX on GenreModel {
  GenreEntity toEntity() {
    return GenreEntity(
      name: name!,
      about: about!
      );
  }
}