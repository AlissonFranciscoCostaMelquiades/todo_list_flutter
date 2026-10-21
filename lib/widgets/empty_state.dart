import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({
    super.key,
    this.message =
        'Você não possui tarefas.\nAdicione uma tarefa para começar.',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final TextTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 72,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 16),

          const SizedBox(height: 8),
          Text(
            'Tudo organizado!',
            style: TextTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
