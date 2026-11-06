import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppState {}
class AppInitial extends AppState {}
class CancellationConfirmed extends AppState {}
class RideContinued extends AppState {}
class RatingChanged extends AppState {}

class CancellationCubit extends Cubit<AppState> {
  CancellationCubit() : super(AppInitial());

  void confirmCancellation() {
    emit(CancellationConfirmed());
  }

  void continueRide() {
    emit(RideContinued());
  }

  void changedRating() {
    emit(RatingChanged());
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CancellationCubit(),
        child: const CancelTripScreen(),
      ),
    );
  }
}

class CancelTripScreen extends StatelessWidget {
  const CancelTripScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<CancellationCubit, AppState>(
        listener: (context, state) {
          if (state is CancellationConfirmed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تأكيد إلغاء الرحلة')),
            );
            Navigator.pop(context);
          } else if (state is RideContinued) {
            // العودة أو إكمال الرحلة
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<CancellationCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'تأكيد الإلغاء',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.red.shade400,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'عايز تلغي الرحلة؟',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'تقدر تحتفظ بمقعدك وتكمل مشوارك براحة وأمان، لو كملت رحلتك.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded,
                                    size: 16, color: Colors.indigo.shade400),
                                const SizedBox(width: 4),
                                Text(
                                  'اليوم ٠٤:٣٠ م',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.indigo.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'تفاصيل السير الحالي',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.circle,
                                    size: 10, color: Colors.blue),
                                Container(
                                  height: 30,
                                  width: 2,
                                  color: Colors.grey.shade300,
                                ),
                                const Icon(Icons.location_on,
                                    size: 12, color: Colors.indigo),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'نقطة الركوب',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey.shade500),
                                  ),
                                  const Text(
                                    'المعادي (محطة مترو ثكنات المعادي)',
                                    style: TextStyle(
                                        fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    'الوصول',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey.shade500),
                                  ),
                                  const Text(
                                    'التجمع الخامس (شارع التجميع الشمالي)',
                                    style: TextStyle(
                                        fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'كابتن أحمد محمود',
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'نيسان صني • رمادي سيلفر',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.amber),
                                SizedBox(width: 2),
                                Text(
                                  '٤.٩',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                size: 16, color: Colors.indigo.shade700),
                            const SizedBox(width: 6),
                            Text(
                              'قاعدة الإلغاء ونظام التقييم في سِكّة',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'بعد أول ٥ رحلات ملغية، كل رحلتين إضافيتين بنخصم ٠.١ من تقييمك العام في التطبيق.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.indigo.shade900,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.continueRide();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C53D4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'الاحتفاظ بالرحلة ومتابعة المشوار',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {
                        cubit.confirmCancellation();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red.shade200),
                        backgroundColor: Colors.red.shade50.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, size: 16, color: Colors.red.shade400),
                          const SizedBox(width: 4),
                          Text(
                            'تأكيد إلغاء الرحلة',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}