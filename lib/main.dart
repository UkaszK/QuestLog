import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const QuestLogApp());
}

class QuestLogApp extends StatefulWidget {
  const QuestLogApp({super.key});

  @override
  State<QuestLogApp> createState() => _QuestLogAppState();
}

class _QuestLogAppState extends State<QuestLogApp> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(
      child: Text(
        'QuestLog',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Assembler',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Analytics',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Settings',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuestLog',
      home: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'LOG'),
            BottomNavigationBarItem(
              icon: _ThemedSvgIcon('assets/icons/assembler.svg'),
              label: 'ASSEMBLER',
            ),
            BottomNavigationBarItem(
              icon: _ThemedSvgIcon('assets/icons/analytics.svg'),
              label: 'ANALYTICS',
            ),
            BottomNavigationBarItem(
              icon: _ThemedSvgIcon('assets/icons/settings.svg'),
              label: 'SETTINGS',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFe6fcfe),
          unselectedItemColor: Color(0xFF879495),
          selectedLabelStyle: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor: Color(0xFF131313),
        ),
      ),
    );
  }
}

class _ThemedSvgIcon extends StatelessWidget {
  final String assetPath;

  const _ThemedSvgIcon(this.assetPath);

  @override
  Widget build(BuildContext context) {
    final color = IconTheme.of(context).color ?? Colors.black;
    return SvgPicture.asset(
      assetPath,
      width: 20,
      height: 20,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
