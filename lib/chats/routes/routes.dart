import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mewtwo/chats/pages/chat_list_page/chat_list_page.dart';
import 'package:mewtwo/chats/pages/chat_page/chat_page.dart';

part 'routes_data.dart';

class ChatRoutes {
  static const List<TypedGoRoute> typedRoutes = [TypedGoRoute<ChatListPageRoute>(
        path: 'chat-list',
      ),
      TypedGoRoute<ChatPageRoute>(
        path: 'chat/:targetId',
      ), 
      ];
      
}

class FullscreenChatRoutes {
  static const List<TypedGoRoute> typedRoutes = [
    TypedGoRoute<FullscreenChatPageRoute>(
      path: 'chat/:targetId',
    ),
  ];
}
