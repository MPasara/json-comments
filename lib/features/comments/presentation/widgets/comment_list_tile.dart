import 'package:comments/common/domain/failure.dart';
import 'package:comments/common/presentation/build_context_extensions.dart';
import 'package:comments/common/presentation/toast_providers.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:q_ui_components/widgets/q_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentListTile extends ConsumerStatefulWidget {
  const CommentListTile({super.key, required this.comment});

  final Comment comment;

  @override
  ConsumerState<CommentListTile> createState() => _CommentListTileState();
}

class _CommentListTileState extends ConsumerState<CommentListTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: isExpanded ? 0 : 2,
      color: context.appColors.commentTileColor,
      child: ExpansionTile(
        onExpansionChanged: (newValue) {
          setState(() => isExpanded = newValue);
        },
        iconColor: context.appColors.secondary,
        collapsedIconColor: context.appColors.primary,
        expansionAnimationStyle: AnimationStyle(
          curve: Curves.easeOutBack,
          duration: Duration(milliseconds: 350),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide.none,
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide.none,
        ),
        leading: CircleAvatar(
          backgroundColor: context.appColors.secondary!.withValues(alpha: 0.5),
          child: Text(
            widget.comment.id.toString(),
            style: context.appTextStyles.regular,
          ),
        ),
        title: Text(
          widget.comment.email,
          style: context.appTextStyles.bold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${S.of(context).id} ${widget.comment.id}',
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(widget.comment.name, style: context.appTextStyles.regular),
                const SizedBox(height: 16),
                Text(S.of(context).comment, style: context.appTextStyles.bold),
                const SizedBox(height: 4),
                Text(widget.comment.body, style: context.appTextStyles.regular),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QButton.text(
                      text: S.of(context).contact,
                      borderColor: context.appColors.primary,
                      onPressed: () {
                        final email = widget.comment.email;
                        HapticFeedback.mediumImpact();
                        _launchEmail(email);
                      },
                      textStyle: context.appTextStyles.regular,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final mailtoUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri);
    } else {
      ref
          .read(failureProvider.notifier)
          .update((state) => Failure(title: S.of(context).mail_app_error));
    }
  }
}
