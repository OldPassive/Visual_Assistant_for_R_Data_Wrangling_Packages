from django.conf.urls import url

from Knowledge_Base.views import *

urlpatterns = [
    url('^data-manipulation-content/(\d+)/$', DMView.as_view(), name="dm_content"),
    url('^data-tidying-content/(\d+)/$', DTView.as_view(), name="dt_content"),
    url('^data-visualization-content/(\d+)/$', DVView.as_view(), name="dv_content"),
    url('^data-sets/(\S+)/$', DSView.as_view(), name="data_sets"),
    url('^r-packages/(\S+)/$', RPView.as_view(), name="r_packages"),
    url('^background-knowledge/$', BGView.as_view(), name="dw_bg"),
]
