import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<FishingSpot> _fishingSpots = FishingSpot.getFishingSpot();
  final List<News> _newsList = News.newsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100],
        leading: const Icon(Icons.person),
        title: const Text(
          'Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          const Icon(Icons.notifications),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: SizedBox(),
            ),
            const ListTile(
              title: Text('Checklist'),
            ),
            const ListTile(
              title: Text('Favorite'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Near Me: 5 - 10 km.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Fishing spots',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _fishingSpots.length,
                itemBuilder: (context, index) {
                  final spot = _fishingSpots[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 80.0,
                        height: 100.0,
                        child: Image.asset(
                          spot.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        spot.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(spot.details),
                          Text('Distance: ${spot.distance}'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _fishingSpots[index].isFaved =
                                    !_fishingSpots[index].isFaved;
                              });
                            },
                            child: Icon(
                              _fishingSpots[index].isFaved
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _fishingSpots[index].isFaved
                                  ? const Color.fromARGB(255, 156, 30, 51)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8.0),
                Text('2'),
                SizedBox(width: 8.0),
                Text('3'),
                SizedBox(width: 8.0),
                Text('Last'),
              ],
            ),
            const Text(
              'News',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 120.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _newsList.length,
                itemBuilder: (context, index) {
                  final newsItem = _newsList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            newsItem.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            newsItem.details,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/plan');
          }
        },
      ),
    );
  }
}

class News {
  String title = '';
  String details = '';
  News({
    required this.title,
    required this.details,
  });

  static List<News> newsList() {
    List<News> newlist = [];
    newlist.add(News(title: 'New laws for fishing in Thailand', details: 'More detail about the new fishing laws...'));
    newlist.add(News(title: 'Update a new area at Siam Canal...', details: 'More details about the new fishing area in Siam Canal...'));
    newlist.add(News(title: 'Sun-bathing in front of...', details: 'More details about this news item...'));
    newlist.add(News(
        title: 'Blackchin Tilapia Concerns Rise...',
        details:
            'Farmers from 19 provinces...'));
    newlist.add(News(
        title: 'Debate Over Fine-Mesh Net...',
        details:
            'There are concerns that...'));
    return newlist;
  }
}

class FishingSpot {
  String name;
  String details;
  String distance;
  String image;
  bool isFaved;

  FishingSpot({
    required this.name,
    required this.details,
    required this.distance,
    required this.image,
    this.isFaved = false,
  });

  static List<FishingSpot> getFishingSpot() {
    List<FishingSpot> list = [];

    list.add(FishingSpot(
      name: 'Chao Phraya River',
      details: 'Popular riverside location with plenty of space and good water flow.',
      distance: '6 km.',
      image: '../assets/river1.jpg',
    ));

    list.add(FishingSpot(
      name: 'Bang Kachao Canal',
      details: 'Quiet spot surrounded by greenery. Best during early mornings.',
      distance: '8 km.',
      image: '../assets/river2.jpg',
    ));

    list.add(FishingSpot(
      name: 'Phra Khanong Canal',
      details: 'Local favorite with quiet corners. Great for catching catfish.',
      distance: '10 km.',
      image: '../assets/river3.jpg',
    ));

    return list;
  }
}