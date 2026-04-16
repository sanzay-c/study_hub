import 'package:study_hub/core/config/env_config.dart';

class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = "/api/auth/login/";
  static const String register = "/api/auth/register/";
  static const String logout = "/api/auth/logout/";
  static const String refreshToken = "/api/auth/refresh/";
  static const String deleteAccount = "/api/auth/delete_account/";
  static const String fcmToken = "/api/auth/fcm-token/";

  // Auth(forgot-password)

  // "/api/auth/request_reset/"
  // Body: {
  //   "email": "sanzay.369@gmail.com"
  // }
  static const String requestReset = "/api/auth/request_reset/";

  // "/api/auth/verify_otp/"
  //  Body: {
  //     "email": "sanzay.369@gmail.com",
  //     "otp": "719940" 
  // }
  static const String verifyOTP = "/api/auth/verify_otp/";

  // "/api/auth/reset_password/"
  // Body: {
  //     "email": "sanzay.369@gmail.com",
  //     "otp": "719940",
  //     "new_password": "pass123"
  // }
  static const String resetPassword = "/api/auth/reset_password/";

  // stats following, followers Groups summary
  static const String userStats = "/api/auth/me/stats/";
  static String userStatsId(String userId) => "/api/auth/users/$userId/stats/";

  // upload avatar
  static const String uploadAvatar = "/api/auth/upload_avatar/";

  // notes
  static const String myNotes = '/api/notes/me/';
  static const String discoverNotes = '/api/notes/discover/';

  //download notes{{base_url}}/api/notes/699b4b0459cfafcbda0950d9/download/
  static String downloadNotes(String noteId) => "/api/notes/$noteId/download/";

  // GET groups
  static const String getGroups = '/api/groups/';

  // GET notes
  static const String getNotes = '/api/notes/';

  // Social
  static const String socialFollowing = "/api/social/following/";
  static const String socialFollowers = "/api/social/followers/";
  static const String socialDiscover = "/api/social/discover/";
  
  static const String socialFollow = "/api/social/follow/";
  static const String socialUnfollow = "/api/social/follow/";

  // groups
  // this same endpoint uses 'tab' param to show different tabs 
  // '?tab=discover' => shows the groups to discover
  // '?tab=joined' => shows the joined groups
  // '?tab=created' => shows the groups that a user have created  
  static const String getAllGroups = '/api/groups/';

  static get baseUrl => null;

  // get groups detail api
  static String getGroupsDetail(String groupId) => "/api/groups/$groupId";

  // POST create a new group
  static const String createNewGroup = '/api/groups/'; // POST method
  
  // leave group
  static String leaveGroup(String groupId) => "/api/groups/$groupId/leave/";

  // join group
  static String joinGroup(String groupId) => "/api/groups/$groupId/join/";

  // delete group
  static String deleteGroup(String groupId) => "/api/groups/$groupId/"; // DELETE method

  // update group
  static String updateGroup(String groupId) => "/api/groups/$groupId/"; // PATCH method

  // remove rember group owner
  static String removeMember(String groupId) => "/api/groups/$groupId/kick/"; // POST method

  static String get _wsBaseUrl {
    final baseUrl = EnvConfig.apiBaseUrl;
    if (baseUrl.startsWith('https://')) {
      return baseUrl.replaceFirst('https://', 'wss://');
    } else if (baseUrl.startsWith('http://')) {
      return baseUrl.replaceFirst('http://', 'ws://');
    }
    return 'ws://$baseUrl';
  }


  // wss:
  // ws://127.0.0.1:8000/ws/dm/6990a163d0b34aed2411b8c4/6965107b15eb685b5d75c0ef/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzczMDAzNTI2LCJpYXQiOjE3NzI5ODU1MjYsImp0aSI6IjFmYTY5YThjMmQwNTQyZmZiZWY5Yjg2NWQ0M2E0N2JjIiwidXNlcl9pZCI6IjY5OTBhMTYzZDBiMzRhZWQyNDExYjhjNCIsInVzZXJuYW1lIjoiVGVzdDEwMSJ9._eahOkXxQ0KXgNFACaUTOP3IfGEEToh9iCUkKrkTJK0
  // ws://${EnvConfig.apiBaseUrl}/ws/dm/<user_id_a>/<user_id_b>/?token=<access_token>
  // message:
  //   {
  //     "message": "hello from the other side",
  //     "sender_id": "6990a163d0b34aed2411b8c4",
  //     "receiver_id": "6965107b15eb685b5d75c0ef"
  // }
  static String dmMessage(String userIdA, userIdB) => "$_wsBaseUrl/ws/dm/$userIdA/$userIdB/"; 
  
  // wss:
  // ws:/${EnvConfig.apiBaseUrl}/ws/chat/6965d509cc8d76c2ee6f6279/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzczMDAzNTI2LCJpYXQiOjE3NzI5ODU1MjYsImp0aSI6IjFmYTY5YThjMmQwNTQyZmZiZWY5Yjg2NWQ0M2E0N2JjIiwidXNlcl9pZCI6IjY5OTBhMTYzZDBiMzRhZWQyNDExYjhjNCIsInVzZXJuYW1lIjoiVGVzdDEwMSJ9._eahOkXxQ0KXgNFACaUTOP3IfGEEToh9iCUkKrkTJK0
  // ws:/${EnvConfig.apiBaseUrl}/ws/chat/<groud_id>/?token=<ACCESS_TOKEN>
  // message:
  //   {
  //     "message": "Hello from Postman!",
  //     "sender_id": "6990a163d0b34aed2411b8c4"
  // }
  static String messageGroup(String groupId) => "$_wsBaseUrl/ws/chat/$groupId/"; 

  // fetch group history
  // {{base_url}}/api/chat/messages/?group_id=6965d509cc8d76c2ee6f6279
  // [
  // {
  //     "_id": "69ada404fb702e4aac6db361",
  //     "group_id": "6965d509cc8d76c2ee6f6279",
  //     "sender_id": "6990a163d0b34aed2411b8c4",
  //     "content": "Hello from Postman!",
  //     "message_type": "text",
  //     "timestamp": "2026-03-08T16:29:56.541110+00:00"
  // },
  // ]
  static String groupHistoryMessage(String groupId) => "/api/chat/messages/?group_id=$groupId"; // GET method

  // fetch DM history
  // {{base_url}}/api/chat/dm/6965107b15eb685b5d75c0ef/ // this _id is other user id this endpoint like conversation with other user history
  //   [
  //     {
  //         "_id": "69ada8e8fb702e4aac6db363",
  //         "room_id": "dm_6965107b15eb685b5d75c0ef_6990a163d0b34aed2411b8c4",
  //         "sender_id": "6990a163d0b34aed2411b8c4",
  //         "receiver_id": "6965107b15eb685b5d75c0ef",
  //         "content": "hello from the other side",
  //         "timestamp": "2026-03-08T16:50:48.692880+00:00",
  //         "read": false
  //     }
  // ]
  static String dmHistoryMessage(String otherUserID) => "/api/chat/dm/$otherUserID/"; // GET method

  // get recent chat list 
  static String recentChatList = "/api/chat/recent/"; // GET method

  // mark as read
  static const String markAsRead = "/api/chat/mark-as-read/"; // POST method
}