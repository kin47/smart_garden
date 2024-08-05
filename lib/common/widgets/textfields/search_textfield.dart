import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldSearch extends StatefulWidget {
  const CustomTextFieldSearch({
    Key? key,
    this.focusNode,
    this.searchTextController,
    this.onSearch,
    this.onChanged,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController? searchTextController;
  final Function(String)? onSearch;
  final Function(String)? onChanged;

  @override
  State<CustomTextFieldSearch> createState() => _CustomTextFieldSearchState();
}

class _CustomTextFieldSearchState extends State<CustomTextFieldSearch> {
  late TextEditingController _searchTextController;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    _searchTextController =
        widget.searchTextController ?? TextEditingController();
    _searchTextController.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: _searchTextController,
      // style: StyleUtils.textNormal14Style.copyWith(
      //   color: ColorUtils.typographyPrimaryText,
      // ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: 8.w,
        ),
        isDense: true,
        // fillColor: ColorUtils.bgGreyBackground,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        filled: true,
        // hintStyle: StyleUtils.textNormal14Style.copyWith(
        //   color: ColorUtils.typographySubtitle,
        // ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 26.w,
          maxWidth: 26.w,
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Icon(Icons.search),
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 30.w,
          maxWidth: 30.w,
        ),
        suffixIcon: _searchTextController.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  //clear text when tap icon clear
                  _searchTextController.text = '';
                  widget.onSearch?.call(_searchTextController.text.trim());
                },
                child: const Icon(Icons.close),
              )
            : const SizedBox(),
        hintText: 'hint_input_search'.tr(),
      ),
      onChanged: (value) {
        widget.onChanged?.call(value.trim());
      },
      onSubmitted: (value) {
        widget.onSearch?.call(value.trim());
        _searchTextController.text = value.trim();
      },
    );
  }
}
