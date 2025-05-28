import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoListPage extends HookConsumerWidget {
  const VideoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoList = useState([
      {
        'snapImage': 'https://via.placeholder.com/150/FF0000/FFFFFF?Text=Video1',
        '时间': '10:30',
        '设备名称': 'Device 1',
      },
      {
        'snapImage': 'https://via.placeholder.com/150/00FF00/FFFFFF?Text=Video2',
        '时间': '11:45',
        '设备名称': 'Device 2',
      },
      {
        'snapImage': 'https://via.placeholder.com/150/0000FF/FFFFFF?Text=Video3',
        '时间': '14:20',
        '设备名称': 'Device 1',
      },
    ]);

    // To test the empty list case, uncomment the next line
    // videoList.value = [];

    if (videoList.value.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Video List'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.videocam_off, size: 50),
              SizedBox(height: 16),
              Text('No videos found'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate a network request
          await Future.delayed(const Duration(seconds: 1));
          // In a real app, you would refetch the data here
        },
        child: ListView.builder(
          itemCount: videoList.value.length,
          itemBuilder: (context, index) {
            final video = videoList.value[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.network(
                      video['snapImage'] as String,
                      width: 100,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, size: 60);
                      },
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time: ${video['时间']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('Device: ${video['设备名称']}'),
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
