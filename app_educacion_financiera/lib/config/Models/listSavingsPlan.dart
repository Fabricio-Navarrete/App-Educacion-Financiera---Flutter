class Listsavingsplan {
  final String goalName;
  final double targetAmount;
  final double currentSavings;
  final int idEstudiante;
  final int id;

  Listsavingsplan(
      {required this.idEstudiante,
      required this.goalName,
      required this.targetAmount,
      required this.currentSavings,
      required this.id});
  factory Listsavingsplan.fromJson(Map<String, dynamic> json) {
    return Listsavingsplan(
      id: json['id'],
      idEstudiante: json['idEstudiante'],
      goalName: json['goalName'],
      targetAmount: json['targetAmount'],
      currentSavings: json['currentSavings'],
    );
  }
  static List<Listsavingsplan> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => Listsavingsplan.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'goalName': goalName,
      'targetAmount': targetAmount,
      'currentSavings': currentSavings,
      'idEstudiante': idEstudiante,
      'id' : id
    };
  }
}
