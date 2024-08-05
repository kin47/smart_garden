import 'package:smart_garden/common/widgets/textfields/search_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemSelection {
  final String title;
  final bool show;
  final bool selected;

  ItemSelection({
    required this.title,
    this.show = true,
    this.selected = false,
  });

  ItemSelection copyWith({
    bool? show,
    bool? selected,
  }) {
    return ItemSelection(
      title: title,
      show: show ?? this.show,
      selected: selected ?? this.selected,
    );
  }
}

class SelectionBottomSheetWidget extends StatefulWidget {
  final List<String> data;
  final List<int> selectedIndexes;
  final bool isRadio;
  final bool hasSelectAll;
  final bool hasRefreshButton;
  const SelectionBottomSheetWidget({
    Key? key,
    required this.data,
    this.selectedIndexes = const [],
    this.isRadio = true,
    this.hasSelectAll = false,
    this.hasRefreshButton = false,
  }) : super(key: key);

  @override
  State<SelectionBottomSheetWidget> createState() =>
      _SelectionBottomSheetWidgetState();
}

class _SelectionBottomSheetWidgetState
    extends State<SelectionBottomSheetWidget> {
  final searchController = TextEditingController();
  final List<ItemSelection> items = [];

  @override
  void initState() {
    items.addAll(widget.data.map((e) => ItemSelection(title: e)));
    for (final idx in widget.selectedIndexes) {
      items[idx] = items[idx].copyWith(selected: true);
    }

    super.initState();
  }

  void search(String key) {
    setState(() {
      final List<ItemSelection> copy = List.from(items);
      items.clear();
      items.addAll(
        copy
            .map(
              (e) => e.copyWith(
                show: e.title.toLowerCase().contains(key.trim().toLowerCase()),
              ),
            )
            .toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => submit(),
                    child: Container(
                      height: 4.h,
                      width: 32.h,
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // color: ColorUtils.gray4BackgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  AppBar(
                    toolbarHeight: 40,
                    title: Text(
                      "options".tr(),
                      // style: StyleUtils.title3
                      //     .copyWith(color: ColorUtils.typographyTitle),
                    ),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    leadingWidth: 70.w,
                    leading: widget.hasRefreshButton
                        ? TextButton(
                            onPressed: () => selectAll(value: false),
                            child: FittedBox(
                              child: Text(
                                "refresh".tr(),
                                // style: StyleUtils.buttonText2
                                //     .copyWith(color: ColorUtils.primaryColor),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    actions: [
                      if (!widget.isRadio)
                        TextButton(
                          onPressed: () => submit(),
                          child: FittedBox(
                            child: Text(
                              "confirm_dialog_ok_title".tr(),
                              // style: StyleUtils.buttonText2
                              //     .copyWith(color: ColorUtils.primaryColor),
                            ),
                          ),
                        ),
                    ],
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFieldSearch(
                    focusNode: FocusNode(),
                    searchTextController: searchController,
                    onSearch: search,
                    onChanged: search,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            if (!widget.isRadio && widget.hasSelectAll)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: TextButton(
                    onPressed: selectAll,
                    child: Text(
                      "select_all".tr(),
                      // style: StyleUtils.buttonText2
                      //     .copyWith(color: ColorUtils.primaryColor),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (c, i) => items[i].show
                      ? const Divider()
                      : const SizedBox.shrink(),
                  itemBuilder: (c, i) => items[i].show
                      ? InkWell(
                          onTap: () {
                            if (items[i].selected) {
                              if (widget.isRadio) {
                                //do nothing
                              } else {
                                setState(() {
                                  items[i] =
                                      items[i].copyWith(selected: false);
                                });
                              }
                            } else {
                              setState(() {
                                if (widget.isRadio) {
                                  submit(res: [i]);
                                } else {
                                  //multi Selection
                                  items[i] =
                                      items[i].copyWith(selected: true);
                                }
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    items[i].title,
                                    // style: StyleUtils.title6.copyWith(
                                    //   color: ColorUtils.typographyPrimaryText,
                                    // ),
                                  ),
                                ),
                                Container(
                                  height: 20.w,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: items[i].selected
                                        ? Border.all(
                                            width: 4.w,
                                            // color: ColorUtils.primaryColor,
                                          )
                                        : Border.all(
                                            // color: ColorUtils
                                            //     .typographyDisableColor,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  itemCount: items.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submit({List<int>? res}) {
    final List<int> result = [];
    if (res == null) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].selected) result.add(i);
      }
    }
    Navigator.pop(context, res ?? result);
  }

  void selectAll({bool value = true}) {
    setState(() {
      final List<ItemSelection> copy = List.from(items);
      items.clear();
      items.addAll(
        copy
            .map(
              (e) => e.copyWith(
                selected: value,
              ),
            )
            .toList(),
      );
    });
  }
}
