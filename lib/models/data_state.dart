sealed class DataState<T> {}

class DataInitial<T> extends DataState<T> {}

class DataLoading<T> extends DataState<T> {}

class DataFailure<T> extends DataState<T> {
  DataFailure(this.message);
  final String message;
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(this.data);
  final T data;
}
