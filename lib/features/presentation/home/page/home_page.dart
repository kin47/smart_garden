import 'package:auto_route/annotations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/utils/date_time/date_time_utils.dart';
import 'package:smart_garden/common/widgets/buttons/app_button.dart';
import 'package:smart_garden/common/widgets/cache_image_widget.dart';
import 'package:smart_garden/features/domain/entity/news_entity.dart';
import 'package:smart_garden/features/presentation/home/bloc/home_bloc.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState
    extends BaseState<HomePage, HomeEvent, HomeState, HomeBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const HomeEvent.init());
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CarouselSlider(
              items: [
                Assets.images.carouselSlider1.image(
                  width: 1.sw,
                  fit: BoxFit.cover,
                ),
                Assets.images.carouselSlider2.image(
                  width: 1.sw,
                  fit: BoxFit.cover,
                ),
                Assets.images.carouselSlider3.image(
                  width: 1.sw,
                  fit: BoxFit.cover,
                ),
              ],
              options: CarouselOptions(
                autoPlay: true,
                height: 250.h,
                viewportFraction: 1,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 16.h),
              child: Text(
                'Kit của tôi',
                style: AppTextStyles.s16w600,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.h).copyWith(top: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Assets.images.kitImage.image(
                    width: 200.w,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Kit 1',
                    style: AppTextStyles.s16w600,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Ngày kết nối: 22/08/2024',
                    style: AppTextStyles.s14w400,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 24.h),
              child: Text(
                'Tin tức mới nhất',
                style: AppTextStyles.s16w600,
              ),
            ),
          ),
          CustomSliverListViewSeparated<NewsEntity>(
            controller: bloc.pagingController,
            firstPageProgressIndicator: const SizedBox.shrink(),
            builder: (context, news, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CachedImageWidget(
                    url: news.thumbnail,
                    width: 100.w,
                    height: 100.w,
                    radius: 16.r,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${news.title}\n',
                          style: AppTextStyles.s16w600,
                          maxLines: 2,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          DateTimeUtils.getStringDate(
                            news.publishedAt,
                            Pattern.ddMMyyyyHHmm,
                          ),
                          style: AppTextStyles.s14w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w).copyWith(bottom: 40.h),
              child: AppButton(
                title: 'Xem thêm',
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
