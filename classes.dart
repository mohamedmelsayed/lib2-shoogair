 class Record {
  String key;
  String value;

  Record(String k, String v) {
    this.key = k;
    this.value = v;
  }
  String get get_key {
    return key;
  }

  String get get_value {
    return value;
  }

  void set setKey(String key) {
    this.key = key;
  }

  void set setValue(String value) {
    this.value = value;
  }
}