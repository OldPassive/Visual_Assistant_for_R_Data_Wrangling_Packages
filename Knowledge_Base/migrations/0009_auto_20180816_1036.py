# Generated by Django 2.1rc1 on 2018-08-16 09:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Knowledge_Base', '0008_auto_20180816_0439'),
    ]

    operations = [
        migrations.AlterField(
            model_name='dwsubcategory',
            name='subcategory_explanation',
            field=models.CharField(blank=True, max_length=1000, null=True),
        ),
    ]
