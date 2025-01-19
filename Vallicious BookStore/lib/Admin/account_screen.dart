import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<dynamic> accounts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAccounts();
  }

  // Mengambil data akun dari API
  Future<void> _fetchAccounts() async {
    final url = 'http://192.168.18.31/vallicious/get_accounts.php'; // URL API untuk mendapatkan akun
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          accounts = json.decode(response.body); // Parsing response JSON
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data akun'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan'), backgroundColor: Colors.red),
      );
    }
  }

  // Menghapus akun
  Future<void> _deleteAccount(int id) async {
    final url = 'http://192.168.18.31/vallicious/delete_account.php?id=$id'; // URL API untuk menghapus akun
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      if (data['message'] == 'Akun berhasil dihapus') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Akun berhasil dihapus'), backgroundColor: Colors.green),
        );
        // Memperbarui daftar akun setelah penghapusan
        _fetchAccounts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus akun'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan'), backgroundColor: Colors.red),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : accounts.isEmpty
          ? Center(child: Text('Tidak ada akun yang ditemukan'))
          : ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(account['username']),
              subtitle: Text('Role: ${account['role']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Konfirmasi penghapusan akun
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi Penghapusan'),
                        content: Text('Apakah Anda yakin ingin menghapus akun ini?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () {
                              // Convert account['id'] to integer before passing it to _deleteAccount
                              _deleteAccount(int.parse(account['id'])); // Menghapus akun berdasarkan id
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
