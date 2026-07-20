import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final int dailyGoal = 2000;

  final List<Map<String, dynamic>> loggedMeals = [
    {'name': 'Chapatis & Red Beans', 'calories': 650},
    {'name': 'Githeri', 'calories': 450},
  ];

  int get totalConsumed {
    return loggedMeals.fold(0, (sum, item) => sum + (item['calories'] as int));
  }

  @override
  Widget build(BuildContext context) {
    final int remainingCalories = dailyGoal - totalConsumed;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorify Dashboard'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ProgressCard(
              remainingCalories: remainingCalories,
              dailyGoal: dailyGoal,
              totalConsumed: totalConsumed,
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: "Today's Food Log"),
            const SizedBox(height: 10),
            Expanded(
              child: _FoodLogList(loggedMeals: loggedMeals),
            ),
            const SizedBox(height: 12),
            const _AddFoodButton(),
          ],
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.remainingCalories,
    required this.dailyGoal,
    required this.totalConsumed,
  });

  final int remainingCalories;
  final int dailyGoal;
  final int totalConsumed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '$remainingCalories',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: remainingCalories >= 0 ? Colors.teal : Colors.red,
              ),
            ),
            const Text(
              'Calories Remaining',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'Goal: $dailyGoal  |  Eaten: $totalConsumed',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class _FoodLogList extends StatelessWidget {
  const _FoodLogList({required this.loggedMeals});

  final List<Map<String, dynamic>> loggedMeals;

  @override
  Widget build(BuildContext context) {
    if (loggedMeals.isEmpty) {
      return const Center(child: Text('No food logged yet today!'));
    }

    return ListView.builder(
      itemCount: loggedMeals.length,
      itemBuilder: (context, index) {
        final meal = loggedMeals[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.fastfood, color: Colors.teal),
            title: Text(meal['name']),
            trailing: Text(
              '${meal['calories']} kcal',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

class _AddFoodButton extends StatelessWidget {
  const _AddFoodButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // We will hook this up later when the add-food screen is ready.
      },
      icon: const Icon(Icons.add),
      label: const Text('Add Food Item', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}