class Viewmodel{
  int Value;

  Viewmodel({required this.Value});

  Map<String, dynamic> toJson()=>{
 'Value':Value
  };

  static Viewmodel fromJson(Map<String, dynamic> json)=>Viewmodel(
    Value:json['Value'],

  );

}