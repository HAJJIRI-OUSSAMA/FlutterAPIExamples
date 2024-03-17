import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blueGrey[600],
        child: ListView(
          children: [
            drawerHeader(),
            itemMenu(
              title: "Unsplash",
              icon: Icons.image,
              iconColor: Colors.deepOrange,
              goto: () {
                Navigator.of(context).popAndPushNamed("Unsplash");
              },
            ),
            itemMenu(
              title: "News",
              icon: Icons.account_balance,
              iconColor: Colors.green,
              goto: () {
                Navigator.of(context).popAndPushNamed("News");
              },
            ),
            itemMenu(
              title: "Day Calculator",
              icon: Icons.calendar_today,
              iconColor: Colors.white,
              goto: () {
                Navigator.of(context).popAndPushNamed("DayCalculator");
              },
            ),
          ],
        ),
      ),
    );
  }

  // Drawer header

  DrawerHeader drawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black54!,Colors.teal[800]! ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Developed By',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'AAZZAOUI & HAJJIRI',
            style: TextStyle(
              fontSize: 24,
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


  Container itemMenu({
    required String title,
    required IconData icon,
    required Color iconColor,
    VoidCallback? goto,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Icon(
          icon,
          size: 24,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        onTap: goto,
      ),
    );
  }
}
