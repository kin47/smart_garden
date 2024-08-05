import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'index.dart';

class CustomSliverListView<T> extends StatelessWidget {
  final PagingController<int, T> controller;
  final Widget Function(BuildContext, T, int) builder;
  final Widget? emptyWidget;
  final Widget? firstPageProgressIndicator;
  final Widget? newPageProgressIndicatorBuilder;
  final bool shrinkWrapFirstPageIndicators;
  final VoidCallback? onRefresh;
  final double? itemExtent;
  final Color? loadingBackgroundColor;

  const CustomSliverListView({
    Key? key,
    required this.controller,
    required this.builder,
    this.emptyWidget,
    this.shrinkWrapFirstPageIndicators = false,
    this.onRefresh,
    this.itemExtent,
    this.loadingBackgroundColor,
    this.firstPageProgressIndicator,
    this.newPageProgressIndicatorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, T>(
      pagingController: controller,
      itemExtent: itemExtent,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: builder,
        noItemsFoundIndicatorBuilder: (_) => emptyWidget ?? const EmptyWidget(),
        firstPageProgressIndicatorBuilder: (_) =>
        firstPageProgressIndicator ??
            Container(
              color: loadingBackgroundColor ?? Colors.transparent,
              height: 200,
              child: Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
              ),
            ),
        firstPageErrorIndicatorBuilder: (_) => Column(
          children: [
            Text(controller.error),
            ElevatedButton(
              onPressed: onRefresh ?? () => controller.refresh(),
              child: const Text('Tải lại trang'),
            )
          ],
        ),
        newPageProgressIndicatorBuilder: (_) => Center(
          child: newPageProgressIndicatorBuilder ??
              const CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class CustomListView<T> extends StatelessWidget {
  final PagingController<int, T> controller;
  final Widget Function(BuildContext, T, int) builder;
  final Widget emptyWidget;
  final Widget? firstPageProgressIndicator;
  final bool shrinkWrap;
  final VoidCallback? onRefresh;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final EdgeInsets? padding;

  const CustomListView({
    Key? key,
    required this.controller,
    required this.builder,
    this.emptyWidget = const SizedBox.shrink(),
    this.shrinkWrap = false,
    this.onRefresh,
    this.physics,
    this.scrollController,
    this.padding,
    this.firstPageProgressIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>(
      scrollController: scrollController,
      pagingController: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: builder,
        noItemsFoundIndicatorBuilder: (_) => emptyWidget,
        firstPageProgressIndicatorBuilder: (_) =>
        firstPageProgressIndicator ??
            const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        firstPageErrorIndicatorBuilder: (_) => Column(
          children: [
            Text(controller.error),
            ElevatedButton(
              onPressed: onRefresh ?? () => controller.refresh(),
              child: const Text('Click to reload'),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSliverListViewSeparated<T> extends StatelessWidget {
  final PagingController<int, T> controller;
  final Widget Function(BuildContext, T, int) builder;
  final Widget Function(BuildContext, int) separatorBuilder;
  final Widget? emptyWidget;
  final Widget? firstPageProgressIndicator;
  final bool shrinkWrapFirstPageIndicators;
  final VoidCallback? onRefresh;
  final double? itemExtent;
  final Color? loadingBackgroundColor;

  const CustomSliverListViewSeparated({
    Key? key,
    required this.controller,
    required this.builder,
    this.emptyWidget,
    this.shrinkWrapFirstPageIndicators = false,
    this.onRefresh,
    this.itemExtent,
    this.loadingBackgroundColor,
    required this.separatorBuilder,
    this.firstPageProgressIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, T>.separated(
      pagingController: controller,
      itemExtent: itemExtent,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      separatorBuilder: separatorBuilder,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: builder,
        noItemsFoundIndicatorBuilder: (_) => emptyWidget ?? const EmptyWidget(),
        firstPageProgressIndicatorBuilder: (_) =>
        firstPageProgressIndicator ??
            Container(
              color: loadingBackgroundColor ?? Colors.transparent,
              height: 200,
              child: Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
              ),
            ),
        firstPageErrorIndicatorBuilder: (_) => Column(
          children: [
            Text(controller.error),
            ElevatedButton(
              onPressed: onRefresh ?? () => controller.refresh(),
              child: const Text('Click to reload'),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListViewSeparated<T> extends StatelessWidget {
  final PagingController<int, T> controller;
  final Widget Function(BuildContext, T, int) builder;
  final Widget Function(BuildContext, int) separatorBuilder;
  final Widget emptyWidget;
  final Widget? firstPageProgressIndicator;
  final bool shrinkWrap;
  final VoidCallback? onRefresh;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final Widget? newPageProgressIndicatorBuilder;
  final Widget? newPageErrorIndicatorBuilder;
  final Widget? firstPageErrorIndicator;

  const CustomListViewSeparated({
    Key? key,
    required this.controller,
    required this.builder,
    required this.separatorBuilder,
    this.emptyWidget = const SizedBox.shrink(),
    this.shrinkWrap = false,
    this.onRefresh,
    this.physics,
    this.scrollController,
    this.padding,
    this.firstPageProgressIndicator,
    this.newPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.firstPageErrorIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>.separated(
      scrollController: scrollController,
      pagingController: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: builder,
        noItemsFoundIndicatorBuilder: (_) => emptyWidget,
        firstPageProgressIndicatorBuilder: (_) =>
        firstPageProgressIndicator ??
            const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        firstPageErrorIndicatorBuilder: (_) => firstPageErrorIndicator ?? Column(
          children: [
            Text(controller.error),
            ElevatedButton(
              onPressed: onRefresh ?? () => controller.refresh(),
              child: const Text('Click to reload'),
            )
          ],
        ),
        newPageProgressIndicatorBuilder: (_) {
          if (newPageProgressIndicatorBuilder != null) {
            return newPageProgressIndicatorBuilder!;
          } else {
            return SizedBox(
              height: 60.h,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
        },
        newPageErrorIndicatorBuilder: (_) => InkWell(
          onTap: controller.retryLastFailedRequest,
          child: newPageErrorIndicatorBuilder ??
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bấm để tải lại',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Icon(
                    Icons.refresh,
                    size: 16,
                  ),
                ],
              ),
        ),
      ),
      separatorBuilder: separatorBuilder,
    );
  }
}

class CustomSliverGridView<T> extends StatelessWidget {
  final PagingController<int, T> controller;
  final Widget Function(BuildContext, T, int) builder;
  final Widget? emptyWidget;
  final Widget? firstPageProgressIndicator;
  final Widget? newPageProgressIndicatorBuilder;
  final bool shrinkWrapFirstPageIndicators;
  final bool? showNewPageProgressIndicatorAsGridChild;
  final VoidCallback? onRefresh;
  final double? itemExtent;
  final Color? loadingBackgroundColor;
  final SliverGridDelegate delegate;
  final Widget? firstPageErrorIndicatorBuilder;
  final Widget? newPageErrorIndicatorBuilder;

  const CustomSliverGridView({
    Key? key,
    required this.controller,
    required this.builder,
    required this.delegate,
    this.emptyWidget,
    this.shrinkWrapFirstPageIndicators = false,
    this.showNewPageProgressIndicatorAsGridChild,
    this.onRefresh,
    this.itemExtent,
    this.loadingBackgroundColor,
    this.firstPageProgressIndicator,
    this.newPageProgressIndicatorBuilder,
    this.firstPageErrorIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedSliverGrid<int, T>(
      pagingController: controller,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      showNewPageProgressIndicatorAsGridChild:
      showNewPageProgressIndicatorAsGridChild ?? true,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: builder,
        newPageProgressIndicatorBuilder: (_) => Center(
          child: newPageProgressIndicatorBuilder ??
              const CupertinoActivityIndicator(),
        ),
        noItemsFoundIndicatorBuilder: (_) => emptyWidget ?? const EmptyWidget(),
        firstPageProgressIndicatorBuilder: (_) =>
        firstPageProgressIndicator ??
            Container(
              color: loadingBackgroundColor ?? Colors.transparent,
              height: 200,
              child: Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
              ),
            ),
        firstPageErrorIndicatorBuilder: (_) =>
        firstPageErrorIndicatorBuilder ??
            Column(
              children: [
                Text(controller.error),
                ElevatedButton(
                  onPressed: onRefresh ?? () => controller.refresh(),
                  child: const Text('Tải lại trang'),
                )
              ],
            ),
        newPageErrorIndicatorBuilder: (_) => InkWell(
          onTap: controller.retryLastFailedRequest,
          child: newPageErrorIndicatorBuilder ??
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bấm để tải lại',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Icon(
                    Icons.refresh,
                    size: 16,
                  ),
                ],
              ),
        ),
      ),
      gridDelegate: delegate,
    );
  }
}

class CustomGridView<T> extends StatelessWidget {
  final PagingController<int, T> controller;
  final Widget Function(BuildContext, T, int) builder;
  final Widget? emptyWidget;
  final Widget? firstPageProgressIndicator;
  final bool shrinkWrapFirstPageIndicators;
  final VoidCallback? onRefresh;
  final double? itemExtent;
  final Color? loadingBackgroundColor;
  final SliverGridDelegate delegate;

  const CustomGridView({
    Key? key,
    required this.controller,
    required this.builder,
    required this.delegate,
    this.emptyWidget,
    this.shrinkWrapFirstPageIndicators = false,
    this.onRefresh,
    this.itemExtent,
    this.loadingBackgroundColor,
    this.firstPageProgressIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, T>(
      pagingController: controller,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: builder,
        noItemsFoundIndicatorBuilder: (_) => emptyWidget ?? const EmptyWidget(),
        firstPageProgressIndicatorBuilder: (_) =>
        firstPageProgressIndicator ??
            Container(
              color: loadingBackgroundColor ?? Colors.transparent,
              height: 200,
              child: Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
              ),
            ),
        firstPageErrorIndicatorBuilder: (_) => Column(
          children: [
            Text(controller.error),
            ElevatedButton(
              onPressed: onRefresh ?? () => controller.refresh(),
              child: const Text('Tải lại trang'),
            )
          ],
        ),
      ),
      gridDelegate: delegate,
    );
  }
}
