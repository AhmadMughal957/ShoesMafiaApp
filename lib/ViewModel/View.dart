class Vieww{
  String Value;

  Vieww({required this.Value});

  Map<String, dynamic> toJson()=>{
    'Value':Value,

  };
  static Vieww fromJson(Map<String, dynamic> json)=>Vieww(
    Value:json['Value'],
  );

}