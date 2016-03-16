Package.describe
  summary: "A pattern to display application errors to the user"

Package.onUse (api, where)->
  api.use ['minimongo', 'mongo-livedata', 'templating'], 'client'
  api.add_files ['errors.js', 'error_list.html', 'error_list.jade', 'error_list.js'], 'client'

  if api.export
    api.export 'Errors'
    return