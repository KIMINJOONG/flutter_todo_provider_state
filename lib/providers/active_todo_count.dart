import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:todo_provider_state/models/todo_model.dart';
import 'package:todo_provider_state/providers/providers.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;
  ActiveTodoCountState({required this.activeTodoCount});

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  List<Object> get props => [activeTodoCount];

  bool get stringify => true;

  ActiveTodoCountState copyWtih({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
        activeTodoCount: activeTodoCount ?? this.activeTodoCount);
  }
}

class ActiveTodoCount extends StateNotifier<ActiveTodoCountState>
    with LocatorMixin {
  ActiveTodoCount() : super(ActiveTodoCountState.initial());

  @override
  void update(Locator watch) {
    final List<Todo> todos = watch<TodoListState>().todos;

    state = state.copyWtih(
      activeTodoCount:
          todos.where((Todo todo) => !todo.completed).toList().length,
    );
    super.update(watch);
  }

  // ActiveTodoCountState get state => ActiveTodoCountState(
  //       activeTodoCount: todoList.state.todos
  //           .where((Todo todo) => !todo.completed)
  //           .toList()
  //           .length,
  //     );
}
