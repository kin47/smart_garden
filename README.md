# Đồ án tốt nghiệp
## Đề tài: 
Xây dựng hệ thống điều khiển chăm sóc chậu cây thông minh và ứng dụng học máy trong nhận diện cây bệnh

## Sinh viên thực hiện
- Tên: Trần Quang Minh 
- Mã sinh viên: B20DCCN443
- Trường: PTIT miền Bắc

## Giảng viên hướng dẫn
TS. Đào Ngọc Phong

## Mô tả đồ án
Hệ thống chăm sóc cây thông minh hỗ trợ người dùng có thể quản lý, điều khiển tự động hoặc thủ công việc tưới nước, chiếu sáng thông qua ứng dụng trên thiết bị di động có kết nối với các thiết bị cảm biến. Hệ thống cập nhật tức thời và có các cảnh báo về môi trường (nhiệt độ, độ ẩm, ánh sáng). Bên cạnh đó, để giúp người dùng có thể kịp thời phát hiện và xử lý các loại bệnh đối với cây trồng, ứng dụng được tích hợp chức năng nhận diện lá cây bệnh sử dụng mô hình học máy. Hệ thống có khả năng ứng dụng trong việc trồng và chăm sóc cây tại hộ gia đình

## Công nghệ sử dụng cho App
- Flutter 3.22.2
- Mô hình: Clean Architecture (Domain, Data, Presentation)
- Quản lý state: Bloc
- Quản lý router: AutoRoute
- Quản lý dependency: GetIt
- Quản lý API: Dio, Retrofit

### Các loại tương tác dữ liệu:
- Restful API: cho các tương tác với server
- WebSocket: Cho tính năng Chat
- MQTT: tương tác với thiết bị cảm biến (ESP32)
- Local Storage: Lưu trữ dữ liệu cục bộ
- Secure Storage: Lưu trữ dữ liệu nhạy cảm

## Thiết kế vật lý hệ thống

![thiet_ke_vat_ly_he_thong.png](readme_instructions%2Fthiet_ke_vat_ly_he_thong.png)

## Điểm đồ án
- 9.5/10