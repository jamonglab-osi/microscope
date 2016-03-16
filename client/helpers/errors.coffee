@Errors = new Mongo.Collection null

@throwError = (error_message)->
  Errors.insert
    message: error_message