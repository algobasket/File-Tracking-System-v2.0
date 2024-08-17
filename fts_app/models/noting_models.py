#noting_models.py
from django.db import models
from .user_models import User, Role 

class Noting(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)  # ForeignKey to link with your custom user model
    noting_no = models.CharField(max_length=255)
    title = models.CharField(max_length=255)
    filename_doc = models.CharField(max_length=255)  # Assuming filename is stored as a string
    filename_dak_doc = models.CharField(max_length=255,null=True)  # Assuming filename is stored as a string
    role = models.ForeignKey(Role, on_delete=models.CASCADE)
    selected_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='selected_noting')
    comment = models.TextField(null=True)
    digital_signature = models.TextField(null=True)
    signature_image = models.CharField(max_length=255, blank=True, null=True)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    status = models.PositiveSmallIntegerField(default=1)  

    def __str__(self):
        return self.title 
    

class NotingUserMap(models.Model):   
      
    from_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_noting')
    to_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_noting')
    noting = models.ForeignKey(Noting, on_delete=models.CASCADE, related_name='noting_mappings')
    created = models.DateTimeField(auto_now_add=True)   
    updated = models.DateTimeField(auto_now=True) 
    status = models.IntegerField(default=1)  # Assuming default status as 1, change it according to your requirements
    is_opened = models.IntegerField(default=0)
    is_forwarded = models.IntegerField(default=0) 
    message = models.TextField(null=True) 
    digital_signature = models.TextField(null=True)
    signature_image = models.CharField(max_length=255, blank=True, null=True)  # Store the filename of the signature image      

    def __str__(self):
        return str(self.status)    

