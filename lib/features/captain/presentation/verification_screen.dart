import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../logic/captain_cubit.dart';
import '../logic/captain_state.dart';

class AccountRestrectionScreen extends StatelessWidget {
  const AccountRestrectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CaptainCubit(),
      child: const _AccountRestrectionBody(),
    );
  }
}

class _AccountRestrectionBody extends StatelessWidget {
  const _AccountRestrectionBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptainCubit, CaptainState>(
      builder: (context, state) {
        final cubit = context.read<CaptainCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF3525CD),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => cubit.clickBack(context),
                          icon: SvgPicture.asset(
                            'assets/icons/Container.svg',
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Active ride Tracking',
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'سِكّة',
                            style: GoogleFonts.sourceSerif4(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF3525CD),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'SIKKA',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6B7280),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => cubit.clickBack(context),
                        icon: SvgPicture.asset('assets/icons/Icon.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'إدارة قيود الحسابات وحالات النظام',
                        textAlign: TextAlign.end,
                        style: GoogleFonts.sourceSerif4(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF141B2B),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'معاينةاستجابات التطبيق لحالات التعليق ,التوثيق ,الدفع',
                        style: GoogleFonts.sourceSerif4(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 22,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE1E8FD),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF59E0B),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              state.badgeText,
                              style: GoogleFonts.sourceSerif4(
                                color: const Color(0xFF0F0069),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildTabButton(
                            title: 'توثيق الكابتن',
                            iconPath: 'assets/icons/verify.svg',
                            isSelected: state.selectedTab == 0,
                            onTap: () => cubit.changeTab(0),
                          ),
                          const SizedBox(width: 8),
                          _buildTabButton(
                            title: 'حساب موقوف (مديونية)',
                            iconPath: 'assets/icons/apeal.svg',
                            isSelected: state.selectedTab == 1,
                            onTap: () => cubit.changeTab(1),
                          ),
                          const SizedBox(width: 8),
                          _buildTabButton(
                            title: 'حالات الدفع',
                            iconPath: 'assets/icons/money.svg',
                            isSelected: state.selectedTab == 2,
                            onTap: () => cubit.changeTab(2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE9EDFF),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/account.svg',
                                width: 32,
                                height: 36,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF59E0B),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/lock.svg',
                                  width: 13.33,
                                  height: 17.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.accountTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSerif4(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF141B2B),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: SizedBox(
                      width: 290,
                      child: Text(
                        state.accountDescription,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSerif4(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF464555),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F3FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'حالة فحص المستندات',
                                style: GoogleFonts.sourceSerif4(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF141B2B),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'قيد المراجعة (2/4)',
                                style: GoogleFonts.sourceSerif4(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFF59E0B),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const SizedBox(
                              height: 7,
                              child: LinearProgressIndicator(
                                value: 0.5,
                                backgroundColor: Color(0xFFDDE3F8),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF3525CD),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDocItem(
                                  title: 'بطاقة الرقم القومي',
                                  icon: const Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Color(0xFF10B981),
                                    size: 18,
                                  ),
                                  textColor: const Color(0xFF10B981),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildDocItem(
                                  title: 'رخصة القيادة السارية',
                                  icon: const Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Color(0xFF10B981),
                                    size: 18,
                                  ),
                                  textColor: const Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDocItem(
                                  title: 'رخصة السيارة وفحص الأمان',
                                  icon: const Icon(
                                    Icons.more_horiz_rounded,
                                    color: Color(0xFFF59E0B),
                                    size: 20,
                                  ),
                                  textColor: const Color(0xFFF59E0B),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildDocItem(
                                  title: 'الفيش الجنائي (قيد الرفع)',
                                  icon: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF6B7280),
                                        width: 1.8,
                                      ),
                                    ),
                                  ),
                                  textColor: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 310,
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: () => cubit.clickUploadDocuments(context),
                      icon: SvgPicture.asset(
                        'assets/icons/upload.svg',
                        width: 13.33,
                        height: 16.67,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3525CD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      label: Text(
                        'عرض حالة التحقق ورفع المستندات',
                        style: GoogleFonts.sourceSerif4(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 310,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () => cubit.clickCreateRide(context),
                      icon: SvgPicture.asset(
                        'assets/icons/add.svg',
                        width: 15,
                        height: 15,
                        colorFilter: ColorFilter.mode(
                          state.canCreateRide
                              ? Colors.white
                              : const Color(0xFF6B7280),
                          BlendMode.srcIn,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.canCreateRide
                            ? const Color(0xFF3525CD)
                            : const Color(0xFFDCE2F7),
                        elevation: state.canCreateRide ? 2 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      label: Text(
                        state.canCreateRide
                            ? 'إنشاء رحلة جديدة'
                            : 'إنشاء رحلة جديدة(معطل)',
                        style: GoogleFonts.sourceSerif4(
                          fontWeight: FontWeight.w700,
                          color: state.canCreateRide
                              ? Colors.white
                              : const Color(0xFF6B7280),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFFF59E0B),
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'إنشاء الرحلات معطّل مؤقتًا حتى اعتماد الحساب.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSerif4(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4B5563),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/icons/sikkalogo.png',
                      width: 64,
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'نظام أمان سِكّة يراقب موثوقية الهوية وحسابات الدفع لضمان تنقل آمن وعادل لكل مجتمع الطريق في مصر.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSerif4(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabButton({
    required String title,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141B2B) : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1,
                ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 14,
              height: 14,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : const Color(0xFF6B7280),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.sourceSerif4(
                color: isSelected ? Colors.white : const Color(0xFF6B7280),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocItem({
    required String title,
    required Widget icon,
    required Color textColor,
  }) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.sourceSerif4(
              color: textColor,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
