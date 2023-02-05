import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burger/app/core/ui/base_state/base_state.dart';
import 'package:vakinha_burger/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burger/app/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinha_burger/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_burger/app/pages/auth/register/register_controller.dart';
import 'package:vakinha_burger/app/pages/auth/register/register_state.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterContoller> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterContoller, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao registrar usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            Navigator.of(context).pop();
          },
          any: () => hideLoader(),
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cadastro',
                        style: context.textStyles.textTitle,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Preencha os campos abaixo para criar o  seu cadastro.',
                        style: context.textStyles.textMedium
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _nameEC,
                        decoration: const InputDecoration(
                          labelText: 'Nome *',
                        ),
                        validator: Validatorless.required('Nome é obrigatório'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _emailEC,
                        decoration: const InputDecoration(
                          labelText: 'E-mail *',
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.email('E-mail inválido'),
                          Validatorless.required('E-mail é obrigatório'),
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordEC,
                        decoration: const InputDecoration(
                          labelText: 'Senha *',
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha é obrigatória'),
                          Validatorless.min(6,
                              'Informe uma senha com no minímo 6 caracteres.'),
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar Senha *',
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.compare(
                              _passwordEC, 'Confirmação da senha inválida'),
                          Validatorless.required(
                              'Confirmação de senha obrigatório'),
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: DeliveryButton(
                          width: double.infinity,
                          label: 'Cadastrar',
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;

                            if (valid) {
                              controller.register(
                                _nameEC.text,
                                _emailEC.text,
                                _passwordEC.text,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
