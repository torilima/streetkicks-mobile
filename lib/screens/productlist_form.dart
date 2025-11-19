import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:street_kicks/screens/product_list_entry.dart';
import 'package:street_kicks/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:street_kicks/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    // ignore: unused_field
    int? _price;
    String _description = "";
    String _category = "Shoes"; // default
    String _thumbnail = "";
    bool _isFeatured = false; // default

    final List<String> _categories = [
      'Shoes',
      'Jersey',
      'Accessories',
      'Ball',
    ];

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Add Product Form',
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 6, 0, 87),
          foregroundColor: const Color.fromARGB(255, 255, 238, 0),
        ),
        drawer: const LeftDrawer(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Title ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Product Name",
                      labelText: "Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Product name cannot be empty!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Product Description",
                      labelText: "Product Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Product Description cannot be empty!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      hintText: "Enter price ",
                      labelText: "Price",
                      prefixText: "Rp ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _price = int.tryParse(value);
                      });
                    },
                    validator: (String? value) {
                      // Validator Anda sudah benar
                      if (value == null || value.isEmpty) {
                        return "Price cannot be empty!";
                      }
                      
                      final price = int.tryParse(value);
                      if (price == null) {
                        return "Please enter a valid number";
                      }
                      
                      if (price <= 0) {
                        return "Price must be greater than 0";
                      }
                      
                      return null;
                    },
                  ),
                ),
                // === Category ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    initialValue: _category,
                    items: _categories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(
                                  cat[0].toUpperCase() + cat.substring(1)),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue!;
                      });
                    },
                  ),
                ),

                // === Thumbnail URL ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "URL Thumbnail (opsional)",
                      labelText: "URL Thumbnail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnail = value!;
                      });
                    },
                  ),
                ),

                // === Is Featured ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitchListTile(
                    title: const Text("Mark as Featured"),
                    value: _isFeatured,
                    onChanged: (bool value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color.fromARGB(255, 0, 14, 90)),
                      ),
                      onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Replace the URL with your app's URL
                            // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
                            // If you using chrome,  use URL http://localhost:8000
                            
                            final response = await request.postJson(
                              "http://localhost:8000/create-flutter/",
                              jsonEncode({
                                "name": _name,
                                "price": _price,
                                "stok": 0,
                                "description": _description,
                                "thumbnail": _thumbnail,
                                "category": _category,
                                "is_featured": _isFeatured,
                              }),
                            );
                            if (context.mounted) {
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Product successfully saved!"),
                                ));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductEntryListPage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Something went wrong, please try again."),
                                ));
                              }
                            }
                          }
                        },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
}