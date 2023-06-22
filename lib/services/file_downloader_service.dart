import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloaderService {
  void myNotificationTapCallback(Task task, NotificationType notificationType) {
    debugPrint(
        'Tapped notification $notificationType for taskId ${task.taskId}');
  }

  TaskStatus? downloadTaskStatus;

  Future<void> startDownload(
    BuildContext context,
    String? fileUrl,
    String? fileName,
  ) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      // await getExternalStorageDirectory()
      //     .then((value) => savedDir = value!.path);
      // print(savedDir);

      /// define the download task (subset of parameters shown)
      final task = DownloadTask(
          url: fileUrl!,
          urlQueryParameters: {'q': 'pizza'},
          filename: fileName,
          headers: {'myHeader': 'value'},
          baseDirectory: BaseDirectory.applicationSupport,
          directory: "./MyDownloads",
          updates:
              Updates.statusAndProgress, // request status and progress updates
          requiresWiFi: false,
          retries: 5,
          allowPause: true,
          metaData: 'data for me');

      // Start download, and wait for result. Show progress and status changes
// while downloading
//      final TaskStatusUpdate result =
      await FileDownloader().download(task,
          onProgress: (progress) => print('Progress: ${progress * 100}%'),
          onStatus: (status) async {
            switch (status) {
              case TaskStatus.complete:
                print('Success!');
                await FileDownloader().openFile(task: task);
                break;

              case TaskStatus.canceled:
                print('Download was canceled');
                break;

              case TaskStatus.paused:
                print('Download was paused');
                break;

              default:
                print('Download not successful');
                break;
            }
          });

// Act on the result

      // switch (result) {
      //   case TaskStatus.complete:
      //     print('Success!');
      //     break;

      //   case TaskStatus.canceled:
      //     print('Download was canceled');
      //     break;

      //   case TaskStatus.paused:
      //     print('Download was paused');
      //     break;

      //   default:
      //     print('Download not successful');
      //     break;
      // }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Permission Required'),
          content: Text('Storage permission is required to download files.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}