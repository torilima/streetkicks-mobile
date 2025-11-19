import 'package:flutter/material.dart';
import 'package:street_kicks/product_entry.dart';
import 'package:street_kicks/widgets/left_drawer.dart';
import 'package:street_kicks/screens/product_detail.dart';
import 'package:street_kicks/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:street_kicks/screens/productlist_form.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  late Future<List<ProductEntry>> _productFuture; 
  
  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    _productFuture = fetchProducts(request);
  }

  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');
    
    var data = response;
    
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }
  
  void _refreshData() {
    setState(() {
      final request = context.read<CookieRequest>();
      _productFuture = fetchProducts(request);
    });
  }


  void _navigateToAddProduct() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductFormPage()),
    );

    if (shouldRefresh == true) {
      _refreshData();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddProduct, 
            tooltip: 'Add Product',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData, 
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: _productFuture, 
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFB0A99F)),
            );
          } else if (snapshot.hasError) {
             return Center(
               child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
             );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No products available in Street Kicks.',
                    style: TextStyle(fontSize: 20, color: Color(0xFF2C3E50)),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => ProductEntryCard(
                product: snapshot.data![index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        product: snapshot.data![index],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}