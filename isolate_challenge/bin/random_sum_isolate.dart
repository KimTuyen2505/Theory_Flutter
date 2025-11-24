import 'dart:isolate';
import 'dart:math';
import 'dart:async';

class StartMessage {
  final SendPort mainSendPort;
  StartMessage(this.mainSendPort);
}
class StopMessage {
  const StopMessage();
}
void workerIsolate(StartMessage message) async {
  final mainSendPort = message.mainSendPort;
  final workerReceivePort = ReceivePort();
  mainSendPort.send(workerReceivePort.sendPort);
  bool running = true;
  final random = Random();
  workerReceivePort.listen((msg) {
    if (msg is StopMessage) {
      running = false;
    }
  });
  while (running) {
    final number = random.nextInt(10) + 1; 
    mainSendPort.send(number); 
    await Future.delayed(const Duration(seconds: 1));
  }
  Isolate.exit();
}
Future<void> main() async {
  final mainReceivePort = ReceivePort();

  await Isolate.spawn(
    workerIsolate,
    StartMessage(mainReceivePort.sendPort),
  );
  SendPort? workerSendPort;
  int sum = 0;
  await for (final message in mainReceivePort) {
    if (message is SendPort) {
      workerSendPort = message;
      print("Worker isolate started.");
      continue;
    }
    if (message is int) {
      sum += message;
      print("Received: $message   Current sum: $sum");
      if (sum > 100) {
        print("Sum exceeded 100 → sending stop command...");
        workerSendPort?.send(const StopMessage());
        break;
      }
    }
  }
  print("Main isolate finished.");
}
