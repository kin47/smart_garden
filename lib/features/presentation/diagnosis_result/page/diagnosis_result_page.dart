import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/utils/functions/common_functions.dart';
import 'package:smart_garden/common/widgets/cache_image_widget.dart';

@RoutePage()
class DiagnosisResultPage extends StatefulWidget {
  const DiagnosisResultPage({super.key});

  @override
  State<DiagnosisResultPage> createState() => _DiagnosisResultPageState();
}

class _DiagnosisResultPageState extends State<DiagnosisResultPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'diagnosis_result'.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWidget(
              url:
                  'https://vuonbabylon.vn/wp-content/uploads/2021/10/ta-cay-ca-chua.jpg',
              width: 1.sw,
              height: 250.h,
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Cây cà chua',
                      style: AppTextStyles.s20w700,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Chẩn đoán bệnh: Bệnh thối thân',
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Điều trị:',
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Có điều kiện thì nên trồng trong nhà màng để kiểm soát ẩm độ khi canh tác trong mùa mưa.\nKiểm tra và chọn nguồn giống sạch bệnh hoặc xử lý bằng Norshield 86.2WG, AgriLife 100SL cho các lô cây giống nhập vườn.\nXử lý mặt luống trước khi trồng bằng Norshield 86.2WG hoặc Norshield 58WP (pha 1 – 1.5g thuốc/ 1 lít nước tưới 1m2 luống trồng)\nTạo điều kiện thông thoáng cho ruộng cà chua như mật độ trồng hợp lý, dọn tỉa lá gốc, lá nhiểm bệnh. Tàn dư thưc vật vụ trước phải được thu gom, đem ra khỏi vườn, tiêu hủy.\nKhông trồng cây cùng họ cà liên tục nhiều vụ hoặc nhiều năm trên cùng một ruộng mà nên luân canh với cây khác họ và cần thời gian phơi đất giữa 2 vụ.\nSử dụng thuốc phòng và trị khi bệnh phát triển, phun ngừa bằng Norshield 86.2WG (25g/ bình 20lít), phun trị bằng Envio 250SC (20ml/ bình 20 lít) hoặc phối trộn Envio 250SC + AgriLife 100SL (20ml+20ml/ 20lít)",
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Tham khảo:',
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await launchLink(
                          "https://www.hoptri.com/quy-trinh-giai-phap/cay-trong-khac/phong-tru-benh-hai-cay-ca-chua");
                    },
                    child: Text(
                      'https://www.hoptri.com/quy-trinh-giai-phap/cay-trong-khac/phong-tru-benh-hai-cay-ca-chua',
                      style: AppTextStyles.s14w400.copyWith(
                        color: AppColors.textLink,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textLink,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
