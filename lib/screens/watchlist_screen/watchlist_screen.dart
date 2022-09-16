import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/database/my_dataBase.dart';
import 'package:movies_app/models/PopularResponse.dart';
import 'package:movies_app/screens/watchlist_screen/watchlist_widget.dart';

class WatchlistScreen extends StatelessWidget {
  static List<Results> watchlist = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Text(
              'Watchlist',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Results>>(
            stream: MyDB.listenforrealtimeUpdates(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(
                      "error Loading data",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Try Again",
                          style: Theme.of(context).textTheme.titleMedium,
                        ))
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var data = snapshot.data!.docs.map((e) => e.data()).toList();

                return ListView.builder(
                  itemBuilder: (context, index) {
                    watchlist.add(data[index]);
                    return WatchlistWidget(
                      results: data[index],
                    );
                  },
                  itemCount: data.length,
                );
              }
            }),
          ))
        ],
      ),
    );
  }
}
