import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:street_kicks/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int? _price;
  String _description = "";
  String _category = "Shoes";
  String _thumbnail = "";
  bool _isFeatured = false;

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
        title: const Text(
          'Add Product Form',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 0, 87),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  onChanged: (v) => setState(() => _name = v ?? ""),
                  validator: (v) => v == null || v.isEmpty ? "Required" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Product Description",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  onChanged: (v) => setState(() => _description = v ?? ""),
                  validator: (v) => v == null || v.isEmpty ? "Required" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: "Price",
                    prefixText: "Rp ",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  onChanged: (v) => setState(() => _price = int.tryParse(v)),
                  validator: (v) =>
                      v == null || v.isEmpty ? "Required" : int.tryParse(v) == null ? "Invalid number" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  value: _category,
                  items: _categories
                      .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Thumbnail URL",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  onChanged: (v) => setState(() => _thumbnail = v ?? ""),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SwitchListTile(
                  title: const Text("Mark as Featured"),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 6, 0, 87)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
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
                          Navigator.pop(context, true);
                        }
                      }
                    }
                  },
                  child: const Text("Save", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
