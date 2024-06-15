import '../service/post/post_provider.dart';
import '../common.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPost = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final counter = ref.watch(counterProvider);
            return Text('Post Viewer: $counter',style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber),);
          },
        ),
      ),
      body: asyncPost.when(
        data: (post) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${post.title}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Body: ${post.body}'),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateCount(ref);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void updateCount(WidgetRef ref) {
    logger.d('updateCount');
    ref.read(counterProvider.notifier).state++;
    final _ = ref.refresh(postProvider);
  }
}