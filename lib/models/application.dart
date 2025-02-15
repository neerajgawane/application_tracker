class Application {
  final String id;
  final String university;
  final String program;
  final String status;
  final double progress;
  final DateTime submissionDate;

  Application({
    required this.id,
    required this.university,
    required this.program,
    required this.status,
    required this.progress,
    required this.submissionDate,
  });

  factory Application.fromMap(Map<String, dynamic> map) {
    return Application(
      id: map['id'] ?? '',
      university: map['university'] ?? '',
      program: map['program'] ?? '',
      status: map['status'] ?? '',
      progress: (map['progress'] ?? 0.0).toDouble(),
      submissionDate: map['submissionDate'] is DateTime
          ? map['submissionDate']
          : DateTime.parse(map['submissionDate'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'university': university,
      'program': program,
      'status': status,
      'progress': progress,
      'submissionDate': submissionDate.toIso8601String(),
    };
  }
}