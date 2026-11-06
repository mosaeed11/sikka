import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NoInternetState {}

class NoInternetInitial extends NoInternetState {}
class RetryingConnectionState extends NoInternetState {}
class OpenSettingsState extends NoInternetState {}
class ContactSupportState extends NoInternetState {}

class NoInternetCubit extends Cubit<NoInternetState> {
  NoInternetCubit() : super(NoInternetInitial());

  void retryConnection() {
    emit(RetryingConnectionState());
  }

  void openSettings() {
    emit(OpenSettingsState());
  }

  void contactSupport() {
    emit(ContactSupportState());
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NoInternetScreen(),
  ));
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoInternetCubit(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<NoInternetCubit, NoInternetState>(
          listener: (context, state) {
            if (state is RetryingConnectionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جاري محاولة الاتصال...')),
              );
            } else if (state is OpenSettingsState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('فتح إعدادات الجهاز...')),
              );
            } else if (state is ContactSupportState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('الانتقال لصفحة الدعم الفني...')),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<NoInternetCubit>();

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.wifi_off,
                                size: 14, color: Colors.grey.shade600),
                            const SizedBox(width: 4),
                            Text(
                              'غير متصل بالإنترنت',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.wifi_off_rounded,
                        color: Colors.red.shade400,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'مفيش اتصال بالإنترنت',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'تأكد من اتصالك بالواي فاي أو باقة الموبايل وحاول تاني عشان نكمل رحلتك.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () => cubit.retryConnection(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C53D4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.refresh,
                            color: Colors.white, size: 18),
                        label: const Text(
                          'حاول تاني',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => cubit.openSettings(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'فحص إعدادات الموبايل',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.warning_amber_rounded,
                                  size: 18, color: Colors.amber.shade800),
                              const SizedBox(width: 6),
                              Text(
                                'حصلت مشكلة بسيطة',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber.shade900,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'مش قادرين نكمل العملية دلوقتي. كل بياناتك محفوظة بأمان، جرب تاني بعد لحظات.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.amber.shade900,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () => cubit.retryConnection(),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: Icon(Icons.replay,
                                    size: 14, color: Colors.indigo.shade600),
                                label: Text(
                                  'إعادة المحاولة',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.indigo.shade600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 16),
                              TextButton.icon(
                                onPressed: () => cubit.contactSupport(),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: Icon(Icons.support_agent,
                                    size: 14, color: Colors.indigo.shade600),
                                label: Text(
                                  'تواصل مع الدعم',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.indigo.shade600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}