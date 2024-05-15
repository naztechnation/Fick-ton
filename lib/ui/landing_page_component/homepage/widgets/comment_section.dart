import 'package:fikkton/handlers/secure_handler.dart';
import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/widgets/button_view.dart';
import 'package:fikkton/ui/widgets/modals.dart';
import 'package:fikkton/ui/widgets/text_edit_view.dart';
import 'package:flutter/material.dart';

import '../../../../model/posts/comment_lists.dart';
import '../../../../res/app_images.dart';
import '../../../widgets/image_view.dart';

class CommentSection extends StatefulWidget {
  final String title;
  final String userEmail;
  final String comment;
  final List<Comments> repliedComments;
  final Function(String value) createComment;
  final Function(String value) deleteComment;

  CommentSection(
      {required this.title,
      required this.comment,
      required this.createComment,
      required this.repliedComments, required this.userEmail, required this.deleteComment});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  var commentController = TextEditingController();

  bool comment = false;
  String isAdmin = '';

  getAdminStatus()async{
    isAdmin = await StorageHandler.getUserAdmin() ?? '';
    setState(() {
      
    });
  }

  hideComment() {
    setState(() {
      comment = !comment;
    });
  }


  @override
  void initState() {
   getAdminStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

   
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    width: 31,
                    //height: 31,
                    decoration: const BoxDecoration(
                      color: AppColors.lightPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.title.isNotEmpty ? widget.title[0].toUpperCase() : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.comment,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 6),
              Divider(),
              if (widget.repliedComments.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: ListView.builder(
                      itemCount: widget.repliedComments.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: const BoxDecoration(
                                        color: AppColors.lightPrimary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.repliedComments.isNotEmpty
                                              ? widget.repliedComments[0].email![0]
                                                  .toString()
                                                  .toUpperCase()
                                              : '?',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Text(
                                      replaceSubstring(
                                          widget.repliedComments[index].email ?? ''),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                               if (widget.userEmail.trim() == widget.repliedComments[index].email.toString().trim() || isAdmin == '1')
                                GestureDetector(
                                    onTap: () {
                                      Modals.showAlertOptionDialog(context,
                                          title: 'Delete Comment',
                                          message:
                                              'Are you sure you want to delete this comment?',
                                          callback: () {
                                             Modals.showToast(widget.repliedComments[index].email.toString().trim());
                                             widget.deleteComment(widget.repliedComments[index].id ?? ''); 
                                          });
                                    },
                                    child: ImageView.asset(
                                      AppImages.deleteComment,
                                      height: 16,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.repliedComments[index].comment ?? '',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }),
                ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  hideComment();
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageView.asset(
                            AppImages.bubble,
                            height: 24,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Comment',
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      (comment)
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              size: 16,
                              color: AppColors.lightPrimary,
                            )
                          : Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColors.lightPrimary,
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 3),
              (comment)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        const SizedBox(height: 5),
                        TextEditView(
                          controller: commentController,
                          borderColor: AppColors.lightPrimary,
                          maxLines: 3,
                          borderWidth: 1,
                          hintText: 'Enter comment',
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ButtonView(
                            expanded: false,
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                            onPressed: () {
                              widget.createComment(commentController.text);
                            },
                            child: Text(
                              'Send',
                              style: TextStyle(color: Colors.white),
                            ),
                            borderRadius: 12,
                            color: AppColors.lightPrimary,
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String replaceSubstring(String input) {
    input = input.replaceRange(3, 7, '*****');

    return input;
  }
}
