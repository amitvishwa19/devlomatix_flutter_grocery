class API {
  API._();

  //static const baseUrl = 'http://10.0.2.2/devlomatix/api/v2';
  static const baseUrl = 'https://devlomatix.com/api/v2';
  static const loginUrl = baseUrl + '/login';
  static const registerUrl = baseUrl + '/register';
  static const refreshToken = baseUrl + '/refresh';
  static const user = baseUrl + '/user';

  static const grocerySlider = baseUrl + '/grocery/slider';
  static const groceryCategory = baseUrl + '/grocery/categories';
  static const products = baseUrl + '/grocery/products/';
  static const hotProducts = baseUrl + '/grocery/products/hot-products';
}
