{Range, CompositeDisposable}  = require 'atom'
{View, $, $$} = require 'atom-space-pen-views'
AtomGitlabViewList = require './atom-gitlab-view-list'
AtomGitlabViewDetail = require './atom-gitlab-view-detail'
Gitlab = require './gitlab'

module.exports =
class AtomGitlabView extends View
  @content: ->
    detailView = new AtomGitlabViewDetail()
    listView = new AtomGitlabViewList(detailView)

    @div class: 'gitlab', =>
      @div class: 'list-view', =>
        @subview 'listView', listView
      @div class: 'detail-view', =>
        @subview 'detailView', detailView

  getTitle: ->
    'Gitlab'
