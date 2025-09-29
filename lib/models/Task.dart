class Task{
  final String name;
  bool isDone;
  final TaskCategory category;
  Task({required this.name, this.isDone=false, required this.category});

  void toggleDone(){
    isDone =! isDone;
  }
}
enum TaskCategory { all, work, personal, study, errands, home, general }

String categoryLabel(TaskCategory c) {
  switch (c) {
    case TaskCategory.work: return 'Work';
    case TaskCategory.personal: return 'Personal';
    case TaskCategory.study: return 'Study';
    case TaskCategory.errands: return 'Errands';
    case TaskCategory.home: return 'Home';
    case TaskCategory.general: return 'General';
    case TaskCategory.all: return 'All';
  }
}