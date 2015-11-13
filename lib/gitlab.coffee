gitlabApi = (require 'gitlab')
  url:   atom.config.get('atom-gitlab.gitlabUrl')
  token: atom.config.get('atom-gitlab.gitlabToken')

class Gitlab
  constructor: () ->

  getProjects : (done) ->
    gitlabApi.projects.all (projects) ->
      done projects

  showProject : (id,done) ->
    gitlabApi.projects.show(id, (project) ->
      done project
    )

  getReadme: (id,done) ->
    gitlabApi.projects.repository.showFile
      projectId: id,
      ref: 'master',
      file_path: 'README.md'
    , (file) ->
      console.log file
      if file
        done new Buffer(file.content, 'base64')



module.exports = new Gitlab
