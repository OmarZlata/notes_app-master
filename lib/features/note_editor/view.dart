import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/core/dimensions/dimensions.dart';
import 'package:note_app/widgets/app_icon_button.dart';

import '../../core/models/note.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/app_text_field.dart';
import 'controller.dart';

class NoteEditorView extends StatefulWidget {
  const NoteEditorView({super.key});

  @override
  State<NoteEditorView> createState() => _NoteEditorViewState();
}

class _NoteEditorViewState extends State<NoteEditorView> {
  NoteEditorController controller = NoteEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        enableBackButton: true,
        actions: [
          AppIconButton(
            icon: FontAwesomeIcons.eye,
            onTap: () {},
            padding: EdgeInsets.only(right: 16.width),
          ),
          AppIconButton(
            icon: FontAwesomeIcons.floppyDisk,
            onTap: () => AppDialog.show(
              context,
              message: "Save changes ?",
              confirmTitle: "Save",
              onConfirm: () async {
                final note = await controller.addNote();
                if (note == null) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  Navigator.pop(
                    context,
                    note,
                  );
                }
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.all(16),
          children: [
            AppTextField(
              hint: "Title",
              cursorHeight: 52,
              hintFontSize: 48,
              maxLength: 50,
              onChanged: (v) {
                controller.title = v;
              },
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Empty field!';
                }
                return null;
              },
            ),
            SizedBox(height: 16.height),
            AppTextField(
              hint: "Type Something...",
              onChanged: (v) {
                controller.subtitle = v;
              },
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Empty field!';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
