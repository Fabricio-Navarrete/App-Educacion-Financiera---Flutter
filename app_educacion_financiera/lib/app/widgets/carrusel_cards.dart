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
  // ignore: library_private_types_in_public_api
  _ContentCarouselState createState() => _ContentCarouselState();
}

class _ContentCarouselState extends State<ContentCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ContenidoLecciones>>(
      future: widget.cardData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
        } else {
          final cardData = snapshot.data!;
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 15),
                CarouselSlider.builder(
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
                //agregar boton
                
              ],
            ),
          );
        }
      },
    );
  }

  final CarouselController _carouselController = CarouselController();
}
