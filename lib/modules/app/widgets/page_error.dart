import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vk_find_people/modules/app/widgets/styled_button.dart';

class PageError extends StatelessWidget {
  final String? message;
  final dynamic exception;
  final VoidCallback? onRefresh;

  const PageError({
    Key? key,
    this.message,
    this.exception,
    this.onRefresh,
  })  : assert(
  message != null || exception != null,
  'Please provider one of message/exception',
  ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var message = 'Whoops, something went wrong! Please reload the page.';
    if (exception != null && exception is DioError) {
      final exception = (this.exception as DioError);
      message = exception.message;
    }
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - kToolbarHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  if (onRefresh != null) ...[
                    const SizedBox(height: 20.0),
                    StyledButton(
                      label: 'Reload',
                      onTap: onRefresh,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}