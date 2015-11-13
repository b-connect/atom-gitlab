AtomGitlabView = require './atom-gitlab-view'
{CompositeDisposable} = require 'atom'
CMD_TOGGLE = 'atom-gitlab:toggle'

views = []
view = undefined
pane = undefined
item = undefined

module.exports = AtomGitlab =
  atomGitlabView: null
  subscriptions: null
  config:
    gitlabUrl:
      type: 'string'
      default: 'http://gitlab.com'
    gitlabToken:
      type: 'string'
      default: ''

  activate: (state) ->
    console.log 'Atom Gitlab: activate'
    atom.commands.add 'atom-workspace', CMD_TOGGLE, => @toggleView()
    atom.workspace.onDidChangeActivePaneItem (item) => @updateViews()
    return

  toggleView: ->
    if !@atomGitlabView
      @atomGitlabView = new AtomGitlabView()
      pane = atom.workspace.getActivePane()
      item = pane.addItem @atomGitlabView, 0
      pane.activateItem item

  deactivate: ->
    return

  updateViews: ->
    activeView = atom.workspace.getActivePane().getActiveItem()
    for v in views when v is activeView
      v.update()
    return

  serialize: ->
    atomGitlabViewState: @atomGitlabView.serialize()

  toggle: ->
    console.log 'AtomGitlab was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
