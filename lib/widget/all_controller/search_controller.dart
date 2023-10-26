import 'package:flutter/foundation.dart';
import 'package:ta_rides/models/community_info.dart';

class SearchController extends ChangeNotifier {
  late List<Community> _recentSearches = [];

  void recentSearch(Community community) {
    // Remove the community from the list if it already exists
    _recentSearches.remove(community);

    // Add the community to the beginning of the list
    _recentSearches.insert(0, community);

    // Limit the list to 10 items
    if (_recentSearches.length > 10) {
      _recentSearches.removeLast();
    }

    // Notify listeners of the change
    notifyListeners();
    print('naka sud bas recent search');
    print(_recentSearches.length);
  }

  List<Community> get recentSearches => _recentSearches;

  void clear() {
    _recentSearches.clear();
    notifyListeners();
  }
}
