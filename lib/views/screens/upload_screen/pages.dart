import 'package:deuvox/views/component/common_button.dart';
import 'package:deuvox/views/component/common_form.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CButtonFilled(textLabel: "Upload",onPressed: (){})),
              ],
            )
          ],
        ),
      ),
    );
  }
}
