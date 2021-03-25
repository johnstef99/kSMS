import 'package:flutter/material.dart';
import 'package:ksms/ui/home/home_viewmodel.dart';
import 'package:ksms/ui/widgets/chat_tile.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: model.hasError
              ? Center(
                  child: ElevatedButton(
                    child: Text('Tap to grant sms permissions'),
                    onPressed: model.grantPerm,
                  ),
                )
              : SafeArea(
                  child: CustomScrollView(
                  slivers: [
                    SliverSafeArea(
                      sliver: SliverPadding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        sliver: SliverAppBar(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          floating: true,
                          forceElevated: true,
                          backgroundColor: Colors.white,
                          title: _SearchBar(),
                        ),
                      ),
                    ),
                    model.isBusy
                        ? SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, i) {
                                return ChatTile(
                                  chat: model.chats[i],
                                  onTap: () => model.gotoChat(model.chats[i]),
                                );
                              },
                              childCount: model.chats.length,
                            ),
                          ),
                  ],
                )),
        ),
      ),
    );
  }
}

class _MoreIcon extends ViewModelWidget<HomeViewModel> {
  const _MoreIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      onSelected: model.menuSelect,
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem(
          value: 'Settings',
          child: Text('Settings'),
        ),
      ],
    );
  }
}

class _SearchBar extends HookViewModelWidget<HomeViewModel> {
  const _SearchBar({Key key}) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel model) {
    var controller = useTextEditingController();
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search messages',
        suffixIcon: _MoreIcon(),
        focusColor: Colors.black,
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        prefixIcon: Icon(Icons.search, color: Colors.black),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
