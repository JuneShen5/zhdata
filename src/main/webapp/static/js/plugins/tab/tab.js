!(function($, document, window, undefined) {
  var Tabs = function (settings, selector) {
    this.defaults = {
      tabName: 'tabs-item',
      tabPaneName: 'tab-pane',
      close: 'close-icon'
    };
    this.settings = settings
    this.selector = selector;
    this.tab = this.selector.find('.' + this.defaults.tabName);
    this.panel = this.selector.find('.' + this.defaults.tabPaneName);
    this.tabs = this.selector.find('.' + this.settings.tabs);
    this.content = this.selector.find('.' + this.settings.content);
    this.defaultPage = this.settings.defaultPage;
    this.close = this.selector.find('.' + this.defaults.close);
    this.init();
  };
  
  Tabs.prototype = {
    init: function () {
      this._tabLength();
      this.tabsClickToggle();
      this.closeTab();
      this.opentabByOtherUrl();
      this.addTab();
    },
    _tabLength: function() {
      var tab = this.selector.find('.' + this.defaults.tabName); 
      var isTab = tab.length > 0 ? true : false;
      if (!isTab) {
        this.selector.hide();
        this.defaultPage.show();
      } else {
        if (this.selector.css('display') === 'block') {
          return;
        }
        this.selector.show();
        this.defaultPage.hide();
        return;
      }
    },
    _createHtml: function(tabName, content, id) {
      var tabHtml = '<a class="tabs-item" href="#" tab=' + id + '><span>' + tabName + '</span><i class="close-icon fa fa-times"></i></a>';
      var name = content.replace(/\//g, "");
	  name = name.replace("?", "");
      name = name.replace("=", "");
      name = name.replace("&", "");
      name = name.replace('yjdata', "");
      var panelHtml = '<div class="tab-pane tab-iframe-container">' +
				      '<iframe class="J_iframe ' + name + '" name="iframe0" width="100%" height="100%" src=' +content + ' frameborder="0" seamless></iframe>' + 
				      '</div>';
      this.tabs.append(tabHtml);
      this.content.append(panelHtml);
    },

    tabsClickToggle: function () {
      var _this = this;
      $(document).delegate('.' + this.defaults.tabName, 'click', function (e) {
        e.stopPropagation();

        var _index = $(this).index();
        var _panel = $(this).parent().parent().find('.' + _this.defaults.tabPaneName)

        _this._tabSelected($(this));
        _this._panelSelected(_panel, _index);
      });
    },

    _tabSelected: function(me) {
      me.addClass(this.settings.activeClass).siblings().removeClass(this.settings.activeClass);
    },

    _panelSelected: function(me, index) {
      me.eq(index).show().siblings().hide();
    },

    closeTab: function() {
      var _this = this;
      $(document).delegate('.' + this.defaults.close, 'click', function (e) {
        e.stopPropagation();
        var tabCurrent = $(this).parent();
        var tabPaneltabCurrent = _this.selector.find('.' + _this.defaults.tabPaneName);
        var _index = tabCurrent.index();

        tabCurrent.remove();
        tabPaneltabCurrent.eq(_index).remove();

        var tab = _this.selector.find('.' + _this.defaults.tabName);
        var tabPaneltab = _this.selector.find('.' + _this.defaults.tabPaneName);
        var length = tab.length;

        if (tabCurrent.hasClass(_this.settings.activeClass)) {
          _this._tabSelected(tab.eq(length - 1));
          _this._panelSelected(tabPaneltab, length - 1);
        }
        _this._tabLength();
      })
    },

    addTab: function(me) {
      var _this = this;
      $(document).delegate('.' + this.settings.menuCurrent, 'click', function (e) {
        e.stopPropagation();
        e.preventDefault();

        var _url = $(this).attr('url');
        var _name = $(this).text();
        var _id = $(this).attr('id');
        _this._createdTabs(_url, _name, _id);
      });
    },

    _createdTabs: function(_url, _name, _id, _isClose, _oldId) {
      var _this = this;
      _isClose = _isClose || false;
      _oldId = _oldId || '';

      if (_url == null || _url === '') {
        return;
      }

      var tab = _this.selector.find('.' + _this.defaults.tabName);
      var tabPanel = _this.selector.find('.' + _this.defaults.tabPaneName);
      var isTabData= _this._isTab(_id);
      
      if (_isClose) {
        if (isTabData.is) {
            _this._tabSelected(tab.eq(isTabData.index));
            _this._panelSelected(tabPanel, isTabData.index);
            var index = _this.tabIndex(_oldId);
            var newIndex = _this.tabIndex(_id);
            console.log('newIndex=' + newIndex);
            _this.refreshIframe(newIndex);
            _this.closeTabAndIframe(index);
          return;
        }
        _this._tabSelected(tab.eq(isTabData.index));
 
        var tabArr = parent.document.body.getElementsByClassName('tabs-container');
        var tabContent = parent.document.body.getElementsByClassName('tabs-content');
        var aIndex = $(tabArr).find('.active').index();
        $(tabArr).find('.active').attr('tab', _id);
        $(tabArr).find('.active span').text(_name);
        $(tabContent).find('.tab-iframe-container').eq(aIndex).find('iframe').attr('src', _url);
        
        return ;
      }
      if (isTabData.is) {
    	  _this._tabSelected(tab.eq(isTabData.index));
          _this._panelSelected(tabPanel, isTabData.index);
        return;
      } else {
        var _length = _this.tabs.find('.tabs-item').length;
        if (_length >= _this.settings.max) {
          tab.eq(0).remove();
          tabPanel.eq(0).remove();
        }
        
        _this._createHtml(_name, _url, _id);
        var _lengthCurrent = _this.tabs.find('.tabs-item').length;
        var tabCurrent = _this.selector.find('.' + _this.defaults.tabName);
        var tabPanelCurrent = _this.selector.find('.' + _this.defaults.tabPaneName);

        _this._tabSelected(tabCurrent.eq(_lengthCurrent - 1));
        _this._panelSelected (tabPanelCurrent, _lengthCurrent - 1);
      }
      _this._tabLength();
    },

    _isTab: function(id) {
      var tab = this.selector.find('.' + this.defaults.tabName);
      for (var i = 0; i < tab.length; i++) {
        if (tab[i].getAttribute('tab') === id) {
          return {is: true, index: i};
        }
      }
      return {is: false};
    },

    opentabByOtherUrl: function() {
      var _this = this;
      this.settings.otherUrlClick.on('click', function (e) {
        e.stopPropagation();
        e.preventDefault();
        var _url = $(this).attr('url');
        var _id = $(this).attr('id');
        var _name = $(this).attr('name');
        var _isClose = $(this).attr('isClose');
        var _oldId =  $(this).attr('oldId');
         _this._createdTabs(_url, _name, _id, _isClose, _oldId);
      });
    },

    newTab: function() {
      var _this = this;

        var $this = $(this);
        console.log('params', _this.settings.params)
        if (_this.settings.params == null) {
          return
        }

        var _url = _this.settings.params.url || '';
        var _id = _this.settings.params.id || '';
        var _name = _this.settings.params.name || '';
        var _isClose = _this.settings.params.isClose || false;
        var _oldId = _this.settings.params.oldId || '';
        if (_url.trim() !== '' && _url != null && _name.trim() !== '' && _name != null && _id.trim() !== '' && _id != null) {
          _this._createdTabs(_url, _name, _id, _isClose, _oldId);
        }
        _this.settings.params = undefined;
    },

    closeTabAndIframe: function(index) {
      var tabs = parent.window.document.body.getElementsByClassName(this.defaults.tabName);
      var tabContent = parent.window.document.body.getElementsByClassName(this.defaults.tabPaneName);
      $(tabs).eq(index).remove();
      $(tabContent).eq(index).remove();
    },

    refreshIframe: function (newIndex) {
      var tabContent = parent.window.document.body.getElementsByClassName(this.defaults.tabPaneName);
      var src = $(tabContent).eq(newIndex).find('iframe').attr('src');
      $(tabContent).eq(newIndex).find('iframe').attr('src', src);
    },

    tabIndex: function (id) {
      var index = -1;
      var tabs = parent.window.document.body.getElementsByClassName(this.defaults.tabName);
      for(var i = 0; i < $(tabs).size(); i++) {
        if ($(tabs).eq(i).attr('tab') == id) {
          index = i;
          break;
        }
      }
      return index;
    }
  };

  
  $.fn.Tabs = function (options) {
    return this.each(function () {
      var settings = $.extend({}, $.fn.Tabs.defaults, options || {}),
          tabs = $(this).data("Tabs");
      if (!tabs) {
        tabs = new Tabs(settings, $(this));
        $(this).data('Tabs', tabs);
      } else {
        tabs.settings = settings;
        tabs.newTab();
      }

    });
  };
  $.fn.Tabs.defaults =  {
    activeClass: 'active',
    content: 'tabs-content',
    tabs: 'tabs',
    max: 5,
    menuCurrent: 'metismenu a',
    defaultPage: $('.default-iframe'),
    otherUrlClick: $('.other-url'),
    otherUrlClassName: 'other-url',
    params: undefined
  };
})(jQuery, document, window);