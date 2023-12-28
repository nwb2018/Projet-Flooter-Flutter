import 'dart:developer';

import 'package:flooter/constants.dart';
import 'package:flooter/models/competition_model.dart';
import 'package:flooter/models/match_model.dart';
import 'package:flooter/models/table_model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  Future<List<CompetitionModel>?> getCompetitions() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.competitionEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<CompetitionModel> _model = competitionModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Match>?> getCompetitionMatches(
      String competitionCode, int matchday) async {
    try {
      var url = Uri.parse(
          '${ApiConstants.baseUrl}/competitions/$competitionCode/matches?matchday=$matchday');
      var headers = {'X-Auth-Token': ApiConstants.apiKey};

      var response = await http.get(url, headers: headers);

      print("response.statusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("response.body: ${response.body}");
        List<Match> _matches = matchesFromJson(response.body);
        return _matches;
      } else {
        print("API Error: ${response.reasonPhrase ?? 'Unknown Reason'}");
        // Return an empty list or handle the error in another way based on your requirements.
        return [];
      }
    } catch (e) {
      log(e.toString());
      // Handle other exceptions as needed.
      return null;
    }
  }

  Future<List<TableItem>> getCompetitionStandings(
      String competitionCode) async {
    try {
      var url = Uri.parse(
          '${ApiConstants.baseUrl}/competitions/$competitionCode/standings');
      var headers = {'X-Auth-Token': ApiConstants.apiKey};

      var response = await http.get(url, headers: headers);

      print("response.statusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("response.body: ${response.body}");
        List<TableItem> standings = TableItem.tableItemsFromJson(response.body);
        return standings;
      } else {
        print("API Error: ${response.reasonPhrase ?? 'Unknown Reason'}");
        // Return an empty list or handle the error in another way based on your requirements.
        return [];
      }
    } catch (e) {
      log(e.toString());
      // Handle other exceptions as needed.
      return [];
    }
  }
}
