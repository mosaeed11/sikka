# Sikka Architecture (بسيطة للمبتدئين)

## القرارات اللي اتثبتت
- State: Bloc/Cubit | Admin: Supabase Studio مؤقتاً
- Maps: Google Maps + Matching بسيط (وقت + مقاعد + مسافة)
- Rules: تأكيد Scheduled قبلها 30د + سعر نسبي + الكابتن بيأكد الكاش

## القاعدة الذهبية
```
UI (screens) -> Cubit -> Repo -> Supabase
```
ممنوع تنادي Supabase من الـ UI.

## الفولدرات
- `core/`: config + theme + router + widgets + utils (pricing + distance)
- `features/auth | captain | rides | bookings | wallet | ratings | notifications`
- كل feature: `data/` (repo + model) + `logic/` (cubit+state) + `presentation/` (screens)

## أهم الفلوهات
1. Captain ينشئ Ride (from/to/lat/lng + depart_at + seats + price)
2. Passenger يبحث -> `searchSimple` (فلترة وقت+مقاعد + ترتيب مسافة + أول 3)
3. Passenger يبعت Request -> Timer 10s في `RequestCubit` -> accept/reject/expired
4. Cash: الكابتن يدوس confirm -> يتسجل payment + يزيد outstanding
5. Rating متبادل + لو <=2.5 يظهر warning قبل القبول

## Supabase
- شغل `supabase/supabase_schema.sql` في SQL Editor
- اعمل bucketين: `avatars` public / `captain_docs` private
- حط URL + anonKey في `lib/core/config/supabase_config.dart`
- Admin: من Table Editor توافق على `captain_applications`

## اللي بعده بالترتيب
1. Auth شغال (login/register/splash)
2. Create + Search rides
3. Requests بالـ 10 ثواني + Realtime
4. Wallet + Ratings + Notifications
5. Google Map picker بدل الأرقام الثابتة + FCM push
