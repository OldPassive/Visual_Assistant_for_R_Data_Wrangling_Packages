from django.shortcuts import render
from django.views.generic import View
from django.db.models import Q

from .models import *

# Create your views here.


class DMView(View):

    def get(self, request, r_function_id):
        dm_subcategories = DWSubcategory.objects.filter(category_id=1)
        current_r_function = RFunction.objects.get(function_id=r_function_id)
        function_usages = Usage.objects.filter(function_id=r_function_id)
        return render(request, "Knowledge_Base/dm-content.html", {
                "dm_subcategories": dm_subcategories,
                "current_r_function": current_r_function,
                "function_usages": function_usages,
        })


class DTView(View):

    def get(self, request, dt_function_id):
        dt_subcategories = DWSubcategory.objects.filter(category_id=2)
        current_dt_function = RFunction.objects.get(function_id=dt_function_id)
        dt_function_usages = Usage.objects.filter(function_id=dt_function_id)
        return render(request, "Knowledge_Base/dt-content.html", {
            "dt_subcategories": dt_subcategories,
            "current_dt_function": current_dt_function,
            "dt_function_usages": dt_function_usages,
        })


class DVView(View):

    def get(self, request, dv_function_id):
        dv_subcategories = DWSubcategory.objects.filter(category_id=3)
        current_dv_function = RFunction.objects.get(function_id=dv_function_id)
        dv_function_usages = Usage.objects.filter(function_id=dv_function_id)
        return render(request, "Knowledge_Base/dv-content.html", {
            "dv_subcategories": dv_subcategories,
            "current_dv_function": current_dv_function,
            "dv_function_usages": dv_function_usages,
        })


class BGView(View):

    def get(self, request):
        tidy_data = DWTerms.objects.get(term_id=1)
        dw_terms = DWTerms.objects.all()[1:5]
        steps = DWTerms.objects.all()[5:9]
        dw_subcategories = DWSubcategory.objects.filter(subcategory_explanation__isnull=False)
        return render(request, "Knowledge_Base/dw-background.html", {
            "tidy_data": tidy_data,
            "dw_terms": dw_terms,
            "dw_subcategories": dw_subcategories,
            "steps": steps,
        })


class DSView(View):

    def get(self, request, dataset_name):
        datasets = RDataSet.objects.all()
        current_dataset = RDataSet.objects.get(data_set_name=dataset_name)
        return render(request, "Knowledge_Base/dataset-content.html", {
            "datasets": datasets,
            "current_dataset": current_dataset,
        })


class RPView(View):

    def get(self, request, r_package_name):
        current_package = RPackage.objects.get(package_name=r_package_name)
        all_functions = current_package.get_package_functions
        search_keywords = request.GET.get('keyword', "")
        if search_keywords:
            all_functions = all_functions.filter(function_name__icontains=search_keywords)
        return render(request, "Knowledge_Base/r-package-content.html", {
            "current_package": current_package,
            "all_functions": all_functions,
        })


class IndexView(View):

    def get(self, request):
        all_functions = RFunction.objects.all()
        result_functions = RFunction.objects.none()
        dm_functions = RFunction.objects.filter(subcategory_id__lte=9)
        dt_functions = RFunction.objects.filter(subcategory_id__in=[10, 11])
        dv_functions = RFunction.objects.filter(subcategory_id__gte=12)
        all_packages = RPackage.objects.all()
        result_packages = RPackage.objects.none()
        search_keywords = request.GET.get('keyword', "")
        if search_keywords:
            result_functions = all_functions.filter(Q(function_name__icontains=search_keywords) |
                                                    Q(function_description__icontains=search_keywords))
            result_packages = all_packages.filter(Q(package_name__icontains=search_keywords) |
                                                  Q(package_description__icontains=search_keywords))
        return render(request, "Knowledge_Base/index.html", {
            'result_functions': result_functions,
            'result_packages': result_packages,
            'dm_functions': dm_functions,
            'dt_functions': dt_functions,
            'dv_functions': dv_functions,
        })
