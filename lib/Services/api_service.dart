import 'dart:convert';
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

  Future<List<Match>?> getMatches(
      {List<String>? competitionIds, String? dateFrom, String? dateTo}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.matchEndpoint);

      // Define filters based on provided parameters
      var filters = <String, dynamic>{};
      if (competitionIds != null)
        filters['competitions'] = competitionIds.join(',');
      if (dateFrom != null) filters['dateFrom'] = dateFrom;
      if (dateTo != null) filters['dateTo'] = dateTo;

      // Append filters to the URL
      if (filters.isNotEmpty) {
        url = url.replace(queryParameters: filters);
      }

      var headers = {'X-Auth-Token': ApiConstants.apiKey};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<Match> _matches = matchesFromJson(response.body);
        print("_matches api");
        print(_matches);
        return _matches;
      } else {
        print("API Error: ${response.reasonPhrase ?? 'Unknown Reason'}");
        return [];
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Match>?> getMatchesByTeam(int? teamIds) async {
    try {
      var url = Uri.parse(
          '${ApiConstants.baseUrl + ApiConstants.teamEndpoint}/$teamIds${ApiConstants.matchEndpoint}');

      var headers = {'X-Auth-Token': ApiConstants.apiKey};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<Match> _matches = matchesFromJson(response.body);
        return _matches;
      } else {
        print("API Error: ${response.reasonPhrase ?? 'Unknown Reason'}");
        return [];
      }
    } catch (e) {
      log(e.toString());
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
   Future<String?> getUserCountry() async {
    try {
      var ipCheckUrl = Uri.parse("http://checkip.amazonaws.com/");
      var ipResponse = await http.get(ipCheckUrl);

      if (ipResponse.statusCode == 200) {
        var ipAddress = ipResponse.body.trim();

        var geoLocationUrl = Uri.parse(
            "https://api.ipgeolocation.io/ipgeo?apiKey=e3f347b989f34e239402188106fbdf4c&ip=$ipAddress");

        var geoLocationResponse = await http.get(geoLocationUrl);

        if (geoLocationResponse.statusCode == 200) {
          var geoData = json.decode(geoLocationResponse.body);
          var country = geoData['country_name'];
          return country;
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
