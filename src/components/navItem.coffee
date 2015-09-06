_ = require 'lodash'
React = require 'react'

{DOM} = React

module.exports = NavItem = React.createFactory React.createClass
  getInitialState: ->
    urlMatch = @childSelected()

    expanded: urlMatch
    active: urlMatch
    highlighted: @props.href == @props.currentUrl
    notificationCount: @countNotifications @props

  componentWillReceiveProps: (newProps) ->
    urlMatch = @childSelected newProps

    @setState
      expanded: urlMatch
      active: urlMatch
      highlighted: newProps.href == newProps.currentUrl
      notificationCount: @countNotifications newProps

  childSelected: (props = @props) ->
    url = props.currentUrl ? ''
    check = (obj) ->
      return true if obj.href == url #.substring 0, obj.href.length
      !!(_.find obj.children, check)
    check props

  countNotifications: (props = @props) ->
    url = props.currentUrl ? ''
    notifications = props.notifications ? []
    n = {}
    for notification in notifications
      for navUrl in notification.navUrls
        n[navUrl] = 0 unless n[navUrl] > 0
        n[navUrl]++
    total = 0
    check = (obj) ->
      val = n[obj.href] ? 0
      for child in obj.children
        val += check child
      val
    total = check props

  toggle: (e) ->
    e.preventDefault()
    @setState
      expanded: !@state.expanded

  render: ->
    classes = ['nav-element']

    if @props.children.length > 0
      classes.push 'treeview'

    if @state.expanded
      classes.push 'expanded'
    else
      classes.push 'collapsed'

    if @state.active
      classes.push 'active'

    if @state.highlighted
      classes.push 'highlighted'

    child = if @props.children.length > 0
      #console.log "ul-#{@props.text}-#{@props.href}"
      [
        DOM.a
          key: "a-#{@props.text}-#{@props.href}"
          href: '#'
          onClick: @toggle
        ,
          @props.text
          DOM.em
            className: "fa fa-angle-#{if @state.expanded then 'down' else 'left'} pull-right"
          DOM.span
            className: 'badge'
          , if @state.notificationCount > 0 then @state.notificationCount else ''
        DOM.ul
          key: "ul-#{@props.text}-#{@props.href}"
          className: 'treeview-menu'
          style:
            display: ('block' if @state.expanded)
        ,
          _.map @props.children, (kid, index) =>
            NavItem _.extend {key: "nav-item-#{@props.href}-#{index}"}, @props, kid
      ]
    else
      DOM.a
        href: @props.href
        onClick: (e) =>
          @props.pushState e, true
      ,
        @props.text
        DOM.span
          className: 'badge'
        , if @state.notificationCount > 0 then @state.notificationCount else ''

    DOM.li
      key: "nav-#{@props.text}"
      className: classes.join ' '
    , child
