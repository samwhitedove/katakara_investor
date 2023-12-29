class EndPoint {
  // image endpoints
  static String uploadImage = '/user/upload-image';
  static String deleteImage = '/user/delete-image';
  // auth endpoints
  static String login = '/auth/login';
  static String register = '/auth/register';
  static String logOut = '/auth/logout';
  static String refreshToken(token) =>
      '/auth/refresh-token/?refreshToken=$token';
  static String generateEmailToken = '/auth/request-email-verification';
  static String validateEmailCode = '/auth/verify-email';
  static String resetUserPassword = '/auth/reset-password';
  static String requestPasswordResetCode = '/auth/request-reset-password';
  // profile
  static String updateProfile = '/user/update-profile';
  static String changeUserPassword = '/auth/change-password';
  static String fetchUserInfo = '/user/fetch-user-info';
  static String updateProfileImage = '/user/update-profile-picture';
  static String updateInvestorSignature = '/user/update-signature';
  // portfolio
  static String updatePortfolio = '/user/update-product';
  static String fetchPortfolio = '/user/fetch-portfolio';
  static String fetchPortfolioWithSearch(String type, int limit) =>
      '/user/fetch-portfolio?type=$type&limit=$limit';
  static String deletePortfolio(String sku) => '/user/delete-product?sku=$sku';
  static String addPortfolio = '/user/add-portfolio';
  // red flag
  static String createRedFlag = '/user/red-flag';
  static String fetchRedFlad = '/user/fetch-flag';
  // KFI
  static String inviteKFI = '/user/invite-user';
  static String acceptKFIInvite = '/user/accept-invite';
  static String unlineKFIInvite = '/user/unlink-user-request';
  static String acceptUnlineKFIInvite = '/user/accept-unlink';
  // faq
  static String fetchFaq = '/user/fetch-faq';
  // Youtube
  static String fetchYoutubeVideo = '/user/fetch-youtube';
  // Receipt
  static String fetchReceipt = '/user/fetch-receipt';
  static String fetchReceiptWithSearch(int limit, String search) =>
      '/user/fetch-receipt/?page=1&limit=$limit&search=$search';
  static String createReciept = '/user/create-receipt';
  // go live or offline
  static String goLiveAndOffline = '/user/go-live';
  // kfi endpoint
  static String inviteUser = '/user/invite-user';
  static String acceptInvite = '/user/accept-invite';
  static String unlinkUser = '/user/unlink-user-request';
  static String acceptUnlink = '/user/accept-unlink';
  static String fetchMerge = '/user/fetch-merge';
  // kfi endpoint
  static String fetchUser({String? type, String? find, bool? block}) =>
      '/console/fetch-user${type == null ? "" : "?type=$type"}${find == null ? "" : "&find=$find"}${block == null ? "" : "&block=$block"}';
  // block and unblock user admin
  static String blockUser(int id) => '/console/block-user?id=$id';
  static String unblockUser(int id) => '/console/unblock-user?id=$id';
  // admin faq
  static String addFaq = '/console/add-faq';
  static String updateFaq = '/console/update-faq';
  static String deleteFaq(int id) => '/console/delete-faq?id=$id';
}
