import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'primitives/player.dart';
import 'primitives/statistic_player.dart';

class PlayerStatistic {
  Player? player;
  List<StatisticPlayer>? statisticPlayers;
  PlayerStatistic({
    this.player,
    this.statisticPlayers,
  });

  PlayerStatistic copyWith({
    Player? player,
    List<StatisticPlayer>? statisticPlayers,
  }) {
    return PlayerStatistic(
      player: player ?? this.player,
      statisticPlayers: statisticPlayers ?? this.statisticPlayers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'player': player?.toMap(),
      'statisticPlayers': statisticPlayers?.map((x) => x.toMap()).toList(),
    };
  }

  factory PlayerStatistic.fromMap(Map<String, dynamic> map) {
    return PlayerStatistic(
      player: map['player'] != null ? Player.fromMap(map['player']) : null,
      statisticPlayers: map['statisticPlayers'] != null
          ? List<StatisticPlayer>.from(
              map['statisticPlayers']?.map((x) => StatisticPlayer.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerStatistic.fromJson(String source) =>
      PlayerStatistic.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlayerStatistic(player: $player, statisticPlayers: $statisticPlayers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlayerStatistic &&
        other.player == player &&
        listEquals(other.statisticPlayers, statisticPlayers);
  }

  @override
  int get hashCode => player.hashCode ^ statisticPlayers.hashCode;
}
