import 'package:flutter/material.dart';
import 'app_theme.dart';

Future<void> showSuccessDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
  required VoidCallback onDone,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.primaryDeep.withValues(alpha: 0.7),
    builder: (ctx) => _SuccessDialog(title: title, subtitle: subtitle, onDone: onDone),
  );
}

class _SuccessDialog extends StatefulWidget {
  final String title, subtitle;
  final VoidCallback onDone;
  const _SuccessDialog({required this.title, required this.subtitle, required this.onDone});
  @override State<_SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<_SuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale, _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          ScaleTransition(
            scale: _scale,
            child: Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.success, Color(0xFF4ADE80)]),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                  color: AppColors.success.withValues(alpha: 0.3),
                  blurRadius: 16, offset: const Offset(0, 6))]),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 38)),
          ),
          const SizedBox(height: 18),
          Text(widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMid),
            textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(widget.subtitle,
            style: const TextStyle(fontSize: 13, color: AppColors.textGrey, height: 1.5),
            textAlign: TextAlign.center),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () { Navigator.pop(context); widget.onDone(); },
              child: const Text('Lanjut'),
            ),
          ),
        ]),
      ),
    );
  }
}
