import 'dart:math';

class Feed {
  final String firstName;
  final String lastName;

  final String description;
  final String imageUrl;
  final int likes;

  Feed({
    required this.firstName,
    required this.lastName,
    required this.description,
    required this.imageUrl,
    required this.likes,
  });

  // Factory method to generate a Feed from an index
  factory Feed.fromIndex(int index) {
    return Feed(
      firstName: generateName(),
      lastName: generateName(),
      description: 'This is the feed description for post #$index.',
      imageUrl: 'https://via.placeholder.com/400',
      likes: Random().nextInt(20),
    );
  }

  @override
  String toString() {
    return 'Feed(firstName: $firstName, lastName: $lastName, description: $description, imageUrl: $imageUrl, likes: $likes)';
  }
}

class DummyFeedDatabase {
  final List<Feed> _feeds;
  static const int _numberOfFeeds = 23;

  DummyFeedDatabase()
      : _feeds = List.generate(
            _numberOfFeeds, (index) => Feed.fromIndex(index),
            growable: true);

  Future<List<Feed>> getFeeds(int startIndex, int count) async {
    // This will handle things to not exceed existing "rows" of data.
    int endIndex = (startIndex + count) > _feeds.length
        ? _feeds.length
        : startIndex + count;

    // Simlute request delay
    await Future.delayed(Duration(seconds: 2));

    // Return "rows" starting from the new startIndex on each request and the new endIndex
    return _feeds.sublist(startIndex, endIndex);
  }
}

String generateName() {
  String aplphabet = "abcdefghijklmnopqrstuvwxyz";
  Random random = Random();
  int stringLength = random.nextInt(10);
  String name = "";

  for (var i = 0; i < stringLength; i++) {
    int randomNum = random.nextInt(25) + 1;
    name += aplphabet[randomNum];
  }

  return name;
}

// FOR TESTING PURPOSES
void main() async {
  DummyFeedDatabase feedDatabase = DummyFeedDatabase();

  final int initialNumberOfFeeds = 5;
  final int nextNumberOfFeeds = 5;

  List<Feed> initialFeeds =
      await feedDatabase.getFeeds(0, initialNumberOfFeeds);
  print('Initial feeds: ${initialFeeds.length}');

  List<Feed> moreFeeds =
      await feedDatabase.getFeeds(initialNumberOfFeeds, nextNumberOfFeeds);
  print('More feeds: ${moreFeeds.length}');
}
