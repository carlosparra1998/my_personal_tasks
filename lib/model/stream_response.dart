import 'package:my_personal_tasks/model/task.dart';

class StreamResponse{
  late String status;
  late List<Task> response;
    StreamResponse(
      this.status,
      this.response);
}