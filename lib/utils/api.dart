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
  static const hotProducts = baseUrl + '/grocery/products/hot';
  static const cart = baseUrl + '/cart';
  static const addToCart = baseUrl + '/cart/add';
  static const deleteFromCart = baseUrl + '/cart/delete';
  static const updateCart = baseUrl + '/cart/update';
  static const viewProduct = baseUrl + '/products/viewed';
  static const viewedRecent = baseUrl + '/products/viewed/recent';
  static const mostViewed = baseUrl + '/products/viewed/most';
  static const addToWishlist = baseUrl + '/wishlist/add';
  static const removeFrmWishlist = baseUrl + '/wishlist/remove';
  static const getWishlist = baseUrl + '/wishlist/get';
  static const productSearch = baseUrl + '/grocery/products/search';
}
