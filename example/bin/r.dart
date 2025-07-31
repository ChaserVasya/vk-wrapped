import 'package:dio/dio.dart';

void main() async {
  final res = await Dio().get(url);
  print(res);
}

const url = 'https://api.vk.ru/method/status'
    '.get?v=$version&user_id=$myId&access_token=$token';

const version = '5.199';
const myId = '206942551';

const token = 'vk2.a'
    '.J7jLsq1LxevyQbYBNDD31osqfbZj2KSZvf48bsBKx9wjjsin6ADY4t_WfWRNHZktT5uhmYI77ERgwsoJup4VbRBvNohATlqr8xMprA1oocCIaAZabYzSezqhHrvfRRAiANvAkAhZpBOaf8hQ8ehNxWvnvOCavdHvtUfQYUD7LN9uej3VMX6EQT92u8-8YsOb6-A6m0Stuvy_HTflIfGx33j8ydNX4WazHI9mwC2OPaR4muiZqE1WjUWNqMDKYjBS';
