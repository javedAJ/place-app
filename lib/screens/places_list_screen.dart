// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:place_app/providers/great_places.dart';
import 'package:place_app/screens/add_place_screen.dart';
import 'package:place_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaces>(
                      builder: ((context, greatPlaces, ch) =>
                          // ignore: prefer_is_empty
                          greatPlaces.items.length <= 0
                              ? ch!
                              : ListView.builder(
                                  itemCount: greatPlaces.items.length,
                                  itemBuilder: (ctx, i) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                        greatPlaces.items[i].image,
                                      ),
                                    ),
                                    title: Text(greatPlaces.items[i].title),
                                    subtitle: Text(greatPlaces
                                        .items[i].location!.address as String),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          PlaceDetailScreen.routeName,
                                          arguments: greatPlaces.items[i].id);
                                    },
                                  ),
                                )),
                      child: Center(
                        child: Text(
                          'Got no Places yet , Start adding some!',
                        ),
                      ),
                    ),
        ));
  }
}
