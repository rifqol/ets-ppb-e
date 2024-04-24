import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_film.dart';
import '../model/film.dart';
import '../pages/film_edit_page.dart';

class FilmDetailPage extends StatefulWidget {
  final int filmId;

  const FilmDetailPage({
    Key? key,
    required this.filmId,
  }) : super(key: key);

  @override
  State<FilmDetailPage> createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage> {
  late Film film;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshFilm();
  }

  Future refreshFilm() async {
    setState(() => isLoading = true);

    film = await FilmDatabase.instance.readFilm(widget.filmId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Image.network("https://th.bing.com/th/id/OIP.nzs6AtV0nccgvaj8WOVZGwHaJQ?rs=1&pid=ImgDetMain"), //image masih harus di debug,
          Text(
            film.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(film.createdTime),
            style: const TextStyle(color: Colors.white38),
          ),
          const SizedBox(height: 8),
          Text(
            film.description,
            style:
            const TextStyle(color: Colors.white70, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditFilmPage(film: film),
        ));

        refreshFilm();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await FilmDatabase.instance.delete(widget.filmId);

      Navigator.of(context).pop();
    },
  );
}