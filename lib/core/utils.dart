String formatError(Object error){
  if(error.toString().startsWith("Exception: ")){
    return error.toString().replaceFirst("Exception: ", "");
  }
  return error.toString();
}

String formatDate(DateTime date){
  return date.toLocal().toIso8601String().substring(0,10); 
}
