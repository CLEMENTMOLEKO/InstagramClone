import 'package:instagram_clone_application/authentication/validators/email_input_validator.dart';
import 'package:instagram_clone_application/authentication/validators/password_input_validator.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_application/post/post.dart';
import 'package:instagram_clone_application/reel/reel.dart';
import 'package:instagram_clone_application/user/user.dart';

part 'constants_comment_dto.dart';
part 'constants_post_dto.dart';
part 'constants_reel_dto.dart';
part 'constants_user_dto.dart';
part 'constants_validators.dart';

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
}
