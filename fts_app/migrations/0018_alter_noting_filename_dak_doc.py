# Generated by Django 4.2.11 on 2024-08-13 08:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("fts_app", "0017_noting_signature_image"),
    ]

    operations = [
        migrations.AlterField(
            model_name="noting",
            name="filename_dak_doc",
            field=models.CharField(max_length=255, null=True),
        ),
    ]
