# Generated by Django 2.1rc1 on 2018-07-28 21:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Knowledge_Base', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='example',
            name='example_input',
            field=models.ImageField(blank=True, max_length=500, null=True, upload_to='examples/input', verbose_name='Input'),
        ),
        migrations.AlterField(
            model_name='example',
            name='example_output',
            field=models.ImageField(blank=True, max_length=500, null=True, upload_to='examples/output', verbose_name='Output'),
        ),
        migrations.AlterField(
            model_name='rdataset',
            name='data_set_overview',
            field=models.ImageField(blank=True, max_length=500, null=True, upload_to='data_set/', verbose_name='Data set Overview'),
        ),
    ]
