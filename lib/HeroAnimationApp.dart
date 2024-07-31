import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget page;
  final Duration duration;

  FadePageRoute({
    required this.page,
    this.duration = const Duration(milliseconds: 3000),
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: duration,
          reverseTransitionDuration: duration,
        );
}

class HeroAnimationApp extends StatelessWidget {
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
      backgroundColor: Colors.blue,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(FadePageRoute(
                page: SecondPage()
                // , duration: const Duration(seconds: 3)
            ));
          },
          child: Align(
            alignment: Alignment.topLeft,
            child: Hero(
              tag: 'hero-tag',
              child: CachedNetworkImage(
                imageUrl:
                    'https://2.img-dpreview.com/files/p/E~C1000x0S4000x4000T1200x1200~articles/3925134721/0266554465.jpeg',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      backgroundColor: Colors.yellow,
      body: Center(
        child: Hero(
          tag: 'hero-tag',
          child: CachedNetworkImage(
            imageUrl: 'https://via.placeholder.com/600x400.png?text=Large+Image',
            placeholder: (context, url) =>
                Container(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: 'https://2.img-dpreview.com/files/p/E~C1000x0S4000x4000T1200x1200~articles/3925134721/0266554465.jpeg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      )
    );
  }
}
