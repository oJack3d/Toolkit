import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Soundboard extends StatefulWidget {
  @override
  _SoundboardState createState() => _SoundboardState();
}

class _SoundboardState extends State<Soundboard> {

  // Images List
  List<String> _Images = [
    'assets/images/test1.jpg',
    'assets/images/test1.png'
  ];

  // Sound List
  List<String> _Sounds = [
    'sounds/test1.mp3',
    'sounds/test2.mp3',
    'sounds/test3.mp3',
    'sounds/test4.mp3',
    'sounds/test5.mp3',
    'sounds/test6.mp3',
    'sounds/test7.mp3',
    'sounds/test8.mp3',
    'sounds/test9.mp3',
  ];

  // Audio Cache
  AudioCache audioCache;
  AudioPlayer audioPlayer;
  int indexIsPlaying;

  @override
  void initState() {
    super.initState();
    initSounds();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soundboard'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Soundboard: Drücke einen Knopf!'),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              child: Center(
                child: AnimatedContainer(
                  width: indexIsPlaying == index ? 120 : 80,
                  height: indexIsPlaying == index ? 120 : 80,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.bounceOut,
                  decoration: BoxDecoration(
                    color: indexIsPlaying == index
                        ? Colors.white
                        : Colors.yellow[500],
                    borderRadius: new BorderRadius.circular(100.0),
                    image: new DecorationImage(
                      image: new AssetImage(_Images[index % 2]),
                      fit: BoxFit.fill,
                    ),
                    border: new Border.all(
                        color: indexIsPlaying == index
                            ? Colors.green[400]
                            : Colors.transparent,
                        width: 2.0,
                        style: BorderStyle.solid),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: Offset(0, 10.0),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
              onTap: () {
                if (mounted) {
                  setState(() {
                    playSound(_Sounds[index]);
                    indexIsPlaying = index;
                  });
                }
              },
            ),
            padding: const EdgeInsets.all(20),
          ),
        ],
      ),
    );
  }

  void initSounds() async {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioCache.loadAll(_Sounds);
  }

  void playSound(sound) async {
    var fileName = sound;
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      audioPlayer.stop();
    }
    audioPlayer = await audioCache.play(fileName);
    print(sound);
  }

  void stopSound(sound) {
    audioPlayer.stop();
  }
}