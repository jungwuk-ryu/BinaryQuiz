import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

enum GameSound {correct, incorrect}

class GameSoundService extends GetxService {
  final Soundpool _pool = Soundpool(streamType: StreamType.notification);
  int? _streamId;
  Map<GameSound, int> soundIdMap = {};

  @override
  void onInit() {
    super.onInit();
    _loadSounds();
  }

  Future<void> playGameSound(GameSound sound) async {
    int? soundId = _getSoundId(sound);
    if (soundId == null) return;

    await _playSound(soundId);
  }

  int? _getSoundId(GameSound sound) {
    return soundIdMap[sound];
  }

  Future<void> _loadSounds() async {
    Future<int> icf = _loadSound("sounds/incorrect.mp3");
    Future<int> cf = _loadSound("sounds/correct.mp3");

    soundIdMap[GameSound.incorrect] = await icf;
    soundIdMap[GameSound.correct] = await cf;
  }

  Future<int> _loadSound(String path) {
    return rootBundle.load(path).then((ByteData soundData) {
      return _pool.load(soundData);
    });
  }

  Future<int> _playSound(int soundId) async {
    if (_streamId != null) await _pool.stop(_streamId!);
    int id = await _pool.play(soundId);
    _streamId = id;

    return id;
  }
}