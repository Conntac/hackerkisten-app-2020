
import 'Event.dart';

class Barcamp extends Event{
  int id;
  String title;
  String description;
  String format;
  String organizerName;
  String organizerCompany;

  Barcamp(this.id, this.title, this.description, this.format,
      this.organizerName, this.organizerCompany);
}