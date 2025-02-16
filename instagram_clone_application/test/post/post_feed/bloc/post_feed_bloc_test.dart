import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
  });

  test("Should have initial state as PostFeedState.initial()", () {
    final bloc = PostFeedBloc(postRepository: mockPostRepository);
    expect(bloc.state, PostFeedState.initial());
  });

  group("PostFeedFetched", () {
    final post = Post.createPost(
      id: PostId.createUnique(),
      userId: UserId.createUnique(),
      description: "Some dummy post",
      date: DateTime.now(),
    ).getOrElse(() => throw Exception("Failed to create post"));
    final postFeedState = PostFeedState(
      status: PostFeedStatus.stale,
      posts: [post],
      hasReachedMax: true,
    );
    blocTest<PostFeedBloc, PostFeedState>(
      "Should return current state and not emit anything when hasReachedMax is true",
      seed: () => postFeedState,
      build: () => PostFeedBloc(postRepository: mockPostRepository),
      act: (bloc) => bloc.add(PostFeedFetched()),
      verify: (_) => verifyNever(
        () => mockPostRepository.getPosts(
          limit: any(named: "limit"),
          offset: any(named: "offset"),
        ),
      ),
      expect: () => <PostFeedState>[], //Nothing should be emitted
    );

    blocTest<PostFeedBloc, PostFeedState>(
      "Should loading and return success state when getPosts is successful",
      setUp: () {
        when(() => mockPostRepository.getPosts(
              limit: any(named: "limit"),
              offset: any(named: "offset"),
            )).thenAnswer((_) async => right([post]));
      },
      build: () => PostFeedBloc(postRepository: mockPostRepository),
      act: (bloc) => bloc.add(PostFeedFetched()),
      expect: () => <PostFeedState>[
        PostFeedState.initial().copyWith(status: PostFeedStatus.loading),
        PostFeedState.initial().copyWith(
          status: PostFeedStatus.success,
          posts: [post],
          hasReachedMax: false,
        ),
      ],
    );

    blocTest<PostFeedBloc, PostFeedState>(
      "Should return failure state when getPosts is unsuccessful",
      setUp: () {
        when(
          () => mockPostRepository.getPosts(
            limit: any(named: "limit"),
            offset: any(named: "offset"),
          ),
        ).thenAnswer((_) async => left(ApplicationFailure.errorGettingPost));
      },
      build: () => PostFeedBloc(postRepository: mockPostRepository),
      act: (bloc) => bloc.add(PostFeedFetched()),
      expect: () => <PostFeedState>[
        PostFeedState.initial().copyWith(status: PostFeedStatus.loading),
        PostFeedState.initial().copyWith(status: PostFeedStatus.failure),
      ],
    );
  });
}
