from django.db import models

# Create your models here.


class DWTerms(models.Model):
    term_id = models.IntegerField(primary_key=True, verbose_name="Term Identity")
    term_name = models.CharField(max_length=100, verbose_name="Term")
    term_explanation = models.CharField(max_length=1000, verbose_name="Term Explanation")


class RDataSet(models.Model):
    data_set_name = models.CharField(primary_key=True, max_length=100, verbose_name="Data set Name")
    data_set_description = models.TextField(verbose_name="Description of the data set")
    data_set_format = models.CharField(max_length=1000, verbose_name="Format of the data set")
    data_set_overview = models.ImageField(upload_to='dataset', max_length=500, null=True, blank=True,
                                          verbose_name="Data set Overview")

    def __str__(self):
        return self.data_set_name


class DWCategory(models.Model):
    category_id = models.IntegerField(primary_key=True, verbose_name="Category Identity")
    category_name = models.CharField(max_length=50, verbose_name="Category")
    category_definition = models.CharField(max_length=500, verbose_name="Definition of the Category")

    def __str__(self):
        return self.category_name

    def get_dw_subcategory(self):
        return self.dwsubcategory_set.all()


class DWSubcategory(models.Model):
    category = models.ForeignKey(DWCategory, on_delete=models.CASCADE, verbose_name="Category")
    subcategory_id = models.IntegerField(primary_key=True, verbose_name="Subcategory Identity")
    subcategory_name = models.CharField(max_length=100, verbose_name="Subcategory")
    subcategory_explanation = models.CharField(max_length=2000, null=True, blank=True)

    def __str__(self):
        return self.subcategory_name

    def get_r_functions(self):
        return self.rfunction_set.all()


class RPackage(models.Model):
    package_name = models.CharField(primary_key=True, max_length=10, verbose_name="R Package Name")
    package_description = models.CharField(max_length=1000, verbose_name="Package Description")

    def get_package_functions(self):
        return self.rfunction_set.all()


class RFunction(models.Model):
    subcategory = models.ForeignKey(DWSubcategory, on_delete=models.CASCADE, verbose_name="Subcategory")
    package = models.ForeignKey(RPackage, on_delete=models.CASCADE, verbose_name="R Package Name")
    function_id = models.IntegerField(primary_key=True, verbose_name="Identity")
    function_name = models.CharField(max_length=100, verbose_name="Function Name")
    function_format = models.CharField(max_length=500, verbose_name="Function Code Format")
    function_description = models.TextField(verbose_name="Description")

    def __str__(self):
        return self.function_name

    def get_function_usages(self):
        return self.usage_set.all()


class Usage(models.Model):
    function = models.ForeignKey(RFunction, on_delete=models.CASCADE, verbose_name="Function")
    usage_id = models.IntegerField(primary_key=True, verbose_name="Usage Identity")
    usage_format = models.CharField(max_length=500, verbose_name="Function Usage Format")
    usage_description = models.TextField(verbose_name="Function Usage Description")

    def get_example(self):
        return self.example_set.all()


class Example(models.Model):
    usage = models.ForeignKey(Usage, on_delete=models.CASCADE, verbose_name="Usage")
    data_set = models.ForeignKey(RDataSet, on_delete=models.CASCADE, verbose_name="Data set")
    example_id = models.IntegerField(primary_key=True, verbose_name="Example Identity")
    example = models.CharField(max_length=500, verbose_name="Example Code")
    example_input = models.ImageField(upload_to='examples/input', max_length=500, null=True, blank=True,
                                      verbose_name="Input")
    example_output = models.ImageField(upload_to='examples/output', max_length=500, null=True, blank=True,
                                       verbose_name="Output")

    def __str__(self):
        return self.example

