import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 本地数据持久化存储
class SpUtil {
  SpUtil._internal();
  static SpUtil _spUtil = SpUtil._internal();

  static SharedPreferences _sp;
  factory SpUtil() {
    return _spUtil;
  }

  //必须要异步初始化
  Future<SharedPreferences> init() async {
    _sp = await SharedPreferences.getInstance();
    return _sp;
  }

  ///根据不同的类型，调用不同的存储方法
  static Future<bool> put(String key, Object value) {
    if (value is int) {
      return putInt(key, value);
    } else if (value is String) {
      return putString(key, value);
    } else if (value is bool) {
      return putBool(key, value);
    } else if (value is double) {
      return putDouble(key, value);
    } else if (value is List<String>) {
      return putStringList(key, value);
    }
    throw Exception("不能存入的数据类型");
  }

  ///存入对象
  static Future<bool> putObject(String key, Object value) {
    if (_sp == null) return null;
    return _sp.setString(
        "object_$key", value == null ? "" : json.encode(value));
  }

  ///获得对象
  static T getObj<T>(String key, T f(Map v), {T defValue}) {
    Map map = getObject(key);
    return map == null ? defValue : f(map);
  }

  ///获得Map对象
  static Map getObject(String key) {
    if (_sp == null) return null;
    String _data = _sp.getString("object_$key");
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  ///存入对象列表
  static Future<bool> putObjectList(String key, List<Object> list) {
    if (_sp == null) return null;
    List<String> _dataList = list?.map((value) {
      return json.encode(value);
    })?.toList();
    return _sp.setStringList(key, _dataList);
  }

  ///获得对象列表
  static List<T> getObjList<T>(String key, T f(Map v),
      {List<T> defValue = const []}) {
    List<Map> dataList = getObjectList(key);
    List<T> list = dataList?.map((value) {
      return f(value);
    })?.toList();
    return list ?? defValue;
  }

  ///获得嵌套Map的对象列表
  static List<Map> getObjectList(String key) {
    if (_sp == null) return null;
    List<String> dataLis = _sp.getStringList(key);
    return dataLis?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }

  ///获得字符串
  static String getString(String key, {String defValue = ''}) {
    if (_sp == null) return defValue;
    return _sp.getString(key) ?? defValue;
  }

  ///存入字符串
  static Future<bool> putString(String key, String value) {
    if (_sp == null) return null;
    return _sp.setString(key, value);
  }

  ///获得布尔值
  static bool getBool(String key, {bool defValue = false}) {
    if (_sp == null) return defValue;
    return _sp.getBool(key) ?? defValue;
  }

  ///存入布尔值
  static Future<bool> putBool(String key, bool value) {
    if (_sp == null) return null;
    return _sp.setBool(key, value);
  }

  ///获得int值
  static int getInt(String key, {int defValue = 0}) {
    if (_sp == null) return defValue;
    return _sp.getInt(key) ?? defValue;
  }

  ///存入int值
  static Future<bool> putInt(String key, int value) {
    if (_sp == null) return null;
    return _sp.setInt(key, value);
  }

  ///获得double值
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_sp == null) return defValue;
    return _sp.getDouble(key) ?? defValue;
  }

  ///存入double值
  static Future<bool> putDouble(String key, double value) {
    if (_sp == null) return null;
    return _sp.setDouble(key, value);
  }

  ///获得字符串列表
  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    if (_sp == null) return defValue;
    return _sp.getStringList(key) ?? defValue;
  }

  ///存入字符串列表
  static Future<bool> putStringList(String key, List<String> value) {
    if (_sp == null) return null;
    return _sp.setStringList(key, value);
  }

  ///获得dynamic对象
  static dynamic getDynamic(String key, {Object defValue}) {
    if (_sp == null) return defValue;
    return _sp.get(key) ?? defValue;
  }

  ///是否具有某个key
  static bool haveKey(String key) {
    if (_sp == null) return null;
    return _sp.getKeys().contains(key);
  }

  ///获得所有的key
  static Set<String> getKeys() {
    if (_sp == null) return null;
    return _sp.getKeys();
  }

  ///移除指定key的存储
  static Future<bool> remove(String key) {
    if (_sp == null) return null;
    return _sp.remove(key);
  }

  ///清空
  static Future<bool> clear() {
    if (_sp == null) return null;
    return _sp.clear();
  }
}
