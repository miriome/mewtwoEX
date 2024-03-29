part of 'routes.dart';

class ChatListPageRoute extends GoRouteData {
  
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChatListPage();
  }
}

class ChatPageRoute extends GoRouteData {
  final int targetId;
  ChatPageRoute({required this.targetId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    
    return ChatPage(targetId: targetId);
  }
  
}

class FullscreenChatPageRoute extends GoRouteData {
  final int targetId;
  FullscreenChatPageRoute({required this.targetId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChatPage(targetId: targetId);
  }
}
