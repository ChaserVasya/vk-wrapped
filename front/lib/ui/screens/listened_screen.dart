import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/ui/screens/listened/albums_page.dart';
import 'package:front/ui/screens/listened/artists_page.dart';
import 'package:front/ui/screens/listened/genres_page.dart';
import 'package:front/ui/screens/listened/songs_page.dart';

@RoutePage()
class ListenedScreen extends StatelessWidget {
  const ListenedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Прослушанное'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const ListenedCarousel(),
    );
  }
}

class ListenedCarousel extends StatefulWidget {
  const ListenedCarousel({super.key});

  @override
  State<ListenedCarousel> createState() => _ListenedCarouselState();
}

class _ListenedCarouselState extends State<ListenedCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              const ArtistsPage(),
              const AlbumsPage(),
              const SongsPage(),
              const GenresPage(),
            ],
          ),
        ),
        _PageIndicator(currentPage: _currentPage, totalPages: 4),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _PageIndicator({required this.currentPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == index ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
