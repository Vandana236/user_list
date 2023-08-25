import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  int currentPage = 1;
  int totalPages = 1;
  List<User> users = [];

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$currentPage'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      currentPage = data['page'];
      totalPages = data['total_pages'];

      final List<dynamic> userItems = data['data'];
      setState(() {
        users = userItems.map((userJson) => User.fromJson(userJson)).toList();
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: users.isNotEmpty?
      ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(users[index].avatar),
            ),
            title: Text('${users[index].firstName} ${users[index].lastName}'),
            subtitle: Text(users[index].email),
          );
        },
      ):Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: currentPage > 1
                ? () {
              setState(() {
                currentPage--;
              });
              fetchUsers();
            }
                : null,
            child: Icon(Icons.chevron_left),
            tooltip: 'Previous Page',
            heroTag: null,
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: currentPage < totalPages
                ? () {
              setState(() {
                currentPage++;
              });
              fetchUsers();
            }
                : null,
            child: Icon(Icons.chevron_right),
            tooltip: 'Next Page',
            heroTag: null,
          ),
        ],
      ),
    );
  }
}




