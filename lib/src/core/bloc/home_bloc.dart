
import 'package:rxdart/subjects.dart';
import 'package:yanapay_app/src/core/models/YanapayPost.dart';

class HomeBloc {

  static final _singleton = HomeBloc._();

  factory HomeBloc() => _singleton;

  HomeBloc._();

  BehaviorSubject<List<YanapayPost>> _postsController = BehaviorSubject<List<YanapayPost>>();

  Stream<List<YanapayPost>> get postsStream => _postsController.stream;

  Function(List<YanapayPost>) get changePosts => _postsController.sink.add;

  List<YanapayPost> get posts => _postsController.value;

  void addNewPost(YanapayPost mPost) {
    List<YanapayPost> currentPosts = posts ?? List<YanapayPost>();
    currentPosts.add(mPost);
    changePosts(currentPosts);
  }

  void dispose() {
    _postsController?.close();
  }

}

HomeBloc homeBloc = HomeBloc();