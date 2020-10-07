import '../utils/constants.dart';

class EventObject {
  int id;
  Object object;
  String message;

  EventObject(
      {this.id: EventConstants.NO_INTERNET_CONNECTION,
      this.object: null,
      this.message});
}
