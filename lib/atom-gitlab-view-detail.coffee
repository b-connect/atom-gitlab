{Range, CompositeDisposable, Emitter}  = require 'atom'
{View, $, $$, ScrollView} = require 'atom-space-pen-views'
Gitlab = require './gitlab'
marked = require 'marked'

module.exports =
class AtomGitlabViewDetail extends ScrollView
  detail: null
  emitter: null

  initialize: ->
    super
    @emitter = new Emitter

  @content: ->
    @div class : 'gitlab-detail-wrapper', =>
      @div id: 'gitlab-details', 'Loading...'
      @div id: 'gitlab-readme'
      @div id: 'gitlab-issues'

  attached: ->
    @detail = $(@element.querySelector("div[id='gitlab-details']"))
    @readme = $(@element.querySelector("div[id='gitlab-readme']"))


  setItem:(item) ->
    @detail.empty()
    @readme.empty()
    @detail.append(@viewItem(item))
    $this = @
    Gitlab.getReadme item.id, (content) ->
      $this.readme.append(marked(content.toString()))
      $this.emitter.emit 'did-load'

  onDidLoad: (callback) ->
    @emitter.on 'did-load', callback

  viewItem:(item) ->
    output = "<h1>#{item.name}</h1>
    <p>#{item.description}</p>
    <p>Link: #{item.web_url}</p>
    <p>Git: #{item.ssh_url_to_repo}</p>
    "
    if item.owner
      output += @viewAuthor(item.owner)

    output

  viewAuthor:(owner) ->

    output = "<div class='author'>
      <a href='#{owner.web_url}'>#{owner.name}</a>
    </div>"

    if owner.avatar_url
      output += '<img src="' + owner.avatar_url + '" />'

    output
