import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  void playWithUrl(String url) async {
    print("====> url $url");
    await advancedPlayer.play(url);
  }

  void playSoundLocal() async {
    audioCache = AudioCache();
    var a = await audioCache.play('sound/bell_5.mp3');
    print("====> this function call $a");
  }

  void stopSoundLocal() async {
    await audioCache.clearAll();
  }

  void stop() {
    advancedPlayer.pause();
  }
}
