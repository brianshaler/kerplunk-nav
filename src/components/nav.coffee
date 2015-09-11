_ = require 'lodash'
React = require 'react'

NavItem = require './navItem'

{DOM} = React

processItem = (item, text) ->
  href = if typeof item is 'string'
    item
  else
    '#'

  children = if typeof item is 'object'
    _.map item, processItem
  else
    null

  text: text
  href: href
  children: children ? []

module.exports = React.createFactory React.createClass
  getInitialState: ->
    navItems = @getNavItems @props
    longestMatch = @getLongestMatch @props.currentUrl, navItems

    longestMatch: longestMatch
    navItems: navItems

  getNavItems: (props = @props) ->
    _.map props.globals.public.nav, processItem

  getLongestMatch: (url, navItems) ->
    longestMatch = ''
    check = (items) ->
      for item in items
        if item.href == url.substring 0, item.href.length
          if item.href.length > longestMatch.length
            longestMatch = item.href
        if item.children.length > 0
          check item.children
    check navItems
    longestMatch

  componentWillReceiveProps: (newProps) ->
    navItems = @getNavItems newProps
    longestMatch = @getLongestMatch newProps.currentUrl, navItems

    @setState
      longestMatch: longestMatch
      navItems: navItems

  render: ->
    currentUrl = @props.currentUrl

    DOM.aside
      className: 'left-side sidebar-offcanvas nav-menu'
    ,
      DOM.link
        rel: 'stylesheet'
        href: '/plugins/kerplunk-nav/css/nav.css'
      , ''
      DOM.section
        className: 'sidebar'
      ,
        DOM.ul
          className: 'sidebar-menu nav-item-holder'
        ,
          if @props.isUser
            _.map @state.navItems, (navItem, index) =>
              NavItem _.extend {key: "nav-#{index}"}, @props, navItem, {currentUrl: @state.longestMatch}
