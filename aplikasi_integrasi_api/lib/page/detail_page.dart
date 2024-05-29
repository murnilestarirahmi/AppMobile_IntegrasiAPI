import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final int userId;

  const DetailPage({Key? key, required this.userId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> user = {};

  @override
  void initState() {
    super.initState();
    fetchUserDetail();
  }

  Future<void> fetchUserDetail() async {
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users/${widget.userId}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        user = data['data'];
      });
    } else {
      throw Exception('Failed to load user detail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengguna'),
      ),
      body: user.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          user['avatar'],
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        '${user['first_name']} ${user['last_name']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(
                      color: Colors.grey[800],
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ID',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            ': ${user['id']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Email',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            ': ${user['email']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'First Name',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            ': ${user['first_name']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Last Name',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            ': ${user['last_name']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
