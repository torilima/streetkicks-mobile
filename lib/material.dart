import 'package:flutter/material.dart';
import 'package:street_kicks/menu.dart';
import 'package:street_kicks/newlist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 110, 0, 0),
            ),
            child: Column(
              children: [
                Text(
                  'StreetKicks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 238, 0),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("All Football Products!", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white)
                    ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductFormPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}