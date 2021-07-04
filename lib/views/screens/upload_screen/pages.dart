import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deuvox/app/config/themes.dart';
import 'package:deuvox/controller/bloc/uploadimage/upload_image_bloc.dart';
import 'package:deuvox/controller/bloc/uploaditem/upload_item_bloc.dart';
import 'package:deuvox/data/model/upload_image_model.dart';
import 'package:deuvox/data/model/upload_item_model.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:deuvox/views/component/common_button.dart';
import 'package:deuvox/views/component/common_form.dart';
import 'package:deuvox/views/component/common_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';


class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);


  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UploadItemBloc uploadItemBloc = UploadItemBloc();
  UploadImageBloc uploadImageBloc = UploadImageBloc();
  UploadItemModel uploadItemModel = UploadItemModel();
  List<UploadImageModel> uploadImageModels = [];
  List<String> images = [];
  List<dynamic> photos = [];
  List<PickedFile> imagesPicked = [];
  bool imageloading = false;
  //List<String> variant = [];
  String _categoryValue = LocaleKeys.category_food.tr();
  String _conditionValue = LocaleKeys.condition_new.tr();
  final index = ValueNotifier<int>(0);

  Widget displayImage(int index) {
    if (imageloading == true) {
      return ShimmerLoader(
          child: Container(height: 150, width: 150, decoration: BoxDecoration(color: Colors.black))
      );
    } else if (imagesPicked.isEmpty){
      return SizedBox.shrink();
    } else if (kIsWeb == true){
      return Image.network(imagesPicked[index].path);
    } else {
      return Image.file(File(imagesPicked[index].path));
    }
  }

  /*
  void variantDelete(int index) {
    variant.removeAt(index);
  }
   */

  @override
  void initState() {
    uploadItemBloc = UploadItemBloc();
    uploadImageBloc = UploadImageBloc();
    super.initState();
  }

  @override
  void dispose() {
    uploadItemBloc.close();
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
                  imageloading = false;
                  if(imagesPicked.isNotEmpty) {
                    var plus = state.pickedImageList!.length;
                    index.value += plus;
                  }
                  imagesPicked = state.pickedImageList!;
                }
                if(state is UploadImageCloudinaryLoading) {
                  imageloading = true;
                }
                if(state is UploadImagePickerFailure) {
                  FlushbarHelper.createError(
                      message: "Terjadi kesalahan saat memilih image.")
                    ..show(context);
                }
                if(state is UploadImageCloudinaryFailure) {
                  FlushbarHelper.createError(
                      message: "Terjadi kesalahan saat mengupload image.")
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
                  EdgeInsets.symmetric(vertical: 17),
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Text(LocaleKeys.upload_image.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                                height: 30,
                                width: 160,
                                child: CButtonFilled(
                                    primaryColor: ThemeColors.white100,
                                    textLabel: LocaleKeys.browse_image.tr(),
                                    onPressed: () => uploadImageBloc.add(UploadImageBrowsingFiles())
                                )
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_back_ios, size: 30),
                                  onTap: () {
                                    if (index.value.toInt() != 0) index.value--;
                                  },
                                ),
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: index,
                                      builder: (context, index, widget) {
                                        return Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)
                                          ),
                                          child: displayImage(int.parse(index.toString())),
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: ThemeColors.red80,
                                            shape: BoxShape.circle
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if(images.isNotEmpty) {
                                                images.removeAt(index.value);
                                              }
                                              if(imagesPicked.isNotEmpty) {
                                                imagesPicked.removeAt(index.value);
                                              }
                                              if(index.value != 0) {
                                                index.value--;
                                              }
                                              index.notifyListeners();
                                            });
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: ThemeColors.white100,
                                            size: 25,
                                          ),
                                        )
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 5),
                                InkWell(
                                  child: Icon(Icons.arrow_forward_ios, size: 30),
                                  onTap: () {
                                    if (index.value.toInt() < imagesPicked.length -1 ) index.value++;
                                  }
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: 40,
                              width: 185,
                              child: CButtonFilled(
                                rounded: true,
                                textLabel: LocaleKeys.upload.tr(),
                                onPressed: () {
                                  uploadImageBloc.add(UploadImageStarted(imagesPicked));
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        )
                      ],
                    )
                  ],
                );
              },
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UploadItemBloc>(
              create: (context) => uploadItemBloc
          ),
          BlocProvider<UploadImageBloc>(
              create: (context) => uploadImageBloc
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.add_product.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottomOpacity: 0.0,
          ),
          body: Form(
              key: _formKey,
              child: BlocConsumer<UploadItemBloc, UploadItemState>(
                  bloc: uploadItemBloc,
                  listener: (context, state) {
                    if (state is UploadItemFailure) {
                      FlushbarHelper.createError(
                          message: LocaleKeys.failed_to_upload_item.tr())
                        ..show(context);
                    }
                    if (state is UploadItemSuccess) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            CGhostInputField(
                              labelText: LocaleKeys.product_name.tr(),
                              onSaved: (val) => uploadItemModel.productName = val,
                              validator: (value) =>
                              value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_name.tr()]) : null,
                            ),
                            SizedBox(height: 20),
                            CGhostInputField(
                              labelText: LocaleKeys.product_price.tr(),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              onSaved: (val) => uploadItemModel.price = val.toString(),
                              validator: (value) =>
                              value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_price.tr()]) : null,
                            ),
                            SizedBox(height: 24),
                            Text(LocaleKeys.item_details.tr(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 24),
                            Container(
                              margin: EdgeInsets.only(left: 2),
                              child: Text(
                                LocaleKeys.product_category.tr(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                                isDense: true,
                              ),
                              value: _categoryValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text(LocaleKeys.category_food.tr()),
                                  value: LocaleKeys.category_food.tr(),
                                ),
                                DropdownMenuItem(
                                  child: Text(LocaleKeys.category_clothes.tr()),
                                  value: LocaleKeys.category_clothes.tr(),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _categoryValue = value!;
                                });
                              },
                              validator: (value) =>
                              value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_category.tr()]) : null,

                            ),
                            SizedBox(height: 20),
                            /*
                            Container(
                              margin: EdgeInsets.only(left: 2),
                              child: Text(
                                LocaleKeys.product_variant.tr(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 60,
                              width: 30,
                              child: GridView.builder(
                                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: variant.length + 1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if(index == variant.length) {
                                    return GestureDetector(
                                      onTap: () => showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) => Container(
                                          margin: EdgeInsets.only(left: 14, top: 10, right: 24),
                                          padding: MediaQuery.of(context).viewInsets,
                                          height: MediaQuery.of(context).viewInsets.bottom + 70,
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(left: 2),
                                                    child: Text(
                                                      LocaleKeys.product_variant.tr(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    autofocus: true,
                                                    decoration:
                                                    InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                                                      border: UnderlineInputBorder(),
                                                      isDense: true,
                                                    ),
                                                    textInputAction: TextInputAction.done,
                                                    onFieldSubmitted: (value) {
                                                      setState(() {
                                                        variant.add(value);
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(right: 8),
                                                  width: 15,
                                                  height: 15,
                                                  decoration: BoxDecoration(color: Colors.transparent,),
                                                  child: GestureDetector(
                                                    onTap: () => Navigator.pop(context),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: ThemeColors.black100,
                                                      size: 20,
                                                    ),
                                                  )
                                                ),
                                              )
                                            ]
                                          ),
                                        )
                                      ),
                                      child: Container(
                                          padding: EdgeInsets.only(top: 7),
                                          color: ThemeColors.white100,
                                          width: 80,
                                          child: Text(
                                            " +" + LocaleKeys.product_variant.tr(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                      ),
                                    );
                                  }
                                  return Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        color: ThemeColors.white100,
                                        width: 60,
                                        height: 30,
                                        child: Text(
                                          variant[index],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: ThemeColors.red80,
                                            shape: BoxShape.circle,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                variantDelete(index);
                                              });
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: ThemeColors.white100,
                                              size: 8,
                                            ),
                                          )
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                             */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 2),
                                          child: Text(
                                            LocaleKeys.product_condition.tr(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        DropdownButtonFormField<String>(
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700
                                          ),
                                          decoration:
                                          InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                                            isDense: true,
                                          ),
                                          value: _conditionValue,
                                          items: [
                                            DropdownMenuItem(
                                              child: Text(LocaleKeys.condition_new.tr()),
                                              value: LocaleKeys.condition_new.tr(),
                                            ),
                                            DropdownMenuItem(
                                              child: Text(LocaleKeys.condition_second.tr()),
                                              value: LocaleKeys.condition_second.tr(),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _conditionValue = value!;
                                            });
                                          },
                                          validator: (value) =>
                                          value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_condition.tr()]) : null,
                                        ),
                                      ],
                                    )
                                ),
                                SizedBox(width: 20),
                                Flexible(
                                  child: CGhostInputField(
                                    labelText: LocaleKeys.product_weight.tr(),
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    validator: (value) =>
                                    value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_weight.tr()]) : null,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Flexible(
                                  child: CGhostInputField(
                                    labelText: LocaleKeys.product_stock.tr(),
                                    keyboardType: TextInputType.number,
                                    validator: (value) =>
                                    value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_stock.tr()]) : null,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            CGhostInputField(
                              labelText: LocaleKeys.product_description.tr(),
                              maxLines: 4,
                              validator: (value) =>
                              value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_description.tr()]) : null,
                            ),
                            SizedBox(height: 20),
                            Text(LocaleKeys.upload_image.tr()),
                            SizedBox(height: 10),
                            BlocConsumer(
                                bloc: uploadImageBloc,
                                listener: (context, state) {
                                  if (state is UploadImageSuccess) {
                                    for(int i = 0; i < state.imageurls.length; i++) {
                                      UploadImageModel temp = UploadImageModel();
                                      images.add(state.imageurls[i]!);
                                      temp.path = state.imageurls[i];
                                      temp.name = "ProductPhoto" + (i+1).toString();
                                      uploadImageModels.add(temp);
                                      photos.add([temp.path, temp.name]);
                                    }
                                    uploadItemModel.photos = photos;
                                    uploadImageBloc.add(UploadImagePreview(state.imageurls));
                                  }
                                },
                                builder: (context, state) {
                                  if (state is UploadImagePreviewSuccess) {
                                    return Container(
                                      height: 90,
                                      width: double.infinity,
                                      child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 6,
                                        ),
                                        itemCount: images.length + 1,
                                        itemBuilder: (context, index) {
                                          if(index == images.length ) {
                                            return Container(

                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                              child: CButtonFilled(
                                                  primaryColor: ThemeColors.white100,
                                                  textLabel: LocaleKeys.upload.tr(),
                                                  onPressed: (){
                                                    showDialogUploadImage(context);
                                                  }
                                              )
                                            );
                                          }
                                          return Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: CachedNetworkImageProvider(images[index])
                                                )
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                          child: CButtonFilled(
                                              primaryColor: ThemeColors.white100,
                                              textLabel: LocaleKeys.upload.tr(),
                                              onPressed: (){
                                                showDialogUploadImage(context);
                                              }
                                          )
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            LocaleKeys.limit_image_size.tr(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: ThemeColors.red80,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            LocaleKeys.limit_image_pixel.tr(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: ThemeColors.red80,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }
                            ),
                            SizedBox(height: 20),

                            Container(
                                height: 40,
                                width: double.infinity,
                                child: Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CButtonFilled(
                                          rounded: true,
                                          textLabel: LocaleKeys.save.tr(),
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              _formKey.currentState?.save();

                                              uploadItemBloc.add(UploadItemStarted(uploadItemModel));
                                            }
                                          }
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ]
                        ),
                      ),
                    );
                  }
              )
          ),
        )
    );
  }
}