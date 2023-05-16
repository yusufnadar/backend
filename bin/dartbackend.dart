//import 'package:dartbackend/dartbackend.dart' as dartbackend;
//import 'package:mysql_client/mysql_client.dart';
import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:slack_notifier/slack_notifier.dart';

final slack = SlackNotifier(
  'https://hooks.slack.com/services/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',
);

void main(List<String> arguments) async {
  final app = Router();

  app.get('/', indexRouter);

  app.post('/', indexPostRouter);

  var server = await serve(app, 'localhost', 8080);

  server.autoCompress = true;

  print('serving at ${server.address.host}:${server.port}');
}

Future<Response> indexRouter(Request request) async {
  try {
    /*
    final conn = await MySQLConnection.createConnection(
      host: "37.148.209.11",
      port: 3306,
      userName: "admin",
      password: 'yusufnadar',
      databaseName: 'nadarChat',
    );
    await conn.connect();
    var users = await conn.execute(
      "select * from users",
    );
    */
    Timer.periodic(const Duration(seconds: 10), (timer) {
      slack.send(
        'Hello world',
        channel: 'testslack',
        username: 'My Bot',
        //blocks: [SectionBlock(text: 'Hello world')],
        attachments: [Attachment(pretext: 'Hi', text: 'This is test')],
      );
    });
    return Response.ok('users');
  } catch (error) {
    print('errorr $error');
    return Response.ok(error);
  }
}

Response indexPostRouter(Request request) {
  return Response.ok('Created');
}
