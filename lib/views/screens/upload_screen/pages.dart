import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:deuvox/controller/bloc/uploadimage/upload_image_bloc.dart';
import 'package:deuvox/data/model/upload_image_model.dart';
import 'package:deuvox/views/component/common_button.dart';
import 'package:deuvox/views/component/common_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);


  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UploadImageBloc uploadImageBloc = UploadImageBloc();
  List<UploadImageModel> uploadImageModels = [];
  List<File> images = [];
  final index = ValueNotifier<int>(0);

  Widget displayImage(int index) {
    if (images.isEmpty) {
      return SizedBox.shrink();
    } else {
      return Image.file(images[index]);
    }
  }

  @override
  void initState() {
    uploadImageBloc = UploadImageBloc();
    super.initState();
  }

  @override
  void dispose() {
    uploadImageBloc.close();
    super.dispose();
  }

  Future<void> showDialogUploadImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => BlocProvider<UploadImageBloc>(
            create: (context) => uploadImageBloc,
            child: BlocConsumer<UploadImageBloc, UploadImageState>(
              bloc: uploadImageBloc,
              listener: (context, state) {
                if(state is UploadImagePickerSelected) {
                  images.add(state.image);
                  UploadImageModel temp = UploadImageModel();
                  temp.image_name = state.image.path;
                  uploadImageModels.add(temp);
                }
                if(state is UploadImagePickerFailure) {
                  FlushbarHelper.createError(
                      message: "Terjadi kesalahan saat memilih image.")
                    ..show(context);
                }
                if(state is UploadImageExceedsSizeLimit) {
                  FlushbarHelper.createError(
                      message: "Gambar melebihi batas ukuran yang ditentukan.")
                    ..show(context);
                }
                if(state is UploadImageWrongResolution) {
                  FlushbarHelper.createError(
                      message: "Gambar memiliki resolusi yang tidak sesuai.")
                    ..show(context);
                }
              },
              builder: (context, state) {
                return SimpleDialog(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  children: [
                    CButtonFilled(
                      textLabel: "Browse Files",
                      onPressed: () {
                        uploadImageBloc.add(UploadImageBrowsingFiles());
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            if (index.value.toInt() != 0) index.value--;
                            },
                        ),
                        ValueListenableBuilder(
                          valueListenable: index,
                          builder: (context, index, widget) {
                            return Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1)
                                ),
                                child: displayImage(int.parse(index.toString())),
                              )
                            );
                          },
                        ),
                        IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              if (index.value.toInt() < images.length -1 ) index.value++;
                            }
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    CButtonFilled(
                      textLabel: "Upload",
                      onPressed: () {
                        uploadImageBloc.add(UploadImageStarted(uploadImageModels));
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CButtonFilled(textLabel: "Submit",onPressed: (){}),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
          children: [
            Text(
              "Upload Barang",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 30),
            CTextFormFilled(
              labelText: "Nama Barang*",
              validator: (value) =>
                  value!.isEmpty ? "Data belum lengkap" : null,
            ),
             SizedBox(height: 20),
              CTextFormFilled(
              labelText: "Harga*",
              validator: (value) =>
                  value!.isEmpty ? "Data belum lengkap" : null,
            ),
             SizedBox(height: 20),
             Text("Detail Barang",style: Theme.of(context).textTheme.bodyText1!.copyWith(
               fontWeight: FontWeight.bold,
               fontSize: 16
             )),
             SizedBox(height: 20),
              CTextFormFilled(
              labelText: "Kondisi Barang*",
              hintText: "Baru",
              validator: (value) =>
                  value!.isEmpty ? "Data belum lengkap" : null,
            ),
            SizedBox(height: 20),
              CTextFormFilled(
              labelText: "Berat*",
              validator: (value) =>
                  value!.isEmpty ? "Data belum lengkap" : null,
            ),

            SizedBox(height: 20),
              CTextFormFilled(
              labelText: "Deskripsi Barang*",
              maxLines: 4,
              validator: (value) =>
                  value!.isEmpty ? "Data belum lengkap" : null,
            ),
            SizedBox(height: 20),
              Text("Upload Photo*"),
            SizedBox(height: 20),
              BlocProvider<UploadImageBloc>(
                create: (context) => uploadImageBloc,
                child: BlocConsumer(
                  bloc: uploadImageBloc,
                  listener: (context, state) {
                    if (state is UploadImageSuccess) {
                      //get resdata from uploadimagesuccess
                      uploadImageBloc.add(UploadImagePreview("image_name"));
                    }

                  },
                  builder: (context, state) {
                    if (state is UploadImagePreviewSuccess) {
                      return Flex(
                          direction: Axis.horizontal,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1)
                              ),
                              child: //Image.file(state.image)
                              SizedBox.shrink() //image file after api available later
                          )
                        ]
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                )
              ),
            SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: CButtonFilled(textLabel: "Upload",onPressed: (){
                      showDialogUploadImage(context);
                    })),
                ],
              )
          ],
        ),
      ),
    );
  }
}
