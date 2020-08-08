import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

AnimationController _animationIconController1;
AudioCache audioCache;
AudioPlayer audioPlayer;
Duration _duration = new Duration();
Duration _position = new Duration();
Duration _slider = new Duration(seconds: 0);
double durationvalue;
bool issongplaying = false;

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
  }

  void initState() {
    super.initState();
    _position = _slider;
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    audioPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100.withOpacity(0.55),
          image: DecorationImage(
            image: AssetImage("assets/images/color1.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: Image(
                        image: AssetImage("assets/images/color1.jpg"),
                        width: (MediaQuery.of(context).size.width) - 200,
                        height: (MediaQuery.of(context).size.width) - 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      value: _position.inSeconds.toDouble(),
                      max: _duration.inSeconds.toDouble() + 2,
                      onChanged: (double value) {
                        setState(() {
                          seekToSecond(value.toInt());
                          value = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.navigate_before,
                          size: 55,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                if (!issongplaying) {
                                  
                                  audioCache.play("music/music1.mp3");
                                } else {
                                  audioPlayer.pause();
                                }
                                issongplaying
                                    ? _animationIconController1.reverse()
                                    : _animationIconController1.forward();
                                issongplaying = !issongplaying;
                              },
                            );
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.pink[600],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  size: 55,
                                  progress: _animationIconController1,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 55,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
