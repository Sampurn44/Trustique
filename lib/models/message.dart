class Message {
  Message({
    required this.msg,
    required this.toid,
    required this.read,
    required this.type,
    required this.fromid,
    required this.sent,
  });
  late final String msg;
  late final String toid;
  late final String read;
  late final Type type;
  late final String fromid;
  late final String sent;

  Message.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    toid = json['toid'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromid = json['fromid'].toString();
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['toid'] = toid;
    _data['read'] = read;
    _data['type'] = type.name;
    _data['fromid'] = fromid;
    _data['sent'] = sent;
    return _data;
  }
}

enum Type { text, image, link }
