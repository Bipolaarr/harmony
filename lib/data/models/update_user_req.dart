class UpdateUserReq {

    final String? username;
    final String? email;
    final String? currentPassword;
    final String? newPassword;

  UpdateUserReq({
    required this.currentPassword,
    this.newPassword,
    this.email,
    this.username
    });


}