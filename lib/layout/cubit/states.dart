abstract class SocialStates {}

class SocialGetUserInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialSettingState extends SocialStates {}


class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}


class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}


class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}


//create Post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}


class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

//create comment

class SocialCreateCommentLoadingState extends SocialStates {}

class SocialCreateCommentSuccessState extends SocialStates {}

class SocialCreateCommentErrorState extends SocialStates {}

class SocialCommentImagePickedSuccessState extends SocialStates {}

class SocialCommentImagePickedErrorState extends SocialStates {}

class SocialRemoveCommentImageState extends SocialStates {}

class SocialUploadCommentImageSuccessState extends SocialStates {}

class SocialGetCommentLoadingState extends SocialStates {}

class SocialGetCommentSuccessState extends SocialStates {}

class SocialGetCommentErrorState extends SocialStates {
  final String error;

  SocialGetCommentErrorState(this.error);
}


class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {
  final String error;

  SocialCommentPostErrorState(this.error);
}


//chats

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesLoadingState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialMessageImagePickedSuccessState extends SocialStates {}

class SocialMessageImagePickedErrorState extends SocialStates {}

class SocialRemoveMessageImageState extends SocialStates {}

class SocialUploadMessageImageLoadingState extends SocialStates {}

class SocialUploadMessageImageSuccessState extends SocialStates {}

class SocialUploadMessageImageErrorState extends SocialStates {}

class SocialChangeEmojeIconState extends SocialStates {}


//search
class SearchLoadingState extends SocialStates {}

class SearchSuccessState extends SocialStates {}

class SearchErrorState extends SocialStates {
  final String error;

  SearchErrorState(this.error);
}

//notification

class SocialSendMessageNotificationSuccessState extends SocialStates {}

class SocialSendMessageNotificationErrorState extends SocialStates {}

class SocialGetNotificationsSuccessState extends SocialStates {}

class SocialGetNotificationsErrorState extends SocialStates {}