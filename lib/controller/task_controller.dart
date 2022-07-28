import 'package:get/get.dart';
import 'package:todo_algoriza/data/database/db.dart';
import 'package:todo_algoriza/data/models/task.dart';



class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  // add data to table
  //second brackets means they are named optional
  Future<int> addTask({Task? task}) {
    return DB.insert(task);
  }

  // get all the data from table
  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DB.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  // delete data from table
  void deleteTasks(Task task) async {
    await DB.delete(task);
    getTasks();
  }
  void deleteAllTasks() async {
    await DB.deleteAll();
    getTasks();
  }

  // update data int table
  void markTaskCompleted(int id) async {
    await DB.update(id);
    getTasks();
  }

  void markTaskFavourite(int id) async {
    await DB.favourite(id);
    getTasks();
  }
}