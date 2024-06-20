import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_domain/common/value_object.dart';
import 'package:instagram_clone_domain/post/post.dart';

void main() {
  late Post sut;

  setUp(() {
    sut = const Post(
      id: "post-guid-id",
      description: "test post id",
      imageUrls: ["https://www.firebase.storage/wiowfghaohiwofweo"],
    );
  });

  group("Post", () {
    test("Should extend equatable", () {
      //Arrange
      //Act
      //Assert
      expect(sut, isA<Equatable>());
    });
  });
}
