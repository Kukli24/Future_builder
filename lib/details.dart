import 'package:flutter/material.dart';
import 'models/data_model.dart';
//regex libreria

class LaunchDetailView extends StatelessWidget {
  final Launch lanzamiento;

  LaunchDetailView(this.lanzamiento);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Id: ${lanzamiento.id}'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue[900],
              child: Image.network(
                lanzamiento.imageLarge.toString(),
                height: 200,
                width: 200,
              ),
            ),
            Container(
              color: Colors.blue[900],
              height: 20,
            ),
            Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Detail: ${lanzamiento.details}\n\nSuccess: ${lanzamiento.success}\n\nDate: ${lanzamiento.date}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
