import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:ubob/src/mvi_action.dart';
import 'package:ubob/src/mvi_result.dart';

abstract class MviActionsProcessor<A extends MviAction, R extends MviResult> {

  Observable<R> apply(Observable<A> actions) {
    final connectable = actions.publish();
    return Observable.merge(getActionProcessors(connectable));
  }

  List<Observable<R>> getActionProcessors(Observable<A> shared);

  Observable<R> connect(final Observable<A> shared, final StreamTransformer<A, R> streamTransformer) {
    return shared.transform(streamTransformer);
  }

}
