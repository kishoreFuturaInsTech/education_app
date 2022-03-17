import 'dart:convert';

import 'package:api_practice/Quantative.dart';
import 'package:http/http.dart';


class HttpService{
  Future<List<Quantative>> getAllQuants() async {
    Response res = await get(Uri.parse("http://192.168.43.199:8080/alleducations"));
    if(res.statusCode==200){
      List<dynamic> body = jsonDecode(res.body);
      List<Quantative> quants = body.map((e) => Quantative.fromJson(e)).toList();
      return quants;
    } 
    throw Exception("Data not Found");
  }

  void deleteQuants(id) async{
    final response = await delete(
      Uri.parse('http://192.168.43.199:8080/deleteeducation/$id'),
    );
    print(response);
  }

  Future<Quantative> updateEducation(id, Quantative quans) async{
    final response = await patch(
      Uri.parse('http://192.168.43.199:8080/editeducation/$id'),
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:jsonEncode({
        "instituteName":quans.instituteName,
        "universityName":quans.universityName,
        "courseName":quans.courseName,
        "courseDiscipline":quans.courseDiscipline,
        "certificationId":quans.certificationId

      }),
    );
    return Quantative.fromJson(jsonDecode(response.body));
  }

  Future<Quantative> createQuants(Quantative quans) async {
    final response = await post(
      Uri.parse("http://localhost:8080/addeducation"),
      headers:{
        "Content-type":"application/json; charset=UTF-8"
      },
      body:jsonEncode({
        "instituteName":quans.instituteName,
        "universityName":quans.universityName,
        "courseName":quans.courseName,
        "courseDiscipline":quans.courseDiscipline,
        "certificationId":quans.certificationId
      }),
    );
    return Quantative.fromJson(jsonDecode(response.body));
  }

}