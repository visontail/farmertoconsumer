class StorageItem<T> {
  T? _value;

  void set(T value) {
    _value = value;
  }

  T? get() {
    return _value;
  }

  void delete() {
    _value = null;
  }

  bool isSet() {
    return _value != null;
  }
}