import 'package:flutter/material.dart';
import 'package:movies_app/database/my_dataBase.dart';
import 'package:movies_app/models/PopularResponse.dart';
import 'package:movies_app/screens/watchlist_screen/watchlist_screen.dart';

class PopularTabWidget extends StatefulWidget {
  Results results;
  bool pressed = false;
  PopularTabWidget(this.results);

  @override
  State<PopularTabWidget> createState() => _PopularTabWidgetState();
}

class _PopularTabWidgetState extends State<PopularTabWidget> {
  void initState() {
    if (WatchlistScreen.watchlist
        .any((element) => element.title == widget.results.title)) {
      widget.pressed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500' + '${widget.results.posterPath}',
            width: 100,
            height: 150,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      Positioned(
        right: 80,
        bottom: 105,
        child: IconButton(
          onPressed: () {
            setState(() {
              if (WatchlistScreen.watchlist
                  .any((element) => element.title == widget.results.title)) {
                MyDB.deletemovie(widget.results);
              } else {
                MyDB.insertMovie(widget.results);
              }
              widget.pressed = !widget.pressed;
              MyDB.getMovies();
            });
          },
          icon: Stack(
            children: [
              ImageIcon(
                AssetImage(widget.pressed
                    ? "assets/images/preseedbookmark.png"
                    : "assets/images/bookmark.png"),
                color: widget.pressed ? Colors.amber : Colors.grey,
                size: 60,
              ),
              Icon(
                widget.pressed ? Icons.check : Icons.add,
                color: Colors.white,
              )
            ],
          ),
        ),
      )
    ]);
  }
}
