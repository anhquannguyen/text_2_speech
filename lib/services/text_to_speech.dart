import 'package:text_to_speech/text_to_speech.dart';

class TextToSpeechService {
  final TextToSpeech _tts = TextToSpeech();
  static const String _defaultLang = "en_US";

  TextToSpeechService._privateConstructor();
  static final TextToSpeechService _instance =
      TextToSpeechService._privateConstructor();
  factory TextToSpeechService() => _instance;

  void setVolume(double volume) {
    // Volumn range 0..1
    _tts.setVolume(volume);
  }

  void setSpeechRate(double rate) {
    // Rate range 0..2
    _tts.setRate(rate);
  }

  void setPitch(double pitch) {
    // Pitch range 0..2
    _tts.setPitch(pitch);
  }

  void setLang(String code) {
    _tts.setLanguage(code);
  }

  Future<List<String>?> getVoices() async {
    return await _tts
        .getVoiceByLang(await _tts.getDefaultLanguage() ?? _defaultLang);
  }

  void speak(String text) {
    _tts.speak(text);
  }

  void resume() {
    _tts.resume();
  }

  void pause() {
    _tts.pause();
  }

  void stop() {
    _tts.stop();
  }
}
