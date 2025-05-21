import 'package:flutter/material.dart';

class FishingPlanPage extends StatefulWidget {
  const FishingPlanPage({super.key});
  @override
  State<FishingPlanPage> createState() => _FishingPlanPageState();
}

class _FishingPlanPageState extends State<FishingPlanPage> {
  final List<FishingPlan> _plans = FishingPlan.planList();

  void _showAddPlanDialog() {
    final titleController = TextEditingController();
    final dateController = TextEditingController();
    final locationController = TextEditingController();
    final targetFishController = TextEditingController();
    final baitController = TextEditingController();
    final equipmentController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Fishing Plan'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: dateController, decoration: const InputDecoration(labelText: 'Date')),
              TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location')),
              TextField(controller: targetFishController, decoration: const InputDecoration(labelText: 'Target Fish')),
              TextField(controller: baitController, decoration: const InputDecoration(labelText: 'Bait')),
              TextField(controller: equipmentController, decoration: const InputDecoration(labelText: 'Equipment')),
              TextField(controller: notesController, decoration: const InputDecoration(labelText: 'Notes')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newPlan = FishingPlan(
                title: titleController.text,
                date: dateController.text,
                location: locationController.text,
                targetFish: targetFishController.text,
                bait: baitController.text,
                equipment: equipmentController.text,
                notes: notesController.text,
              );
              setState(() {
                _plans.add(newPlan);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100],
        leading: const Icon(Icons.person),
        title: const Text(
          'Plan',
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
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                mini: true,
                onPressed: _showAddPlanDialog,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  final plan = _plans[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: Colors.lightGreen[100],
                          leading: IconButton(
                            icon: Icon(plan.isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down), //change arrow direction
                            onPressed: () {
                              setState(() {
                                plan.isExpanded = !plan.isExpanded;
                              });
                            },
                          ),
                          title: Text('Plan ${index + 1}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${plan.date.substring(0, 10)}'),
                              Text('Time: ${plan.date.substring(12)}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(icon: const Icon(Icons.delete), onPressed: () {
                                setState(() {
                                  _plans.removeAt(index);
                                });
                              }),
                              IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                            ],
                          ),
                        ),
                        if (plan.isExpanded) //show detail
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Location: ${plan.location}'),
                                Text('Target Fish: ${plan.targetFish}'),
                                Text('Bait: ${plan.bait}'),
                                Text('Equipment: ${plan.equipment}'),
                                if (plan.notes.isNotEmpty) ...[
                                  const SizedBox(height: 8.0),
                                  Text('Notes: ${plan.notes}'),
                                ],
                              ],
                            ),
                          ),
                      ],
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
        currentIndex: 0,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          if (index == 1) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class FishingPlan {
  String title;
  String date;
  String location;
  String targetFish;
  String bait;
  String equipment;
  String notes;
  bool isExpanded;

  FishingPlan({
    required this.title,
    required this.date,
    required this.location,
    required this.targetFish,
    required this.bait,
    required this.equipment,
    required this.notes,
    this.isExpanded = false,
  });

  static List<FishingPlan> planList() {
    return [
      FishingPlan(
        title: 'Chao Phraya River',
        date: '2024-07-15 (6:00 AM - 12:00 PM)',
        location: 'Chao Phraya River, Bangkok',
        targetFish: 'Arapaima, Redtail Catfish',
        bait: 'Live Worms, Artificial Lures',
        equipment: 'Lightweight Rod, Tackle Box',
        notes: 'Check weather forecast before heading out.',
      ),
      FishingPlan(
        title: 'Saphan Phut',
        date: '2024-07-22 (8:00 AM - 5:00 PM)',
        location: 'Saphan Phut Pier, Bangkok',
        targetFish: 'Catfish, Carp',
        bait: 'Chicken Liver, Dough Balls',
        equipment: 'Medium-Heavy Rod, Bank Sticks',
        notes: 'Bring sunscreen and plenty of water.',
      ),
      FishingPlan(
        title: 'New Pranangklao Bridge',
        date: '2024-07-29 (7:00 AM - 6:00 PM)',
        location: 'New Pranangklao Bridge Area, Nonthaburi',
        targetFish: 'Giant Mekong Catfish',
        bait: 'Live Baitfish, Trolling Lures',
        equipment: 'Heavy-Duty Rod, Fighting Belt',
        notes: 'Consider fishing from the banks or a small boat.',
      ),
    ];
  }
}