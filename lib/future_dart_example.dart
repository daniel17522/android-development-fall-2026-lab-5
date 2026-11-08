void notFuture() {
  print("This is a regular function, not a future.");
}

Future<void> futureFunction() async {
  await Future.delayed(Duration(seconds: 2));
  print("This is a future function that completes after a delay.");
}

Future<void> main() async {
  futureFunction()
      .then((_) {
        print("Future function completed.");
      })
      .catchError((error) {
        print("An error occurred: $error");
      });
  print("Starting the main function.");
  notFuture();
}
