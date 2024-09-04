class ConstantApi {

  String getAllMovies(String page) {
    return "https://api.themoviedb.org/3/movie/popular?api_key=b4e0644efa9c3b27b91c3b8565b06e39&page=$page";
  }
  String search(String query) {
    return "https://api.themoviedb.org/3/search/movie?api_key=b4e0644efa9c3b27b91c3b8565b06e39&query=$query";
  }

}
