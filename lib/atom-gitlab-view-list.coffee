{Range, CompositeDisposable}  = require 'atom'
{SelectListView, $} = require 'atom-space-pen-views'
Gitlab = require './gitlab'

module.exports =
class AtomGitlabViewList extends SelectListView
  projects: []
  list: false
  detail: false
  detailView: null

  initialize:(detailView) ->
    super
    @detailView = detailView
    $this = @
    @addClass 'gitlab-projects'
    Gitlab.getProjects (projects) ->
      $this.projects = projects
      $this.setItems projects

  viewForItem: (project) ->
    "<li class='project'><h3><span class='icon icon-book light'></span>#{project.name}</h3>" +
    "<p class='namespace'><label>Namespace:</label> #{project.namespace.name}</p>" +
    "</li>"

  getFilterKey: ->
    'path_with_namespace'

  confirmed: (item) ->
    @detailView.setItem item

  update:  ->
    return

  getTitle: ->
    return 'Gitlab Viewer'
