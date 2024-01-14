import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController _favoriteController = TextEditingController();
  List<String> favorites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Favoris'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _favoriteController,
              decoration: InputDecoration(
                labelText: 'Nom du favori',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String favoriteName = _favoriteController.text;
                if (favoriteName.isNotEmpty) {
                  setState(() {
                    favorites.add(favoriteName);
                    _favoriteController.clear();
                  });
                }
              },
              child: Text('Ajouter aux favoris'),
            ),
            SizedBox(height: 16),
            Text(
              'Favoris:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(favorites[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
