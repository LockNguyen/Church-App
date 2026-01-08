/// Represents a single discipleship class session.
class DiscipleshipClassEntity {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String? contact;
  final String? passage;

  const DiscipleshipClassEntity({
    required this.id,
    required this.startTime,
    required this.endTime,
    this.contact,
    this.passage,
  });
}