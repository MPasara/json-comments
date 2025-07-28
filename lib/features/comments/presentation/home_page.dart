import 'package:comments/common/domain/notifiers/locale_notifier.dart';
import 'package:comments/common/utils/constants/locale_constants.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_notifier.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_state.dart';
import 'package:comments/features/comments/presentation/widgets/comments_empty.dart';
import 'package:comments/features/comments/presentation/widgets/comments_error.dart';
import 'package:comments/features/comments/presentation/widgets/comments_list.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentsNotifierProvider);
    final selectedLocale = ref.watch(localeNotifierProvider);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 239, 239),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 240, 239, 239),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                  Spacer(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(S.of(context).change_language),
              ),
              ListTile(
                trailing: selectedLocale.languageCode == LocaleConstants.eng
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
                title: Text(S.of(context).english),
                onTap: () {
                  ref
                      .read(localeNotifierProvider.notifier)
                      .setLocale(Locale(LocaleConstants.eng));
                },
              ),
              ListTile(
                title: Text(S.of(context).croatian),
                trailing: selectedLocale.languageCode == LocaleConstants.cro
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  ref
                      .read(localeNotifierProvider.notifier)
                      .setLocale(Locale(LocaleConstants.cro));
                },
              ),
              ListTile(
                title: Text(S.of(context).spanish),
                trailing: selectedLocale.languageCode == LocaleConstants.esp
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  ref
                      .read(localeNotifierProvider.notifier)
                      .setLocale(Locale(LocaleConstants.esp));
                },
              ),
              ListTile(
                title: Text(S.of(context).french),
                trailing: selectedLocale.languageCode == LocaleConstants.fr
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  ref
                      .read(localeNotifierProvider.notifier)
                      .setLocale(Locale(LocaleConstants.fr));
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.of(context).comments),
        centerTitle: true,
      ),
      body: switch (state) {
        CommentsInitial() => const SizedBox(),
        CommentsEmpty() => CommentsEmptyListWidget(),
        CommentsLoading() => const Center(
          child: CircularProgressIndicator(color: Colors.purple),
        ),
        CommentsError(:final failure) => CommentsErrorWidget(failure: failure),
        CommentsData(:final data, :final hasReachedMax, :final isLoadingMore) =>
          CommentsListWidget(
            hasReachedMax: hasReachedMax,
            isLoadingMore: isLoadingMore,
            comments: data,
          ),
      },
    );
  }
}
