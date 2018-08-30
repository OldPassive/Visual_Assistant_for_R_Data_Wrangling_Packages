"""Visual_Assistant_for_R_Data_Wrangling_Packages URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
# -*- coding: utf-8 -*-
from django.contrib import admin
from django.urls import path
from django.conf.urls import url, include

from django.views.generic import TemplateView
from django.views.static import serve

from Visual_Assistant_for_R_Data_Wrangling_Packages.settings import MEDIA_ROOT
from Knowledge_Base.views import IndexView

urlpatterns = [
    path(r'admin/', admin.site.urls),
    #url('^$', TemplateView.as_view(template_name="Knowledge_Base/index.html"), name="index"),
    url('^$', IndexView.as_view(), name="index"),
    url('^data-manipulation-index/$', TemplateView.as_view(template_name="Knowledge_Base/dm-index.html"),
        name="dm_index"),
    url('^data-tidying-index/', TemplateView.as_view(template_name="Knowledge_Base/dt-index.html"), name="dt_index"),
    url('^data-visualization-index/', TemplateView.as_view(template_name="Knowledge_Base/dv-index.html"),
        name="dv_index"),
    url(r'^uploads/(?P<path>.*)$', serve, {"document_root": MEDIA_ROOT}),
    url('^', include(('Knowledge_Base.urls', 'Knowledge_Base'), namespace='kb')),
]
