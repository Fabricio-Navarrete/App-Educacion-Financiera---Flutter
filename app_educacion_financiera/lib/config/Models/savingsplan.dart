class SavingsPlan {
  final String id;
  final String goalName;
  final double targetAmount;
  final int months;
  final DateTime createdAt;
  double currentSavings;

  SavingsPlan({
    required this.id,
    required this.goalName,
    required this.targetAmount,
    required this.months,
    required this.createdAt,
    this.currentSavings = 0.0,
  });

  factory SavingsPlan.fromJson(Map<String, dynamic> json) {
    return SavingsPlan(
      id: json['id'],
      goalName: json['goalName'],
      targetAmount: json['targetAmount'],
      months: json['months'],
      createdAt: DateTime.parse(json['createdAt']),
      currentSavings: json['currentSavings'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'goalName': goalName,
    'targetAmount': targetAmount,
    'months': months,
    'createdAt': createdAt.toIso8601String(),
    'currentSavings': currentSavings,
  };
}