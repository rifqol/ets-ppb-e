const String tableFilm = 'film';

class FilmFields {
  static final List<String> values = [
    id,
    isImportant,
    number,
    image,
    title,
    description,
    time
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String image = 'image';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Film {
  final int? id;
  final bool isImportant;
  final int number;
  final String image;
  final String title;
  final String description;
  final DateTime createdTime;

  const Film({
    this.id,
    required this.isImportant,
    required this.number,
    required this.image,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Film copy({
    int? id,
    bool? isImportant,
    int? number,
    String? image,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Film(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Film fromJson(Map<String, Object?> json) => Film(
    id: json[FilmFields.id] as int?,
    isImportant: json[FilmFields.isImportant] == 1,
    number: json[FilmFields.number] as int,
    image: json[FilmFields.image] as String,
    title: json[FilmFields.title] as String,
    description: json[FilmFields.description] as String,
    createdTime: DateTime.parse(json[FilmFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    FilmFields.id: id,
    FilmFields.title: title,
    FilmFields.isImportant: isImportant ? 1 : 0,
    FilmFields.number: number,
    FilmFields.image: image,
    FilmFields.description: description,
    FilmFields.time: createdTime.toIso8601String(),
  };
}