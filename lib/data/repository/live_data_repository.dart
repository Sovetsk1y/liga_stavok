import 'dart:math';

import 'package:liga/data/model/live_event.dart';
import 'package:liga/net/network_client.dart';

import '../../config.dart';

class LiveDataRepository {
  final NetworkClient _networkClient;
  final Config _config;

  final Random _random = Random();
  final List<LiveEvent> _predefinedLiveEvents = List<LiveEvent>();
  final List<LiveEvent> _liveEvents = List<LiveEvent>();

  static LiveDataRepository _instance;

  factory LiveDataRepository(networkClient, config) {
    return _instance ?? LiveDataRepository._internal(networkClient, config);
  }

  LiveDataRepository._internal(this._networkClient, this._config) {
    _instance = this;
    _fillPredefinedLiveEvents();
  }

  Future<LiveEvent> getLiveEvent() async {
    int randomNumber = _random.nextInt(_predefinedLiveEvents.length);
    LiveEvent event = _predefinedLiveEvents[randomNumber];
    _liveEvents.add(event);
    return event;
  }

  Future<List<LiveEvent>> getLiveEvents() async => _liveEvents;

  void _fillPredefinedLiveEvents() {
    _predefinedLiveEvents.add(LiveEvent('Карим Бензема', LiveEventType.goal));
    _predefinedLiveEvents.add(LiveEvent('Степан Пупкин', LiveEventType.goal));
    _predefinedLiveEvents.add(LiveEvent('Тарас Степаненко', LiveEventType.yellowCard));
    _predefinedLiveEvents.add(LiveEvent('Тайсон Батькович', LiveEventType.redCard));
    _predefinedLiveEvents.add(LiveEvent('Тарас Бульба - Иван Маркович', LiveEventType.change));
  }
}
