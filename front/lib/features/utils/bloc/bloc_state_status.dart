enum StateStatus {
  // Initial state, before any event is added
  init,
  // State when the bloc is loading data
  loading,
  // State when the bloc is failed on background task
  error,
  // State when the bloc is ready to display data
  select,
  // State when the bloc is performing some background task with data present
  progress,
  // State when the bloc is ready to commit, we are previewing results
  preview,
  // State when the bloc is committing the result on the background
  commit,
  // State when the bloc is successfully finished the scenario
  success,
}

extension StateStatusExtention on StateStatus {
  bool get isFinished => this == StateStatus.success;
  bool get isReady => this == StateStatus.select;

  static bool changed(StateStatus from, StateStatus to) => from != to;
}
