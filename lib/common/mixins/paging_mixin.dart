import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BaseCommonMethodMixin {
  void pagingControllerOnLoad<T>(
    int page,
    PagingController<int, T> pagingController,
    Either<BaseError, List<T>> either, {
    int limit = 10,
    String? errorMessage,
    Function(String)? onError,
    Function(List<T>)? onSuccess,
  }) {
    either.fold(
      (l) {
        final error = errorMessage ?? l.getError;
        pagingController.error = error;
        onError?.call(error);
      },
      (r) {
        //if page = first page key then clear the list
        if (page == pagingController.firstPageKey) {
          pagingController.itemList = <T>[];
        }
        final isLastPage = r.length < limit;
        if (isLastPage) {
          pagingController.appendLastPage(r);
        } else {
          pagingController.appendPage(r, page + 1);
        }
        onSuccess?.call(r);
      },
    );
  }

  void pagingControllerRemoveItem<T>(
    PagingController<int, T> pagingController,
    int index,
  ) {
    final oldList = pagingController.itemList;
    if (oldList == null) return;
    final newList = List.of(oldList);
    newList.removeAt(index);
    pagingController.itemList = newList;
  }

  void pagingControllerUpdateItem<T>(
    PagingController<int, T> pagingController,
    int index,
    T newItem,
  ) {
    final oldList = pagingController.itemList;
    if (oldList == null) return;
    final newList = List.of(oldList);
    newList[index] = newItem;
    pagingController.itemList = newList;
  }

  void pagingControllerAddItem<T>(
    PagingController<int, T> pagingController,
    T item, [
    int index = 0,
  ]) {
    final oldList = pagingController.itemList;
    if (oldList == null) return;
    final newList = List.of(oldList);
    newList.insert(index, item);
    pagingController.itemList = newList;
  }
}
