import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              'Error loading page. Please check your internet connection.'),
          ElevatedButton(
            onPressed: () {
              // setState(() {
              //   isPageLoadError = false;
              //   isLoading = true;
              // });
              // _controller.reload();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
