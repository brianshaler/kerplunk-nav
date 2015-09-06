
getNav = (System) ->
  (req, res, next) ->
    res.send System.getGlobal 'public.nav'

module.exports = (System) ->
  routes:
    admin:
      '/admin/nav': 'getNav'

  handlers:
    getNav: getNav System

  globals:
    public:
      navbar: {}
      navComponent: 'kerplunk-nav:nav'
      headerComponent: 'kerplunk-nav:header'
