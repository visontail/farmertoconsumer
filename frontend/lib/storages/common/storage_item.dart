class WriteableStorageItem<T> {
  T? _value;

  void set(T? value) {
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

class StorageItem<T> {
  final WriteableStorageItem<T> _wsi;

  StorageItem(this._wsi);

  T? get() {
    return _wsi.get();
  }

  bool isSet() {
    return _wsi.isSet();
  }
}
