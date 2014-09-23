from django.conf.urls import patterns, include, url
from tastypie.api import Api
from django.contrib import admin
from resources import RankedResource, UnrankedResource, UserResource, StudentResource

admin.autodiscover()

v1_api = Api(api_name = 'v1')
v1_api.register(RankedResource())
v1_api.register(UnrankedResource())
v1_api.register(UserResource())
v1_api.register(StudentResource())


urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'pcat.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^', include('pcatapp.urls', namespace = 'pcatapp')),
    url(r'^accounts/', include('allauth.urls')),
    url(r'^api/', include(v1_api.urls)),
)
