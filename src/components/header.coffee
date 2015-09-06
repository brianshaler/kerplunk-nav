_ = require 'lodash'
React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  render: ->
    topBarComponents = []

    navbar = @props.globals.public.navbar ? {}
    for componentName, active of navbar
      Component = @props.getComponent componentName
      topBarComponents.push Component _.extend {key: componentName}, @props

    DOM.header
      className: 'header'
    ,
      DOM.a
        href: '/admin'
        className: 'logo'
      ,
        DOM.img
          src: '/images/kerplunk/header_logo.png'
          alt: 'Kerplunk!'
          style:
            display: 'none'
      DOM.nav
        className: 'navbar navbar-static-top'
        role: 'navigation'
      ,
        DOM.a
          href: '#'
          onClick: @props.toggleNav
          className: 'navbar-btn sidebar-toggle'
          role: 'button'
        ,
          DOM.span {className: 'sr-only'}, 'Toggle navigation'
          DOM.span className: 'icon-bar'
          DOM.span className: 'icon-bar'
          DOM.span className: 'icon-bar'
        DOM.div
          className: 'navbar-right'
        ,
          DOM.ul
            className: 'nav navbar-nav'
          ,
            topBarComponents

###
<nav class="navbar navbar-static-top" role="navigation">
    <!-- Sidebar toggle button-->
    <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </a>
    <div class="navbar-right">
        <ul class="nav navbar-nav">
            <!-- Messages: style can be found in dropdown.less-->
            <%= (1==1 ? '' : Kerplunk.getTemplate('kerplunk-dashboard-skin.navbarMessages')({Kerplunk: Kerplunk})) %>
            <!-- Notifications: style can be found in dropdown.less -->
            <%= Kerplunk.getTemplate('kerplunk-dashboard-skin.navbarNotifications')({Kerplunk: Kerplunk}) %>
            <!-- User Account: style can be found in dropdown.less -->
            <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <i class="glyphicon glyphicon-user"></i>
                    <span><span class="hidden-mobile">User</span> <i class="caret"></i></span>
                </a>
                <ul class="dropdown-menu">
                    <!-- User image -->
                    <li class="user-header bg-light-blue">
                        <img class="img-circle" alt="User Image" />
                        <p>
                            Jane Doe - Web Developer
                            <small>Member since Nov. 2012</small>
                        </p>
                    </li>
                    <!-- Menu Body -->
                    <li class="user-body">
                        <div class="col-xs-4 text-center">
                            <a href="#">123<br />Followers</a>
                        </div>
                        <div class="col-xs-4 text-center">
                            <a href="#">123<br />Sales</a>
                        </div>
                        <div class="col-xs-4 text-center">
                            <a href="#"><strong>123</strong>Friends</a>
                        </div>
                    </li>
                    <!-- Menu Footer-->
                    <li class="user-footer">
                        <div class="pull-left">
                            <a href="#" class="btn btn-default btn-flat">Profile</a>
                        </div>
                        <div class="pull-right">
                            <a href="#" class="btn btn-default btn-flat">Sign out</a>
                        </div>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

###
