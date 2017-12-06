/**
 * 初始化js文件
 */

// 菜单初始化
$('#side-menu').slimScroll({
	height : '100%',
	railOpacity : 0.9,
	alwaysVisible : false,
	size : '10px'
});

// 设置点击菜单的页面纳入iframe管理
$('.sidebar-collapse .nav li').on('click', function() {
	var url = $(this).find('a').attr('href');
	var openMethod = $(this).find('a').attr('data-type');
	if (url.indexOf('/') != -1) {
		if (openMethod != 'undefined' && openMethod == 2) {
			window.open(url);
		} else {
			$('#page-wrapper iframe').attr('src', url);
		}
		return false;
	}
});
