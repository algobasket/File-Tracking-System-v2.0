# Generated by Django 4.2.11 on 2024-08-08 01:36

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("fts_app", "0013_noting_comment_noting_digital_signature"),
    ]

    operations = [
        migrations.AddField(
            model_name="noting",
            name="selected_user",
            field=models.ForeignKey(
                default=1,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="selected_noting",
                to="fts_app.user",
            ),
            preserve_default=False,
        ),
    ]
