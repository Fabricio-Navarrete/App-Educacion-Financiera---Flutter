import 'package:app_educacion_financiera/app/utils/card.dart';
import 'package:app_educacion_financiera/app/utils/tema_color.dart';
import 'package:app_educacion_financiera/config/Models/contenido_lecciones.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ContentCarousel extends StatefulWidget {
  final Future<List<ContenidoLecciones>> cardData;

  const ContentCarousel({Key? key, required this.cardData}) : super(key: key);

  @override
  _ContentCarouselState createState() => _ContentCarouselState();
}

class _ContentCarouselState extends State<ContentCarousel> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ContenidoLecciones>>(
      future: widget.cardData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No hay datos disponibles');
        } else {
          final cardData = snapshot.data!;
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 15),
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: cardData.length,
                  itemBuilder: (context, index, realIndex) {
                    final card = cardData[index];
                    return ContentCard(
                      title: card.titleCard,
                      content: card.content,
                      cardColor: TemaColor.getColorFromHex(card.cardColor),
                      iconPath: card.icon,
                    );
                  },
                  options: CarouselOptions(
                    height: 500,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: _currentIndex > 0
                          ? () {
                              _carouselController.previousPage();
                            }
                          : null,
                    ),
                    Text('${_currentIndex + 1}/${cardData.length}'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: _currentIndex < cardData.length - 1
                          ? () {
                              _carouselController.nextPage();
                            }
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Aquí puedes agregar tu botón adicional si lo necesitas
              ],
            ),
          );
        }
      },
    );
  }
}