import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MinkycscreenController extends GetxController {
  var pan = ''.obs;
  var isButtonEnabled = false.obs;
  var otp = ''.obs;
  var panError = ''.obs;

  bool _isValidPan(String value) {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value);
  }

  void onPanChanged(String value) {
    pan.value = value;
    if (value.isEmpty) {
      panError.value = '';
    } else if (!_isValidPan(value)) {
      panError.value = 'Invalid PAN format (e.g. ABCDE1234F)';
    } else {
      panError.value = '';
    }
    isButtonEnabled.value = _isValidPan(value);
  }

  void showOtpBottomSheet(BuildContext context) {
    Get.dialog(
      _OtpDialog(
        onVerified: () {
          Get.back();
          showSuccessDialog();
        },
      ),
      barrierDismissible: false,
      barrierColor: Colors.black54,
    );
  }

  void showSuccessDialog() {
    Get.dialog(
      const _KycSuccessDialog(),
      barrierDismissible: false,
      barrierColor: Colors.black54,
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.to(
        () => const _CreateMpinScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 400),
      );
    });
  }
}

class _OtpDialog extends StatefulWidget {
  final VoidCallback onVerified;
  const _OtpDialog({required this.onVerified});

  @override
  State<_OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<_OtpDialog> {
  static const _primaryRed = Color(0xFFE53935);

  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  String _otp = '';
  int _secondsLeft = 60;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted && _otp.isEmpty) {
        _simulateAutoFetch();
      }
    });
  }

  void _simulateAutoFetch() {
    final code = "4826";
    for (int i = 0; i < 4; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _controllers[i].text = code[i];
          if (i == 3) {
            setState(() {
              _otp = code;
            });
            _focusNodes[3].unfocus();
          } else {
            _focusNodes[i + 1].requestFocus();
          }
        }
      });
    }

    Get.snackbar(
      'Auto-Fill Success',
      'Securely fetched & verified OTP code 4826',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF22C55E),
      colorText: Colors.white,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsLeft = 60;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 1) {
        t.cancel();
        setState(() {
          _secondsLeft = 0;
          _canResend = true;
        });
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _resend() {
    for (final c in _controllers) c.clear();
    setState(() => _otp = '');
    _startTimer();
  }

  String get _timerLabel {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cancel Icon Top Right
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 12),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: _primaryRed.withOpacity(0.06),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _primaryRed.withOpacity(0.12),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.shield_rounded,
                        color: _primaryRed,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Security Verification',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111111),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'We have sent a 4-digit verification code to\nyour secure mobile number.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // OTP boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (i) {
                        return Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _controllers[i],
                            focusNode: _focusNodes[i],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF111111),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE5E7EB),
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE5E7EB),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: _primaryRed,
                                  width: 2.2,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              if (val.isNotEmpty && i < 3) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodes[i + 1]);
                              } else if (val.isEmpty && i > 0) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodes[i - 1]);
                              }
                              setState(() {
                                _otp = _controllers.map((c) => c.text).join();
                              });
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),

                    // Countdown / Resend Capsule
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _canResend
                            ? const Color(0xFFFFF5F5)
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: _canResend
                              ? _primaryRed.withOpacity(0.15)
                              : Colors.black.withOpacity(0.04),
                        ),
                      ),
                      child: _canResend
                          ? GestureDetector(
                              onTap: _resend,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.refresh_rounded,
                                    size: 14,
                                    color: _primaryRed,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Resend Code',
                                    style: TextStyle(
                                      color: _primaryRed,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Resend in $_timerLabel',
                                  style: const TextStyle(
                                    color: Color(0xFF555555),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 24),

                    // Verify button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _otp.length == 4 ? widget.onVerified : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF111111),
                          disabledBackgroundColor: const Color(0xFFE5E7EB),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Verify & Proceed',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: _otp.length == 4
                                  ? Colors.white
                                  : Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KycSuccessDialog extends StatefulWidget {
  const _KycSuccessDialog();

  @override
  State<_KycSuccessDialog> createState() => _KycSuccessDialogState();
}

class _KycSuccessDialogState extends State<_KycSuccessDialog>
    with SingleTickerProviderStateMixin {
  static const _green = Color(0xFF22C55E);
  static const _primaryRed = Color(0xFFE53935);

  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── top red accent bar ──────────────────────────────
                    Container(
                      height: 5,
                      width: 48,
                      decoration: BoxDecoration(
                        color: _primaryRed,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── animated check circle ───────────────────────────
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _green.withOpacity(0.08),
                          ),
                        ),
                        Container(
                          height: 68,
                          width: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _green.withOpacity(0.15),
                          ),
                        ),
                        Container(
                          height: 52,
                          width: 52,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: _green,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ── title ───────────────────────────────────────────
                    const Text(
                      'KYC Verified!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111111),
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your identity has been successfully\nverified.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── feature unlock chips in a Wrap layout for multi-screen safety ──
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Chip(
                          icon: Icons.wallet_rounded,
                          label: 'Wallet Active',
                        ),
                        _Chip(icon: Icons.send_rounded, label: 'Transfers On'),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ── divider ─────────────────────────────────────────
                    const Divider(color: Color(0xFFF0F0F0), height: 1),
                    const SizedBox(height: 16),

                    // ── redirecting note ────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 14,
                          width: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _primaryRed,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Setting up your MPIN...',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF22C55E).withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF22C55E).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF22C55E)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF22C55E),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── CREATE MPIN SCREEN ───────────────────────────────────────────────────────
class _CreateMpinScreen extends StatefulWidget {
  const _CreateMpinScreen();

  @override
  State<_CreateMpinScreen> createState() => _CreateMpinScreenState();
}

class _CreateMpinScreenState extends State<_CreateMpinScreen> {
  static const _primaryRed = Color(0xFFE53935);
  static const _textColor = Color(0xFF111111);
  static const _secondaryText = Color(0xFF6B7280);

  // step 1 = enter new mpin, step 2 = confirm mpin
  int _step = 1;
  String _mpin = '';
  String _confirmMpin = '';
  bool _hasError = false;
  bool _isSuccess = false;

  String get _currentPin => _step == 1 ? _mpin : _confirmMpin;

  void _onKeyTap(String digit) {
    if (_currentPin.length >= 4 || _isSuccess) return;
    setState(() {
      _hasError = false;
      if (_step == 1) {
        _mpin += digit;
        if (_mpin.length == 4) _onMpinComplete();
      } else {
        _confirmMpin += digit;
        if (_confirmMpin.length == 4) _onConfirmComplete();
      }
    });
  }

  void _onDelete() {
    if (_isSuccess) return;
    setState(() {
      _hasError = false;
      if (_step == 1 && _mpin.isNotEmpty) {
        _mpin = _mpin.substring(0, _mpin.length - 1);
      } else if (_step == 2 && _confirmMpin.isNotEmpty) {
        _confirmMpin = _confirmMpin.substring(0, _confirmMpin.length - 1);
      }
    });
  }

  void _onMpinComplete() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _step = 2);
    });
  }

  void _onConfirmComplete() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      if (_mpin == _confirmMpin) {
        setState(() => _isSuccess = true);
        Future.delayed(const Duration(milliseconds: 1200), () {
          Get.offAllNamed('/dashboard');
        });
      } else {
        setState(() {
          _hasError = true;
          _confirmMpin = '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // ── top icon ──────────────────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _isSuccess
                    ? Container(
                        key: const ValueKey('success'),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF22C55E),
                          size: 48,
                        ),
                      )
                    : Container(
                        key: const ValueKey('lock'),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: _primaryRed.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_rounded,
                          color: _primaryRed,
                          size: 40,
                        ),
                      ),
              ),

              const SizedBox(height: 24),

              // ── title ─────────────────────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isSuccess
                    ? const Text(
                        'MPIN Created!',
                        key: ValueKey('t_success'),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF22C55E),
                          letterSpacing: -0.4,
                        ),
                      )
                    : Text(
                        _step == 1 ? 'Create MPIN' : 'Confirm MPIN',
                        key: ValueKey('t_$_step'),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: _textColor,
                          letterSpacing: -0.4,
                        ),
                      ),
              ),

              const SizedBox(height: 8),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isSuccess
                    ? const Text(
                        'Your MPIN has been set.\nRedirecting to dashboard...',
                        key: ValueKey('s_success'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _secondaryText,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      )
                    : Text(
                        _step == 1
                            ? 'Set a 4-digit MPIN to secure\nyour transactions'
                            : 'Re-enter your MPIN to confirm',
                        key: ValueKey('s_$_step'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: _secondaryText,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
              ),

              const SizedBox(height: 40),

              // ── step indicator ────────────────────────────────────
              if (!_isSuccess)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _StepDot(active: _step == 1, done: _step > 1),
                    const SizedBox(width: 8),
                    _StepDot(active: _step == 2),
                  ],
                ),

              const SizedBox(height: 32),

              // ── pin dots ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  final filled = i < _currentPin.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isSuccess
                          ? const Color(0xFF22C55E)
                          : _hasError
                          ? Colors.red
                          : filled
                          ? _primaryRed
                          : const Color(0xFFECECEC),
                      border: Border.all(
                        color: _hasError
                            ? Colors.red.withOpacity(0.3)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  );
                }),
              ),

              if (_hasError) ...[
                const SizedBox(height: 14),
                const Text(
                  'MPINs do not match. Try again.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],

              const Spacer(),

              // ── keypad ────────────────────────────────────────────
              if (!_isSuccess) ...[
                _buildKeypad(),
                const SizedBox(height: 32),
              ] else ...[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFF22C55E),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        _keyRow(['1', '2', '3']),
        const SizedBox(height: 14),
        _keyRow(['4', '5', '6']),
        const SizedBox(height: 14),
        _keyRow(['7', '8', '9']),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 72),
            _KeyButton(label: '0', onTap: () => _onKeyTap('0')),
            _DeleteButton(onTap: _onDelete),
          ],
        ),
      ],
    );
  }

  Widget _keyRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits
          .map((d) => _KeyButton(label: d, onTap: () => _onKeyTap(d)))
          .toList(),
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool active;
  final bool done;
  const _StepDot({this.active = false, this.done = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active || done
            ? const Color(0xFFE53935)
            : const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _KeyButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _KeyButton({required this.label, required this.onTap});

  @override
  State<_KeyButton> createState() => _KeyButtonState();
}

class _KeyButtonState extends State<_KeyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _pressed
                ? const Color(0xFFE53935).withOpacity(0.08)
                : const Color(0xFFF5F5F5),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
        ),
      ),
    );
  }
}

class _DeleteButton extends StatefulWidget {
  final VoidCallback onTap;
  const _DeleteButton({required this.onTap});

  @override
  State<_DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<_DeleteButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: SizedBox(
          height: 72,
          width: 72,
          child: Icon(
            Icons.backspace_outlined,
            color: const Color(0xFF6B7280),
            size: 24,
          ),
        ),
      ),
    );
  }
}
