import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType()
class Contact {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int number;

  Contact(this.name, this.number);
}
