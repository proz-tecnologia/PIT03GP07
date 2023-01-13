import 'package:belt/model/category.model.dart';
import 'package:belt/model/transaction.model.dart';
import 'package:dio/dio.dart';

class APIService {
  final options = BaseOptions(
      baseUrl: "https://crudcrud.com/api/1bb51d259b934161920f4f74fe6986ac");

  Future<Response> getAllTransaction() async {
    try {
      return await Dio(options).get('/transactions');
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> addTransaction(Transaction item) async {
    try {
      return await Dio(options).post('/transactions', data: item.toJson());
    } on DioError catch (e) {
      print(e);
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> getByIdTransaction(String id) async {
    try {
      return await Dio(options).get('/transactions/$id');
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> updateTransaction(Transaction item) async {
    try {
      return await Dio(options)
          .put('/transactions/${item.id}', data: item.toJson());
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> deleteTransaction(Transaction item) async {
    try {
      return await Dio(options).delete('/transactions/${item.id}');
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> getAllCategory() async {
    try {
      return await Dio(options).get('/categorys');
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> addCategory(Category item) async {
    try {
      return await Dio(options).post('/categorys', data: item.toJson());
    } on DioError catch (e) {
      print(e);
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> getByIdCategory(String id) async {
    try {
      return await Dio(options).get('/categorys/$id');
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> updateCategory(Category item) async {
    try {
      return await Dio(options)
          .put('/categorys/${item.id}', data: item.toJson());
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }

  Future<Response> deleteCategory(Category item) async {
    try {
      return await Dio(options).delete('/categorys/${item.id}');
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          "Ops! Ocorreu uma falha no servidor, tente novamente mais tarde!");
    }
  }
}
