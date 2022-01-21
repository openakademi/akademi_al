

import 'package:flutter/material.dart';

import 'view/subjects_scene.dart';

class AsyncSubjectScene extends StatelessWidget {
  final GlobalKey<SubjectsSceneState> subjectKey;
  final bool search;

  const AsyncSubjectScene({Key key, this.subjectKey, this.search = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SubjectsScene(key: subjectKey, search: search,);
  }
}