import 'package:flutter/material.dart';

class DraggableHeroAnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );
          },
          child: Hero(
            tag: 'hero-tag',
            child: Image.network(
              'https://via.placeholder.com/300x300.png?text=First+Image',
              width: 300,
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  double _dragStartY = 0.0;
  double _dragCurrentY = 0.0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: GestureDetector(
        onVerticalDragStart: (details) {
          _dragStartY = details.globalPosition.dy;
          setState(() {
            _isDragging = true;
          });
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            _dragCurrentY = details.globalPosition.dy;
          });
        },
        onVerticalDragEnd: (details) {
          if ((_dragCurrentY - _dragStartY) > 100) {
            Navigator.of(context).pop();
          } else {
            setState(() {
              _isDragging = false;
              _dragCurrentY = 0;
            });
          }
        },
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: 'hero-tag',
                child: Image.network(
                  'https://via.placeholder.com/300x300.png?text=Second+Image',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            if (_isDragging)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
            if (_isDragging)
              Positioned(
                top: _dragCurrentY - _dragStartY,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: 1 -
                      ((_dragCurrentY - _dragStartY) /
                          MediaQuery.of(context).size.height),
                  child: Hero(
                    tag: 'hero-tag',
                    child: Image.network(
                      'https://via.placeholder.com/300x300.png?text=Second+Image',
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
