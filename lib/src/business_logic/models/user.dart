class FireUser {
  String uid;
  String email;

  FireUser(this.uid, this.email);

  Map<String, dynamic> toJson() {
  return {"uid": this.uid, "email": this.email};
}
}


