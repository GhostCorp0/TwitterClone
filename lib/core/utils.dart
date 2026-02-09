String formatError(Object error){
  if(error.toString().startsWith("Exception: ")){
    return error.toString().replaceFirst("Exception: ", "");
  }
  return error.toString();
}