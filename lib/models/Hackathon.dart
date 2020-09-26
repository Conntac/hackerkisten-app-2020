import 'Event.dart';

class Hackathon extends Event{
  int id;
  String scenario;
  String supervisor;
  String requirements;
  String difficulty;
  String supplied;
  String organizerName;
  String organizerCompany;
  String organizerRole;

  Hackathon(
      this.id,
      this.scenario,
      this.supervisor,
      this.requirements,
      this.difficulty,
      this.supplied,
      this.organizerName,
      this.organizerCompany,
      this.organizerRole);
}