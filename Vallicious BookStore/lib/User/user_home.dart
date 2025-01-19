import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_detail.dart';
import 'wishlist.dart';
import 'about.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<dynamic> products = [];
  int userId = 123;
  int _selectedIndex = 0;
  Set<int> wishlist = {};
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _fetchWishlist();
  }

  Future<void> _fetchWishlist() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.18.31/vallicious/get_wishlist.php?user_id=$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> wishlistData = json.decode(response.body);
        setState(() {
          wishlist = wishlistData
              .map((item) => int.parse(item['product_id'].toString()))
              .toSet();
        });
      }
    } catch (e) {
      print('Error fetching wishlist: $e');
    }
  }

  Future<void> _fetchProducts() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse('http://192.168.18.31/vallicious/get_products.php'));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat produk'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _toggleWishlist(dynamic productId) async {
    final int id = productId is String ? int.parse(productId) : productId;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.18.31/vallicious/toggle_wishlist.php'),
        body: {
          'user_id': userId.toString(),
          'product_id': id.toString(),
          'action': wishlist.contains(id) ? 'remove' : 'add',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          if (wishlist.contains(id)) {
            wishlist.remove(id);
          } else {
            wishlist.add(id);
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengubah status wishlist')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  List<dynamic> get filteredProducts {
    if (_searchQuery.isEmpty) return products;
    return products.where((product) =>
    product['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
        product['category'].toString().toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _selectedIndex == 0 ? _buildHomeAppBar() : AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[700],
        title: Text(
          _selectedIndex == 1 ? 'Wishlist' : 'About',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue[700],
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.store_rounded),
              label: 'Produk',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_rounded),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildHomeAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blue[700],
      title: Text(
        'Vallicious BookStore',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Icon(
              Icons.logout_rounded,
              size: 28,
              color: Colors.blue[700],
            ),
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_selectedIndex != 0) {
      return _selectedIndex == 1
          ? WishlistScreen(wishlist: wishlist, products: products)
          : AboutScreen();
    }

    return Column(
      children: [
        Container(
          color: Colors.blue[700],
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blue[700]!),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.blue[700]))
              : RefreshIndicator(
            onRefresh: _fetchProducts,
            color: Colors.blue[700],
            child: filteredProducts.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    _searchQuery.isEmpty
                        ? 'Belum ada produk'
                        : 'Produk tidak ditemukan',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (ctx, index) {
                final product = filteredProducts[index];
                final productId = product['id'] is String ?
                int.parse(product['id']) : product['id'];
                bool isInWishlist = wishlist.contains(productId);

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                            userId: userId,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.blue[100]!,
                                Colors.blue[50]!,
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: product['image_url'] != null && product['image_url'].isNotEmpty
                                    ? Image.network(
                                  product['image_url'],
                                  width: double.infinity,
                                  height: 140,
                                  fit: BoxFit.cover,
                                )
                                    : Icon(
                                  Icons.shopping_bag_rounded,
                                  size: 50,
                                  color: Colors.blue[700],
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      isInWishlist
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      color: isInWishlist ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () => _toggleWishlist(productId),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  product['category'],
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}