import 'package:apollo_app/Features/LatexConvert/latex_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class Latextconvert extends StatefulWidget {
  static String id = '/latex';
  const Latextconvert({super.key});

  @override
  State<Latextconvert> createState() => _LatextconvertState();
}

class _LatextconvertState extends State<Latextconvert> {
  final _formKey = GlobalKey<FormState>();
  var inputLatex = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Latex Conversion"),
        ),
        body: _buildUI());
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _formInput(),
            _resultTexView(),
          ],
        ),
      ),
    );
  }

  Widget _formInput() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            LatexFormInput(
              hintText: "Latex Input",
              onSaved: (value) {
                setState(() {
                  inputLatex = value!;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            _convertButton(),
          ],
        ),
      ),
    );
  }

  Widget _convertButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _formKey.currentState?.save();
            setState(() {
              print(inputLatex);
            });
          }
        },
        child: const Text("Convert"),
      ),
    );
  }

  Widget _resultTexView() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TeXView(
        renderingEngine: const TeXViewRenderingEngine.katex(),
        child: TeXViewDocument(
          r'\(' + inputLatex + r'\)',
          style: const TeXViewStyle(
            contentColor: Colors.black,
            backgroundColor: Colors.white,
            padding: TeXViewPadding.all(8),
          ),
        ),
      ),
    );
  }
}
