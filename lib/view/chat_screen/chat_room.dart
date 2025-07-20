import 'package:akunku/bloc/chat_connect/chat_cubit_cubit.dart';
import 'package:akunku/repository/connect_repository/connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRoomProvider extends StatelessWidget {
  const ChatRoomProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final SoketiConnect connectRepository = SoketiConnect();

    return RepositoryProvider.value(
      value: connectRepository,
      child: BlocProvider(
        create: (context) => ChatCubitCubit(connectRepository)..chatConnect(),
        child: ChatRoom(),
      ),
    );
  }
}

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 100.w),
            child: Row(
              children: [
                Text(
                  'Tes Connect WebSocket',
                  style: GoogleFonts.aboreto(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<ChatCubitCubit, ChatCubitState>(
            builder: (context, state) {
              if (state is ChatCubitLoading) {
                return Center(child: CircularProgressIndicator());
              }

              //state menerima pesan dari server
              if (state is ChatCubitRecievedMessage) {
                final data = state.message;
                return Center(
                  child: Text(
                    data,
                    style: GoogleFonts.aboreto(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                );
              }

              if (state is ChatCubitError) {
                final data = state.message;
                return Center(child: Text(data));
              }

              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
