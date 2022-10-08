import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/list_university_bloc.dart';

class AddDataForm extends StatelessWidget {
  const AddDataForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocProvider(
            create: (context) => ListUniversityBloc(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  _NumberInput(),
                  const _ButtonCamera(),
                  const _ButtonSubmit()
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(12)),
        ],
      ),
    );
  }
}

class _NumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListUniversityBloc, ListUniversityState>(
      buildWhen: (previous, current) =>
          previous.numberOfStudents != current.numberOfStudents,
      builder: (context, state) {
        return TextField(
          key: const Key('NumberForm_numberInput_textField'),
          onChanged: (number) => context
              .read<ListUniversityBloc>()
              .add(AddNumberOfStudents(number)),
          decoration: InputDecoration(
            labelText: 'cantidad de estudiante',
            errorText:
                state.numberOfStudents.invalid ? 'usuario invalido' : null,
          ),
        );
      },
    );
  }
}

class _ButtonCamera extends StatelessWidget {
  const _ButtonCamera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: PopupMenuButton(
        itemBuilder: (_) => [
          PopupMenuItem(
            value: 'gallery',
            child: Row(
              children: const [
                Icon(
                  Icons.image_rounded,
                  size: 20,
                  color: Colors.grey,
                ),
                Text('Galería')
              ],
            ),
          ),
          PopupMenuItem(
            value: 'camera',
            child: Row(
              children: const [
                Icon(
                  Icons.image_rounded,
                  size: 20,
                  color: Colors.grey,
                ),
                Text('Camara')
              ],
            ),
          ),
        ],
        onSelected: (value) async {
          print(value);
          if (value == 'gallery') {
            final ImagePicker _picker = ImagePicker();
            final XFile? photo =
                await _picker.pickImage(source: ImageSource.gallery);
            if (photo == null) {
              print('no seleccionó nada');
              return;
            }
            context.read<ListUniversityBloc>().add(AddImage(photo.path));
            print('tenemos imagen de galeria ${photo.path}');
            // productService.updateSelectedProductImage(photo.path);
          } else {
            final ImagePicker _picker = ImagePicker();
            final XFile? photo =
                await _picker.pickImage(source: ImageSource.camera);
            print(photo);
            if (photo == null) {
              print('no tomó nada nada');
              return;
            }
            context.read<ListUniversityBloc>().add(AddImage(photo.path));
            print('tenemos imagen de camara ${photo.path}');
            // productService.updateSelectedProductImage(photo.path);
          }
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.amber,
            child: const Text('Seleccione imagen')),
      ),
    );
  }
}

class _ButtonSubmit extends StatelessWidget {
  const _ButtonSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListUniversityBloc, ListUniversityState>(
      builder: (context, state) {
        log('${state.statusForm.isValidated}');
        return state.statusForm.isSubmissionInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
            onPressed:() {
              context.read<ListUniversityBloc>().add(const Submitted());
            },
          child: const Text('Enviar')
        );
      },
    );
  }
}
