import 'package:flutter/material.dart';
import 'package:street_kicks/screens/menu.dart';
import 'package:street_kicks/screens/productlist_form.dart';
import 'package:street_kicks/screens/product_list_entry.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 151, 0, 0),
            ),
            child: Column(
              children: [
                Text(
                  'Street Kicks',
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
            // Bagian redirection ke ProductFormPage
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductFormPage()),
                );
              // /*
              // TODO: Buatlah routing ke ProductFormPage di sini,
              // setelah halaman ProductFormPage sudah dibuat.
              // */
            },
          ),
          ListTile(
              leading: const Icon(Icons.add_reaction_rounded),
              title: const Text('Products List'),
              onTap: () {
                  // Route to news list page
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
                  );
              },
          ),
        ],
      ),
    );
  }
}