import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/model/audio.dart';
import 'package:audioplayers/audioplayers.dart';

final audioProvider = StateNotifierProvider<AudioNotifier, Audio>((ref) {
  return AudioNotifier();
});

class AudioNotifier extends StateNotifier<Audio> {


  AudioNotifier():super(const Audio()){
    setup();
  }

  Future setup()async{
    final player = AudioPlayer();
    state = state.copyWith(player: player);
  }
  
  Future playCorrectSound() async {
    if(state.player != null) {
      await state.player!.setSource(AssetSource('audio/correct_sound.mp3'));
      state.player!.resume();
    }
  }
  Future playIncorrectSound() async {
    if(state.player != null) {
      await state.player!.setSource(AssetSource('audio/incorrect_sound.mp3'));
      state.player!.resume();
    }
  }

}