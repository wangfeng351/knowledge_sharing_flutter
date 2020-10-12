class BonusLog {
  int id;
  int userId;
  int value;
  String event;
  String createTime;
  String description;

  BonusLog(
      {this.id,
      this.userId,
      this.value,
      this.event,
      this.createTime,
      this.description});

  BonusLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    value = json['value'];
    event = json['event'];
    createTime = json['createTime'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['value'] = this.value;
    data['event'] = this.event;
    data['createTime'] = this.createTime;
    data['description'] = this.description;
    return data;
  }
}
