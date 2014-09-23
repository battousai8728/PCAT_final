from django.conf.urls import patterns, include, url
from pcatapp import views

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'pcat.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^$', views.index, name = 'index'),
    url(r'^search/$', views.sByInfo2, name = 'sByInfo'),
    url(r'^about/$', views.aboutPage, name = 'aboutPage'),
    url(r'^contact/$', views.contactPage, name = 'contactPage'),
    url(r'^contact/sent/$', views.feedback, name = 'feedback'),
    url(r'^faq/$', views.faq, name = 'faq'),
    url(r'^searchn/$', views.sByName, name = 'sByName'),
    url(r'^searchr/$', views.refineSearch3, name = "refineSearch"),
    url(r'^rdetail/(?P<id>\d+)/$', views.rankedDetail, name = "rankedDetail"),
    url(r'^udetail/(?P<id>\d+)/$', views.unrankedDetail, name = "unrankedDetail"),
    url(r'^createstudent/$', views.createStudent, name = 'createStudent'),
    url(r'^showprofile/$', views.showProfile, name = "showProfile"),
    url(r'^editprofile/$', views.editProfile, name = "editProfile"),
    url(r'^myfavorites/$', views.showFavorites, name = "showFavorites"),
    url(r'^addfavoriter/(?P<id>\d+)/$', views.addFavoriteR, name = "addFavoriteR"),
    url(r'^addfavoriteu/(?P<id>\d+)/$', views.addFavoriteU, name = "addFavoriteU"),
    url(r'^removefavoriter/(?P<id>\d+)/$', views.removeFavoriteR, name = "removeFavoriteR"),
    url(r'^removefavoriteu/(?P<id>\d+)/$', views.removeFavoriteU, name = "removeFavoriteU"),

)
