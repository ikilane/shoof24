import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import 'dart:convert';

Future<List<Map<String, dynamic>>> fetchUpcomingMatches() async {
  const String apiKey = '67ecad3c316d48b185b163ddc7975742';
  const String endpoint = 'http://api.football-data.org/v2/matches';
  List<Map<String, dynamic>> matches = [];

  try {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {'X-Auth-Token': apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Iterate through the matches and gather the required data
      for (var match in data['matches']) {
        matches.add({
          'id': match['id'],
          'homeTeam': match['homeTeam']['name'],
          'awayTeam': match['awayTeam']['name'],
          'matchTime': intl.DateFormat.yMd().add_jm().format(DateTime.fromMillisecondsSinceEpoch(match['utcDate'] * 1000)),
        });
      }

      return matches;
    } else {
      print('Failed to load matches');
    }
  } catch (e) {
    print('Error: $e');
  }

  return matches;
}
