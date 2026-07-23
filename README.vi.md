# Or1g1n Brave

[English](./README.md) | Tiếng Việt

Tự động build APK Brave đã patch cho kiến trúc arm64-v8a. Bản build dùng Morphe CLI và hai bộ patch:

- `bufferk/morphe-patches`
- `MorpheApp/morphe-patches`

Package name đầu ra: `vip.dh6k.brave.or1g1n`.

APK đã patch cài song song với Brave chính thức. Nó không thay thế `com.brave.browser`.

## Tải xuống

Tải APK mới nhất tại [Releases](../../releases/latest).

Mục tiêu build hiện tại:

- Brave, arm64-v8a
- phiên bản tự chọn theo tính tương thích của patch
- patch gồm: `Brave Origin`
- patch bổ sung: `Change package name`

## Cài đặt

1. Tải `brave-or1g1n-*-arm64-v8a.apk` từ release mới nhất.
2. Cho phép cài đặt từ trình quản lý tệp hoặc trình duyệt khi Android hỏi.
3. Cài APK.
4. Mở **Or1g1n Brave**.

Có thể giữ Brave chính thức. Dữ liệu, tiện ích và cài đặt không tự chuyển vì package name khác nhau.

## Cập nhật

GitHub Actions tự build release. Cài APK mới đè lên ứng dụng `vip.dh6k.brave.or1g1n` hiện có để cập nhật.

Xem [release notes](../../releases) để biết phiên bản Brave, phiên bản bộ patch và tệp APK đã build.

## Khắc phục sự cố

### Passkey

> [!WARNING]
> Or1g1n Brave có chữ ký khác Brave chính thức. Password manager có thể coi đây là ứng dụng không nhận diện và từ chối tạo hoặc đăng nhập passkey. Xem [morphe-patches issue #18](https://github.com/bufferk/morphe-patches/issues/18).

#### QUAN TRỌNG: Tự động điền và mật khẩu

Để dùng mật khẩu, tự động điền và passkey, hãy dùng Bitwarden Android client chính thức: [Google Play](https://play.google.com/store/apps/details?id=com.x8bit.bitwarden) hoặc repo [bitwarden/android](https://github.com/bitwarden/android). Các client khác, gồm [Keyguard](https://github.com/AChep/keyguard-app), không dùng được passkey trên trình duyệt này.

Có thể thiết lập Bitwarden qua [bitwarden.com](https://bitwarden.com) hoặc [bitwarden.eu](https://bitwarden.eu). Nhu cầu nâng cao: self-host bằng [Nodewarden](https://github.com/shuaiplus/nodewarden), theo [hướng dẫn self-host Nodewarden](https://voz.vn/t/huong-dan-self-host-bitwarden-mien-phi-voi-cloudflare-workers.1253236/).

Self-host có thể tránh hỏi mã xác minh email nhiều lần và có một số tính năng premium, giúp giảm chi phí. Nhớ sao lưu hoặc dịch chuyển toàn bộ mật khẩu từ password manager khác trước khi chuyển đổi.

Bản build hiện tại dùng patch `Change package name` của Morphe với cả `Update Permissions` và `Update Providers`. Hãy cài release mới nhất trước khi thử passkey lại.

Với Bitwarden, bắt đầu đăng nhập passkey từ Or1g1n Brave. Khi Bitwarden yêu cầu tin cậy ứng dụng không nhận diện, hãy xác minh nó được mở bởi APK từ release của repo này, rồi chấp thuận. Sau đó thử lại.

Passkey thuộc website hoặc ứng dụng nơi chúng được tạo. Chúng không được chuyển cùng dữ liệu Brave.

Nếu đăng nhập passkey không xuất hiện hoặc thất bại:

1. Xác nhận website hỗ trợ passkey và dùng tùy chọn **Use a passkey** khi đăng nhập.
2. Vào Android **Settings** > **Passwords, passkeys & accounts**. Bật Bitwarden làm passkey provider.
3. Cập nhật Google Play services và Bitwarden, rồi khởi động lại Or1g1n Brave.
4. Kiểm tra passkey có trong Bitwarden và dùng đúng tài khoản đã tạo nó.
5. Đăng nhập bằng phương thức khôi phục, rồi tạo passkey mới nếu website báo passkey cũ không hợp lệ.

Không gỡ Brave chính thức cho đến khi passkey hoạt động trong Or1g1n Brave. Nó có thể vẫn cần cho dữ liệu trình duyệt cũ hoặc quyền truy cập khôi phục.

## Build local

Yêu cầu:

- Linux hoặc Termux
- Java 21
- `bash`, `curl`, `unzip` và các GNU utility thông dụng

Clone repo, rồi chạy:

```bash
./build.sh config.toml
```

APK build xong nằm trong `build/`.

Trợ giúp cho Termux:

```bash
bash <(curl -sSf https://raw.githubusercontent.com/dh6k/or1g1n/main/build-termux.sh)
```

## Cấu hình

[`config.toml`](./config.toml) điều khiển APK nguồn, package identity, bộ patch, patch được chọn và build mode. Xem thêm [`CONFIG.md`](./CONFIG.md).

## Giấy phép

Mã nguồn và tài liệu trong repository này dùng [GNU GPL v3.0](./LICENSE). Bạn được chạy, nghiên cứu, sửa đổi và phân phối lại chúng. Khi phân phối bản đã sửa đổi, phải cung cấp mã nguồn tương ứng và giữ GPL-3.0.

Phần mềm được cung cấp nguyên trạng, không có bảo hành. GPL-3.0 không cấp quyền đối với Brave, Morphe, Bitwarden, bộ patch bên thứ ba hoặc nhãn hiệu/tài sản của họ. Điều khoản của từng bên vẫn áp dụng; APK build có thể bao gồm thành phần bên thứ ba chịu điều khoản riêng.
