import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../db/db_film.dart';
import '../model/film.dart';
import '../pages/film_edit_page.dart';
import '../pages/film_detail_page.dart';
import '../widget/film_card_widget.dart';

class FilmPage extends StatefulWidget {
  const FilmPage({super.key});

  @override
  State<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  late List<Film> film;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshFilm();
  }

  @override
  void dispose() {
    FilmDatabase.instance.close();

    super.dispose();
  }

  Future refreshFilm() async {
    setState(() => isLoading = true);

    film = await FilmDatabase.instance.readAllFilm();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'film',
        style: TextStyle(fontSize: 24),
      ),
      actions: const [Icon(Icons.search), SizedBox(width: 12)],
    ),
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : film.isEmpty
          ? const Text(
        'No film',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildFilm(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditFilmPage()),
        );

        refreshFilm();
      },
    ),
  );
  Widget buildFilm() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        film.length,
            (index) {
          final note = film[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FilmDetailPage(filmId: note.id!),
                ));

                refreshFilm();
              },
              child: FilmCardWidget(film: note, index: index),
            ),
          );
        },
      ));
}