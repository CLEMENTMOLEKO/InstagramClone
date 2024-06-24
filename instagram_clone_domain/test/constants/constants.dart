import 'package:instagram_clone_domain/common/common.dart';
import 'package:instagram_clone_domain/post/post.dart';
import 'package:instagram_clone_domain/user/user.dart';
import 'package:instagram_clone_domain/reel/reel.dart';

part 'constants_user.dart';
part 'constants_post.dart';
part 'constants_comment.dart';
part 'constants_reel.dart';

final class Constants {
  static const validUuids = {
    "123e4567-e89b-12d3-a456-426614174000",
    "550e8400-e29b-41d4-a716-446655440000",
    "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
    "f47ac10b-58cc-4372-a567-0e02b2c3d479",
    "9b2e5e4e-5e4e-4e5e-9b2e-5e4e5e4e5e4e"
  };

  static const invalidUuids = {
    "123e4567-e89b-12d3-a456-42661417400",
    "550e8400-e29b-41d4-a716-4466554400000",
    "6ba7b810-9dad-11d1-80b4-00c04fd430c",
    "f47ac10b-58cc-4372-a567-0e02b2c3d47g",
    "9b2e5e4e-5e4e-4e5e-9b2e-5e4e5e4e5e4"
  };

  static final likes = [
    UserConstants.arrangeUserId(userId: '6c84fb90-32c4-11e1-840d-7b25c5ee775a'),
    UserConstants.arrangeUserId(userId: '6c84fb90-52c4-11e1-840d-7b25c5ee775a'),
    UserConstants.arrangeUserId(userId: '6c84fb90-42c4-11e1-840d-7b25c5ee775a'),
    UserConstants.arrangeUserId(userId: '6c84fb90-82c4-11e1-840d-7b25c5ee775a'),
  ];
}
