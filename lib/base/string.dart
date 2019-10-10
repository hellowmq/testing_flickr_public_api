class FlickrConstant {
  static const String FLICKR_HOST = 'https://www.flickr.com';
  static const String FLICKR_OAUTH_REQUEST_TOKEN_PATH =
      '/services/oauth/request_token';
  static const String FLICKR_OAUTH_ACCESS_TOKEN_PATH =
      '/services/oauth/access_token';
  static const String FLICKR_OAUTH_AUTHORIZE_PATH =
      '/services/oauth/authorize';
  static const String FLICKR_REST_PATH = '/services/rest';

//  static const String FLICKR_OAUTH_URL = FLICKR_HOST + FLICKR_OAUTH_PATH;
  static const String FLICKR_PHOTOS_GET_RECENT = 'flickr.photos.getRecent';
  static const String FLICKR_PHOTOS_GET_POPULAR = 'flickr.photos.getRecent';
  static const String FLICKR_PHOTOS_SEARCH = 'flickr.photos.search';
  static const String FLICKR_TEST_ECHO = 'flickr.test.echo';
  static const String FLICKR_TEST_LOGIN = 'flickr.test.login';
  static const String PHOTO = 'photo';
  static const String PHOTOS = 'photos';
}

class QueryKeyConstant {
  static const String FORMAT = 'format';
  static const String METHOD = 'method';
  static const String NO_JSON_CALLBACK = 'nojsoncallback';
  static const String OAUTH_CALLBACK = 'oauth_callback';
  static const String OAUTH_CALLBACK_CONFIRMED = 'oauth_callback_confirmed';
  static const String OAUTH_CONSUMER_KEY = 'oauth_consumer_key';
  static const String OAUTH_NONCE = 'oauth_nonce';
  static const String OAUTH_SIGNATURE = 'oauth_signature';
  static const String OAUTH_SIGNATURE_METHOD = 'oauth_signature_method';
  static const String OAUTH_TIMESTAMP = 'oauth_timestamp';
  static const String OAUTH_TOKEN = 'oauth_token';
  static const String OAUTH_TOKEN_SECRET = 'oauth_token_secret';
  static const String OAUTH_VERIFIER = 'oauth_verifier';
  static const String OAUTH_VERSION = 'oauth_version';
}

class QueryValueConstant {
  static const String JSON = 'json';
  static const String VALUE_OAUTH_VERSION = '1.0';
  static const String HMAC_SHA1 = 'HMAC-SHA1';
}

class HttpString {
  static const String GET = "GET";
  static const String POST = "POST";
}
