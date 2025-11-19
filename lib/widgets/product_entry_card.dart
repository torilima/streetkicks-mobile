import 'package:flutter/material.dart';
import 'package:street_kicks/product_entry.dart';

class ProductEntryCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Sedikit lebih bulat
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. THUMBNAIL ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    // Pastikan URL localhost benar (gunakan 10.0.2.2 untuk Android Emulator)
                    'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // --- 2. JUDUL & HARGA ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Tampilan Price
                    Text(
                      "Rp ${product.price}", // Pastikan field price ada di model
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Warna hijau untuk harga
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // --- 3. CATEGORY & STOCK ---
                Row(
                  children: [
                    // Tampilan Category ala "Dropdown" / Chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50, // Background agak biru muda
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.category, size: 14, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(
                            product.category, // Pastikan field category ada di model
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Tampilan Stock
                    Row(
                      children: [
                        const Icon(Icons.inventory_2_outlined, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Stok: ${product.stok}', // Pastikan field stock ada di model
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),
                const Divider(), // Garis pemisah tipis
                const SizedBox(height: 6),

                // --- 4. DESCRIPTION ---
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),

                // --- 5. FEATURED INDICATOR ---
                if (product.isFeatured)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '⭐ Featured Product',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}