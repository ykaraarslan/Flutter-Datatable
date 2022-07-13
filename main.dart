import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Datatable'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key ?key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  late List<Users> users;
  late List<Users> selectedUsers;
  late List<Users> filter_users;
  late bool sort;

  @override
  void initState() {
    sort = false;
    selectedUsers = [];
    filter_users = Users.getUsers();
    users = Users.getUsers();
    onSortColum(0, sort);
    super.initState();
  }
  onSortColum(int columnIndex, bool ascending) {
    if (ascending) {
      users.sort((a, b) => a.name.compareTo(b.name));
    } else {
      users.sort((a, b) => b.name.compareTo(a.name));
    }

  }
  onSelectedRow(bool selected, Users user) async {
    setState(() {
      if (selected) {
        selectedUsers.add(user);
      } else {
        selectedUsers.remove(user);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<Users> temp = [];
        temp.addAll(selectedUsers);
        for (Users user in temp) {
          users.remove(user);
          selectedUsers.remove(user);
        }
      }
    });
  }
  SingleChildScrollView body() {
    return SingleChildScrollView(
    scrollDirection:Axis.vertical,
      child: Center(
        child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
            label: Text("Ad Soyad", style: TextStyle(fontSize: 11)),
            onSort: (columnIndex, ascending) {
            setState(() {
              sort = !sort;
              });
          onSortColum(columnIndex, ascending);
             }),
          DataColumn(
            label: Text("Doğum Tarihi", style: TextStyle(fontSize: 11)),
            ),
          DataColumn(
              label: Text("Maaş", style: TextStyle(fontSize: 11)),
          )],
            rows: filter_users
              .map(
              (user) => DataRow(
            selected: selectedUsers.contains(user),
            onSelectChanged: (b) {
            print("Onselect");
            onSelectedRow(b!, user);
             },
            cells: [
          DataCell(
             Text(user.name),
              onTap: () {
              print('Selected ${user.name}');
               },
              ),

          DataCell(
            Text(user.birth),
               ),
          DataCell(
            Text(user.salary),
          )
              ]),
             ).toList(),
            ),
          ),
        ),
    );
    }
    search(){
    return Padding(
        padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'isim ile arama yapın',
        ),
        onChanged: (string){

            setState(() {
              filter_users = users.where((u) => u.name.toLowerCase().contains(string)).toList();
            });



        },
      ),
    );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datatable"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          search(),
          Expanded(
            child: body(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlinedButton(
                  child: Text('SELECTED ${selectedUsers.length}'),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlinedButton(
                  child: Text('DELETE SELECTED'),
                  onPressed: selectedUsers.isEmpty
                      ? null
                      : () {
                    deleteSelected();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Users {
  String name;
  String birth;
  String salary;
  Users({required this.name, required this.birth,required this.salary});
  static List<Users> getUsers() {
    return <Users>[
      Users(name: "Yigitcan Karaarslan", birth: "24.06.2002",salary:"35.000 TL"),
      Users(name: "Erdi	Ozen", birth: "10.10.2001",salary:"20.000 TL"),
      Users(name: "Dogukan	Kazan", birth: "02.06.2002",salary:"30.000 TL"),
      Users(name: "Bugra Karlıoglu", birth: "04.08.1990",salary:"24.000 TL"),
      Users(name: "Harun	Ozkan", birth: "25.11.2000",salary:"21.000 TL"),
      Users(name: "Efe Karaoglanlar", birth: "24.06.1999",salary:"22.000 TL"),
      Users(name: "Kerem Kilicaslan", birth: "10.10.2004",salary:"33.000 TL"),
      Users(name: "Didem İlayda Yazman", birth: "07.06.2007",salary:"30.000 TL"),
      Users(name: "Yusuf Burak Kalkan", birth: "02.07.1994",salary:"19.000 TL"),
      Users(name: "Emirhan Firat", birth: "05.08.2010",salary:"28.000 TL"),
      Users(name: "Atakan Akbulut", birth: "25.12.2004",salary:"26.000 TL"),

    ];
  }
}