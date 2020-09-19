import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class MyCHomePage extends StatefulWidget {
  final String title;

  MyCHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyCHomePageState createState() => _MyCHomePageState();
}

class _MyCHomePageState extends State<MyCHomePage> {
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  final List<String> letters = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
  ];

  bool _isPlaying = false;
  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("vinod"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 500,
            child: CarouselSlider.builder(
                key: _sliderKey,
                unlimitedMode: true,
                slideBuilder: (index) {
                  return Container(
                    alignment: Alignment.center,
                    color: colors[index],
                    child: Text(
                      letters[index],
                      style: TextStyle(fontSize: 200, color: Colors.white),
                    ),
                  );
                },
                slideTransform: CubeTransform(),
                slideIndicator: CircularSlideIndicator(
                  padding: EdgeInsets.only(bottom: 32),
                ),
                itemCount: colors.length),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Align(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 240, maxWidth: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: 48,
                      icon: Icon(Icons.skip_previous),
                      onPressed: () {
                        _sliderKey.currentState.previousPage();
                      },
                    ),
                    IconButton(
                      iconSize: 64,
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                      ),
                      onPressed: () {
                        setState(
                              () {
                            _isPlaying = !_isPlaying;
                            _sliderKey.currentState.setPlaying(_isPlaying);
                          },
                        );
                      },
                    ),
                    IconButton(
                      iconSize: 48,
                      icon: Icon(Icons.skip_next),
                      onPressed: () {
                        _sliderKey.currentState.nextPage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

