# Generated by Django 2.1rc1 on 2018-07-29 15:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Knowledge_Base', '0004_auto_20180729_1529'),
    ]

    operations = [
        migrations.AlterField(
            model_name='rdataset',
            name='data_set_overview',
            field=models.ImageField(blank=True, max_length=500, null=True, upload_to='dataset', verbose_name='Data set Overview'),
        ),
    ]
