import 'dart:math';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText stt = SpeechToText();

  SpeechToTextService._privateConstructor();
  static final SpeechToTextService _instance =
      SpeechToTextService._privateConstructor();
  factory SpeechToTextService() => _instance;

  Future<void> initSpeechState() async {
    try {
      var hasSpeech = await stt.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
      );
      if (hasSpeech) {
        _localeNames = await stt.locales();
        var systemLocale = await stt.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      // if (!mounted) return;

      _hasSpeech = hasSpeech;
    } catch (e) {
      _hasSpeech = false;
    }
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    // final pauseFor = int.tryParse(_pauseForController.text);
    // final listenFor = int.tryParse(_listenForController.text);
    // Note that `listenFor` is the maximum, not the minimun, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    stt.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 3),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void stopListening() {
    stt.stop();
    level = 0.0;
  }

  void cancelListening() {
    stt.cancel();
    level = 0.0;
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    lastWords = '${result.recognizedWords} - ${result.finalResult}';
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    this.level = level;
  }

  void errorListener(SpeechRecognitionError error) {
    lastError = '${error.errorMsg} - ${error.permanent}';
  }

  void statusListener(String status) {
    lastStatus = status;
  }
}
