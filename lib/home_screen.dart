import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterhive/post_model.dart';
import 'package:flutterhive/posts_repository.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> listPosts = [];
  bool isLoading = false;

  late final PostsRepository _postsRepository = PostsRepository();

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  Future<void> getPosts() async {
    setState(() {
      isLoading = true;
    });
    try {
      int nExist = await _postsRepository.initialize('posts');
      if (nExist == 2) {
        print('1. Loading from API start...');
        final serverResponse = await _postsRepository.getPosts();
        listPosts = serverResponse;
        setState(() {
          isLoading = false;
        });
        print('2. Got data from API');
        await _postsRepository.savePostsLocally(
            posts: serverResponse,
            expirationDuration: const Duration(days: 10));
        print('3. Saved data to cache');
        print('4. Loading from API End...');
      } else if (nExist == 1) {
        print('Loading from local...');
        listPosts = await _postsRepository.fetchAllLocalPosts();
        setState(() {
          isLoading = false;
        });
      } else if (nExist == 0) {
        print('Loading from API start because of error...');
        final serverResponse = await _postsRepository.getPosts();
        listPosts = serverResponse;
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts ${listPosts.length}'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: AppinioSwiper(
                cardCount: listPosts.length,
                cardBuilder: (context, index) {
                  final post = listPosts[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff12253C).withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(2, 4), // Shadow position
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          width: double.infinity,
                          height: 600,
                          imageUrl:
                              post.images!.isNotEmpty ? post.images![0] : "",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) {
                            return Container(
                              width: double.infinity,
                              height: 600,
                              color: Colors.white60,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${post.businessName}',
                            style: const TextStyle(
                                color: Color(0xff142B46),
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${post.country}',
                            style: const TextStyle(
                                color: Color(0xff142B46),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${post.description}',
                            style: const TextStyle(
                                color: Color(0xff142B46),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
