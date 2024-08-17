from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse,HttpResponseBadRequest
from django.core.files.storage import FileSystemStorage
from fts_app.models import StoreDocument, Role, User, Message, UserDetail, CorrespondenceUserMap, Correspondence, Noting, NotingUserMap
from django.core.exceptions import ValidationError  
from django.utils import timezone
from django.contrib import messages
import os
from .helpers.common_helper import download_file
from .decorators import check_session_exists 
from django.db.models import F,Subquery, OuterRef  
from django.conf import settings
import random
from django.core.files.base import ContentFile
import base64


@check_session_exists
def index(request):
   return HttpResponse("Hello")
    

 


@check_session_exists 
def dakghar(request): 
    if request.method == 'POST':
        ALLOWED_EXTENSIONS = ['pdf', 'doc', 'docx', 'png', 'jpg']
        if 'uploadfile' in request.FILES:
            upload_file = request.FILES['uploadfile']
            title = request.POST.get('title')
            user_id = request.session.get('user_id')

            # Get the file extension
            file_extension = upload_file.name.split('.')[-1].lower()

            # Check if the file extension is allowed
            if file_extension not in ALLOWED_EXTENSIONS:
                # Return a bad request response with an error message
                error_message = 'Unknown file format. Only PDF, DOC, DOCX, PNG, and JPG files are allowed.'
                messages.error(request, error_message)
                return redirect('dashboard-dakghar')
            try:
                filename = f"{timezone.now().strftime('%Y%m%d%H%M%S')}.{file_extension}"
                fs = FileSystemStorage()
                filename = fs.save(filename, upload_file)

                # Create a StoreDocument object to store metadata about the uploaded file
                document = StoreDocument.objects.create(title=title, filename=filename, user_id=user_id)

                # Redirect to a success page or perform any additional actions
                return redirect('dashboard-dakghar-documents')

            except ValidationError:
                # Handle validation errors
                messages.error(request, 'Error occurred while uploading the file.')
                return redirect('dashboard-dakghar')
        else:
            # No file was uploaded
            messages.error(request, 'Please select a file to upload.')
            return redirect('dashboard-dakghar')

    data = {'section' : "upload_form"}
    return render(request, 'dakghar.html', data) 






@check_session_exists
def dakghar_documents(request):
    uid = request.session.get('user_id')
    role = request.session.get('role')

    documents = StoreDocument.objects.filter().order_by('-pk') 

    data = {
        'section': "dakghar_documents",
        'documents': documents
    }
    return render(request, 'dakghar.html', data)





@check_session_exists
def dakghar_documents_forward(request, doc_id): 
    documents = StoreDocument.objects.filter(id=doc_id).order_by('-pk') if doc_id else None
    
    if request.method == 'POST':
        role_ids = request.POST.getlist('sentTo[]')
        users = User.objects.filter(user_role_maps__role__id__in=role_ids)
        note_msg = request.POST.get('note_msg')
        sender_id = request.session.get('user_id')
        sender_email = User.objects.get(id=sender_id).email if sender_id else ''

        for user in users:
            to_email = user.email
            msg = Message(
                from_email=sender_email,
                to_email=to_email,
                message=note_msg,
                status=1,
                from_user_id=sender_id,
                to_user_id=user.id,
                document_id=doc_id  
            )
            msg.save() 

        StoreDocument.objects.filter(id=doc_id).update(status=2)
        messages.success(request, 'Messages sent successfully!')

    roles = Role.objects.filter(role_name__in=['admin','gms','gm'])   
    data = {'section': 'dakghar_documents_forward', 'documents': documents, 'roles': roles, 'doc_id': doc_id} 
    return render(request, 'dakghar.html', data)






@check_session_exists
def dakghar_delete_document(request, doc_id):
    # Retrieve the document object
    dakghar_document = get_object_or_404(StoreDocument, pk=doc_id)

    # Get the filename from the document object
    filename = dakghar_document.filename

    # Construct the full file path
    file_path = os.path.join(settings.MEDIA_ROOT, filename)

    # Delete the file from the filesystem
    try:
        os.remove(file_path)
        messages.success(request, 'File deleted successfully!')
    except OSError as e:
        messages.error(request, f'Error deleting file: {e}')

    # Delete the document object from the database
    dakghar_document.delete()

    messages.success(request, 'Document Deleted!')
    return redirect('dashboard-dakghar-documents')






@check_session_exists
def manager(request):
    uid = request.session.get('user_id')
    receive_forwarded_count = get_receive_forwarded_count(uid)
    data = {"receive_forwarded_count" : receive_forwarded_count}
    return render(request,'dashboard-gm.html',data);
  
   


# def department(request): 
#     uid = request.session.get('user_id')

#     correspondence_ids = []

#     getCorrespondenceIds = CorrespondenceUserMap.objects.filter(to_user_id=uid) 

#     for corr in getCorrespondenceIds:
#         correspondence_ids.append(corr.correspondence_id)

#     # Fetch all Correspondence instances corresponding to the collected correspondence_ids
#     correspondences = Correspondence.objects.filter(pk__in=correspondence_ids)
    
#     # Fetch StoreDocument instances for each Correspondence instance
#     for correspondence in correspondences:
#         document_ids = correspondence.documents.split(',')
#         documents = StoreDocument.objects.filter(pk__in=document_ids)
#         correspondence.documents = documents 

#     # return HttpResponse(correspondences)    
    
#     data = {'section': "list", 'correspondences': correspondences} 
#     return render(request,'dashboard-department.html',data); 



@check_session_exists
def dashboard_department(request):
    uid = request.session.get('user_id')

    received_corr_count = CorrespondenceUserMap.objects.filter(to_user_id = uid).count()
    forwarded_corr_count = CorrespondenceUserMap.objects.filter(from_user_id = uid).count()

    corr_count = {'received_corr_count' : received_corr_count,'forwarded_corr_count':forwarded_corr_count}
    receive_forwarded_count = get_receive_forwarded_count(uid)
    data = {'section': "dashboard_department",'corr_count':corr_count,'receive_forwarded_count' : receive_forwarded_count} 
    return render(request,'dashboard-department.html',data); 






@check_session_exists 
def incoming_correspondence_department(request):  
    uid = request.session.get('user_id')
    

    # queryset = CorrespondenceUserMap.objects \
    #     .filter(to_user_id = uid) \
    #     .select_related('correspondence','user') \
    #     .values('id', 'status', 'correspondence__id', 'correspondence__corr_no', 'correspondence__priority', 'correspondence__int_ext', 'correspondence__name_of_designation', 'correspondence__email_id', 'correspondence__type_of_doc', 'correspondence__do_received_from', 'correspondence__reference_number', 'correspondence__reference_date', 'correspondence__subject', 'correspondence__action_marked', 'correspondence__date_of_forwarding', 'correspondence__department_id', 'correspondence__sub_department_id', 'correspondence__documents', 'correspondence__status', 'correspondence__user_id', 'correspondence__role_id')
    
    queryset = CorrespondenceUserMap.objects \
    .filter(to_user_id=uid) \
    .select_related('correspondence', 'from_user', 'to_user') \
    .values(
        'id','is_opened','message','is_forwarded', 'status', 'correspondence__id', 'correspondence__corr_no', 
        'correspondence__priority', 'correspondence__int_ext', 
        'correspondence__name_of_designation', 'correspondence__email_id', 
        'correspondence__type_of_doc', 'correspondence__do_received_from', 
        'correspondence__reference_number', 'correspondence__reference_date', 
        'correspondence__subject', 'correspondence__action_marked', 
        'correspondence__date_of_forwarding','correspondence__documents', 
        'correspondence__status', 'correspondence__user_id', 
        'correspondence__role_id',
        from_user_name=F('from_user__username'),  # Assuming 'username' is the field in User for the username
        from_user_role_name=F('from_user__user_role_maps__role__role_name'),  # Assuming 'role_name' is the field in Role for the user's role
        to_user_name=F('to_user__username')  # Assuming 'username' is the field in User for the username
    )

    for correspondence in queryset:
        document_ids = correspondence['correspondence__documents'].split(',')  # Access the field using dictionary syntax
        documents = StoreDocument.objects.filter(pk__in=document_ids)
        correspondence['documents'] = documents  # Store documents in the correspondence dictionary

    # queryset2 = CorrespondenceUserMap.objects.filter(to_user_id=uid)
    # queryset2.update(is_opened = 1)    
    
    received_corr_count = CorrespondenceUserMap.objects.filter(to_user_id = uid).count()
    forwarded_corr_count = CorrespondenceUserMap.objects.filter(from_user_id = uid).count()
    corr_count = {'received_corr_count' : received_corr_count,'forwarded_corr_count':forwarded_corr_count}    
    
    data = {'section': "incoming_list", 'correspondences': queryset,'corr_count':corr_count}
    return render(request,'dashboard-department.html',data);







@check_session_exists
def outgoing_correspondence_department(request): 
    uid = request.session.get('user_id')
    
    queryset = CorrespondenceUserMap.objects \
    .filter(from_user_id=uid) \
    .select_related('correspondence', 'from_user', 'to_user') \
    .values(
        'id', 'status', 'correspondence__id', 'correspondence__corr_no', 
        'correspondence__priority', 'correspondence__int_ext', 
        'correspondence__name_of_designation', 'correspondence__email_id', 
        'correspondence__type_of_doc', 'correspondence__do_received_from', 
        'correspondence__reference_number', 'correspondence__reference_date', 
        'correspondence__subject', 'correspondence__action_marked', 
        'correspondence__date_of_forwarding','correspondence__documents', 
        'correspondence__status', 'correspondence__user_id', 
        'correspondence__role_id','is_opened','is_forwarded', 
        from_user_name=F('from_user__username'),  # Assuming 'username' is the field in User for the username
        to_user_role_name=F('to_user__user_role_maps__role__role_name'),  # Assuming 'role_name' is the field in Role for the user's role
        to_user_name=F('to_user__username'),  # Assuming 'username' is the field in User for the username
    ) 
    
    for correspondence in queryset:
        document_ids = correspondence['correspondence__documents'].split(',')  # Access the field using dictionary syntax
        documents = StoreDocument.objects.filter(pk__in=document_ids)
        correspondence['documents'] = documents  # Store documents in the correspondence dictionary

    received_corr_count = CorrespondenceUserMap.objects.filter(to_user_id = uid).count()
    forwarded_corr_count = CorrespondenceUserMap.objects.filter(from_user_id = uid).count() 
    corr_count = {'received_corr_count' : received_corr_count,'forwarded_corr_count':forwarded_corr_count}    
    
    data = {'section': "outgoing_list", 'correspondences': queryset,'corr_count':corr_count}  
    return render(request,'dashboard-department.html',data);






@check_session_exists
def download_document(request,file_name):
   return download_file("20240510130830.pdf")






@check_session_exists
def dashboard_account(request):
    uid = request.session.get('user_id')

    if request.method == 'POST':
        phone = request.POST.get('phone')  
        fullname = request.POST.get('full_name')

        try:
            userdetail = UserDetail.objects.get(user_id=uid)
            userdetail.phone = phone
            userdetail.full_name = fullname
            userdetail.save()
            messages.success(request, 'User Detail Updated!')
        except UserDetail.DoesNotExist:
            messages.error(request, 'User Detail not found.')
        
        return redirect(request.path)  # Redirect back to the same page

    users = User.objects.filter(pk=uid).prefetch_related('user_details', 'user_role_maps')

    user_data = []
    for user in users:
        user_info = {
            'user': user,
            'user_details': list(user.user_details.all()),
            'user_role_maps': list(user.user_role_maps.all())
        }
        user_data.append(user_info)    

    data = {'section': "dashboard-account", 'user_data': user_data}
    return render(request, 'dashboard-account.html', data) 






def generate_unique_noting_number(): 
    digit_length = 6  
    max_retries = 10000  
    
    while True:
        for _ in range(max_retries):
            noting_number = f"N-{random.randint(10**(digit_length-1), (10**digit_length)-1)}"
            if not Noting.objects.filter(noting_no=noting_number).exists():
                return noting_number
       
        digit_length += 1






@check_session_exists
# def create_noting(request):
#     uid = request.session.get('user_id')
#     noting_rand_no = generate_unique_noting_number()
#     if request.method == 'POST':
#         ALLOWED_EXTENSIONS = ['pdf', 'docx', 'png', 'jpg'] 
#         upload_file_doc = request.FILES.get('uploadfile_doc')
#         upload_file_dak_doc = request.FILES.get('uploadfile_dak_doc') 

#         # Ensure both files are uploaded
#         if not upload_file_doc or not upload_file_dak_doc:
#             messages.error(request, 'Please select both document and dak document files to upload.')
#             return redirect('create-noting')

#         # Get the file extensions
#         file_extension_doc = upload_file_doc.name.split('.')[-1].lower()
#         file_extension_dak_doc = upload_file_dak_doc.name.split('.')[-1].lower()

#         # Check if the file extensions are allowed
#         if file_extension_doc not in ALLOWED_EXTENSIONS or file_extension_dak_doc not in ALLOWED_EXTENSIONS:
#             error_message = 'Unknown file format. Only PDF, DOC, DOCX, PNG, and JPG files are allowed.'
#             messages.error(request, error_message)
#             return redirect('create-noting')

#         try:
#             # Generate filenames
#             timestamp = timezone.now().strftime('%Y%m%d%H%M%S') 
#             filename_doc = f"{timestamp}.{file_extension_doc}" 
#             filename_dak_doc = f"{timestamp}.{file_extension_dak_doc}"  

#             # Save the files
#             fs = FileSystemStorage()
#             filename1 = fs.save(filename_doc, upload_file_doc) 
#             filename2 = fs.save(filename_dak_doc, upload_file_dak_doc)

#             # Get form data
#             noting_title = request.POST.get('noting_title')
#             noting_no = request.POST.get('noting_number') 
#             noting_comments = request.POST.get('noting_comments')
#             selected_role = request.POST.get('selected_role') 
#             selected_user = request.POST.get('selected-roles-users')
#             digital_signature = request.POST.get('noting_digital_signature')

#             # Create a Noting object
#             noting = Noting.objects.create(
#                 title=noting_title, 
#                 filename_doc=filename1,
#                 filename_dak_doc=filename2,
#                 noting_no=noting_no, 
#                 user_id=uid,
#                 role_id=selected_role,
#                 selected_user_id=selected_user,
#                 digital_signature=digital_signature
#             )

#             # Create a NotingUserMap object
#             NotingUserMap.objects.create(
#                 noting=noting,
#                 from_user_id=uid,
#                 to_user_id=selected_user,
#                 is_opened=0,
#                 is_forwarded=0,
#                 message=noting_comments
#             )

#             # Redirect to a success page or perform any additional actions
#             return redirect('list-notings')

#         except ValidationError:
#             # Handle validation errors
#             messages.error(request, 'Error occurred while uploading the file.') 
#             return redirect('create-noting') 

#     roles = Role.objects.filter(role_name__in=['co', 'go', 'do', 'hos','gm'])
#     data = {'section': "create_noting", 'roles': roles,'noting_rand_no':noting_rand_no}
#     return render(request, 'noting.html', data)  

def create_noting(request):
    uid = request.session.get('user_id')
    noting_rand_no = generate_unique_noting_number()

    if request.method == 'POST':
        ALLOWED_EXTENSIONS = ['pdf', 'docx', 'png', 'jpg']
        upload_file_doc = request.FILES.get('uploadfile_doc')
        upload_file_dak_doc = request.FILES.get('uploadfile_dak_doc')

        # Ensure document file is uploaded
        if not upload_file_doc:
            messages.error(request, 'Please select a document file to upload.')
            return redirect('create-noting')

        # Check file extensions
        file_extension_doc = upload_file_doc.name.split('.')[-1].lower()
        file_extension_dak_doc = upload_file_dak_doc.name.split('.')[-1].lower() if upload_file_dak_doc else None

        if file_extension_doc not in ALLOWED_EXTENSIONS or (upload_file_dak_doc and file_extension_dak_doc not in ALLOWED_EXTENSIONS):
            error_message = 'Unknown file format. Only PDF, DOCX, PNG, and JPG files are allowed.'
            messages.error(request, error_message)
            return redirect('create-noting')

        try:
            # Generate filenames
            timestamp = timezone.now().strftime('%Y%m%d%H%M%S')
            filename_doc = f"{timestamp}.{file_extension_doc}"
            filename_dak_doc = f"{timestamp}.{file_extension_dak_doc}" if upload_file_dak_doc else None

            # Save files
            fs = FileSystemStorage()
            filename1 = fs.save(filename_doc, upload_file_doc)
            if upload_file_dak_doc:
                filename2 = fs.save(filename_dak_doc, upload_file_dak_doc)
            else:
                filename2 = None

            # Get form data
            noting_title = request.POST.get('noting_title')
            noting_no = request.POST.get('noting_number')
            noting_comments = request.POST.get('noting_comments')
            selected_role = request.POST.get('selected_role')
            selected_user = request.POST.get('selected-roles-users')
            digital_signature = request.POST.get('noting_digital_signature')

            if not noting_comments:  # Check if the comment is empty or None
             noting_comments = None 

            # Handle digital signature (optional)
            signature_data = request.POST.get('signature')
            signature_filename = None
            if signature_data:
                format, imgstr = signature_data.split(';base64,')
                ext = format.split('/')[-1]
                signature_filename = f"{timestamp}_signature.{ext}"
                signature_path = os.path.join(settings.MEDIA_ROOT, 'signatures', signature_filename)

                # Create the directory if it doesn't exist
                if not os.path.exists(os.path.dirname(signature_path)):
                    os.makedirs(os.path.dirname(signature_path))

                # Decode and save the signature image
                with open(signature_path, "wb") as f:
                    f.write(base64.b64decode(imgstr))

            # Create Noting object
            noting = Noting.objects.create(
                title=noting_title,
                filename_doc=filename1,
                filename_dak_doc=filename2,
                noting_no=noting_no,
                user_id=uid,
                role_id=selected_role,
                selected_user_id=selected_user,
                comment=noting_comments,
                digital_signature=digital_signature,
                signature_image=signature_filename  # Save the filename of the signature
            )

            # Create NotingUserMap object
            NotingUserMap.objects.create(
                noting=noting,
                from_user_id=uid,
                to_user_id=selected_user,
                is_opened=0,
                is_forwarded=0,
                message=noting_comments,
                digital_signature=digital_signature,
                signature_image=signature_filename
            )

            return redirect('list-notings')

        except ValidationError:
            messages.error(request, 'Error occurred while uploading the file.')
            return redirect('create-noting')

    roles = Role.objects.filter(role_name__in=['co', 'go', 'do', 'hos', 'gm'])
    data = {'section': "create_noting", 'roles': roles, 'noting_rand_no': noting_rand_no}
    return render(request, 'noting.html', data) 



@check_session_exists
def search_noting(request): 
    uid = request.session.get('user_id')
    if request.method == 'POST':
        search_by_noting_no = request.POST.get('search_by_noting_no', '')
        if search_by_noting_no:
            notings = NotingUserMap.objects \
                .filter(noting__noting_no=search_by_noting_no) \
                .select_related('noting', 'from_user', 'to_user') \
                .values(
                    'id', 'is_opened', 'message', 'is_forwarded', 'status', 'created', 'updated',
                    'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
                    'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title',
                    'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
                    from_user_name=F('from_user__username'),
                    from_user_role_name=F('from_user__user_role_maps__role__role_name'),  # Get the role name of from_user
                    to_user_name=F('to_user__username'),
                    to_user_role_name=F('to_user__user_role_maps__role__role_name')  # Get the role name of to_user
                ).order_by('-id')  
        else:
            notings = NotingUserMap.objects.none()  # Return empty queryset for NotingUserMap
    else:
        notings = NotingUserMap.objects.none()  # Return empty queryset for NotingUserMap
    receive_forwarded_count = get_receive_forwarded_count(uid)
    data = {'section': "search_noting", 'notings': notings,'receive_forwarded_count': receive_forwarded_count, }
    return render(request, 'noting.html', data)







def search_noting_view(request, noting_id):
    uid = request.session.get('user_id')
    if noting_id:
        # Query the Noting object
        noting = Noting.objects.get(id=noting_id)

        # Query the NotingUserMap related objects
        notings_map = NotingUserMap.objects \
            .filter(noting_id=noting_id) \
            .select_related('noting', 'from_user', 'to_user') \
            .values(
                'id', 'is_opened', 'message', 'is_forwarded', 'status', 'digital_signature',
                'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
                'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title',
                'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
                from_user_name=F('from_user__username'),
                to_user_name=F('to_user__username')
            )

        # Extract file extensions
        file_doc_extension = os.path.splitext(noting.filename_doc)[1][1:] if noting.filename_doc else ""
        file_dak_doc_extension = os.path.splitext(noting.filename_dak_doc)[1][1:] if noting.filename_dak_doc else ""

        noting_with_extension = {
            'noting': noting,
            'file_doc_extension': file_doc_extension,
            'file_dak_doc_extension': file_dak_doc_extension,
        }
    else:
        noting_with_extension = None
        notings_map = []
    
    receive_forwarded_count = get_receive_forwarded_count(uid)
    data = {
        'section': "search_noting_view", 
        'noting_with_extension': noting_with_extension, 
        'notings_map': notings_map,
        'receive_forwarded_count': receive_forwarded_count, 
    }

    return render(request, 'noting.html', data)




 



@check_session_exists
def incoming_noting(request):
    uid = request.session.get('user_id')
    
    if uid is None:
        return render(request, 'noting.html', {'section': "incoming_noting", 'notings': []})
    
    notings = NotingUserMap.objects \
        .filter(to_user_id =uid) \
        .select_related('noting', 'from_user__user_role_maps__role', 'to_user__user_role_maps__role') \
        .values(
            'id', 'is_opened', 'message', 'is_forwarded', 'status', 'created', 'updated',
            'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
            'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title',
            'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
            from_user_name=F('from_user__username'),
            from_user_role_name=F('from_user__user_role_maps__role__role_name'),  # Get the role name of from_user
            to_user_name=F('to_user__username'),
            to_user_role_name=F('to_user__user_role_maps__role__role_name')  # Get the role name of to_user
        ).order_by('-id') 
    receive_forwarded_count = get_receive_forwarded_count(uid)
    data = {'section': "incoming_noting",'notings' : notings,'receive_forwarded_count': receive_forwarded_count,} 
    return render(request,'noting.html',data)






@check_session_exists
def forwarded_noting(request): 
    uid = request.session.get('user_id')
    
    if uid is None:
        return render(request, 'noting.html', {'section': "incoming_noting", 'notings': []})
    
    notings = NotingUserMap.objects \
    .filter(from_user_id=uid) \
    .select_related('noting', 'from_user__user_role_maps__role', 'to_user__user_role_maps__role') \
    .values(
        'id', 'is_opened', 'message', 'is_forwarded', 'status', 'created', 'updated',
        'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
        'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title',
        'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
        from_user_name=F('from_user__username'),
        from_user_role_name=F('from_user__user_role_maps__role__role_name'),  # Get the role name of from_user
        to_user_name=F('to_user__username'),
        to_user_role_name=F('to_user__user_role_maps__role__role_name')  # Get the role name of to_user
    ).order_by('-id')  

    receive_forwarded_count = get_receive_forwarded_count(uid)
    data = {'section': "forwarded_noting",'notings' : notings,'receive_forwarded_count': receive_forwarded_count,}  
    return render(request,'noting.html',data)


 


@check_session_exists
def list_notings(request): 
    uid = request.session.get('user_id') 
    notings = Noting.objects.filter(user_id=uid).order_by('-pk')

    for noting in notings:
        # Initialize the arrays for users
        array_from_user_name = []
        array_from_user_role_name = []
        array_to_user_name = []
        array_to_user_role_name = []

        # Query for NotingUserMap related to the current noting
        notings_map = NotingUserMap.objects \
            .filter(noting_id=noting.id) \
            .select_related('noting', 'from_user', 'to_user') \
            .values(
                'id', 'is_opened', 'message', 'is_forwarded', 'status', 'created', 'updated',
                'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
                'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title',
                'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
                from_user_name=F('from_user__username'),
                from_user_role_name=F('from_user__user_role_maps__role__role_name'),  # Get the role name of from_user
                to_user_name=F('to_user__username'),
                to_user_role_name=F('to_user__user_role_maps__role__role_name')  # Get the role name of to_user
            ).order_by('-id') 

        # Collect the usernames and roles
        for map_item in notings_map:
            array_from_user_name.append(map_item['from_user_name'])
            array_from_user_role_name.append(map_item['from_user_role_name'])
            array_to_user_name.append(map_item['to_user_name'])
            array_to_user_role_name.append(map_item['to_user_role_name']) 

        # Attach the arrays to each noting object (as attributes, not in the database)
        noting.array_from_user_name2 = array_from_user_name
        noting.array_from_user_role_name2 = array_from_user_role_name
        noting.array_to_user_name2 = array_to_user_name
        noting.array_to_user_role_name2 = array_to_user_role_name 

    receive_forwarded_count = get_receive_forwarded_count(uid)
    data = {
        'section': "list_notings",
        'notings': notings,
        'receive_forwarded_count': receive_forwarded_count
    }
    return render(request, 'noting.html', data)







@check_session_exists 
def view_noting(request, noting_id): 
    notings = Noting.objects.filter(id=noting_id)
    uid = request.session.get('user_id')
    
    # Prepare the data with file extensions
    notings_with_extension = []
    for noting in notings:
        # Extract extension for filename_doc
        file_doc_extension = os.path.splitext(noting.filename_doc)[1][1:]
        
        # Extract extension for filename_dak_doc if it exists
        file_dak_doc_extension = os.path.splitext(noting.filename_dak_doc)[1][1:] if noting.filename_dak_doc else None

        # Get the NotingUserMap data
        notings_map = NotingUserMap.objects \
            .filter(noting_id=noting_id, from_user_id=noting.user_id) \
            .select_related('noting', 'from_user', 'to_user') \
            .values(
                'id', 'is_opened', 'message', 'is_forwarded', 'status', 'created', 'updated',
                'digital_signature', 'signature_image',
                'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
                'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title',
                'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
                from_user_name=F('from_user__username'),
                from_user_role_name=F('from_user__user_role_maps__role__role_name'),
                to_user_name=F('to_user__username'),
                to_user_role_name=F('to_user__user_role_maps__role__role_name')
            ).order_by('-id')

        notings_with_extension.append({
            'noting': noting,
            'notings_map': list(notings_map),  # Converting to list for easy iteration in template
            'file_doc_extension': file_doc_extension,
            'file_dak_doc_extension': file_dak_doc_extension,
        })

    notings_map2 = NotingUserMap.objects \
            .filter(noting_id=noting_id) \
            .select_related('noting', 'from_user', 'to_user') \
            .values(
                'id', 'is_opened', 'message', 'is_forwarded', 'status', 'created', 'updated',
                'digital_signature', 'signature_image',
                'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
                'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title',
                'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
                from_user_name=F('from_user__username'),
                from_user_role_name=F('from_user__user_role_maps__role__role_name'),
                to_user_name=F('to_user__username'),
                to_user_role_name=F('to_user__user_role_maps__role__role_name')
            ).order_by('-id')    
    
    receive_forwarded_count = get_receive_forwarded_count(uid)
    data = {
        'section': "view_noting", 
        'notings_map2' : notings_map2,
        'notings_with_extension': notings_with_extension,
        'receive_forwarded_count': receive_forwarded_count
    }
    
    return render(request, 'noting.html', data)








@check_session_exists 
def view_noting_map(request, noting_user_map_id): 
    uid = request.session.get('user_id')

    if request.method == 'POST':
        noting_id = request.POST.get('noting_id')
        noting_map_id = request.POST.get('noting_map_id')
        noting_comments = request.POST.get('add_comment')
        digital_sign = request.POST.get('add_digital_sign')
        selected_role = request.POST.get('selected_role')
        selected_user = request.POST.get('selected_roles_users')
          
        # Retrieve the Noting instance
        noting_instance = get_object_or_404(Noting, pk=noting_id)

        # Create the NotingUserMap instance
        NotingUserMap.objects.create(
            noting=noting_instance,
            from_user_id=uid,
            to_user_id=selected_user,
            is_opened=0,
            is_forwarded=0,
            message=noting_comments,
            digital_signature=digital_sign 
        )
        update_noting_forward_value(noting_user_map_id)      
        messages.success(request, 'Noting Forwarded Successfully.') 

    
    if uid is None: 
        return render(request, 'noting.html', {'section': "incoming_noting", 'notings': []})
    
    notings = NotingUserMap.objects \
        .filter(id=noting_user_map_id) \
        .select_related('noting', 'from_user', 'to_user') \
        .values(
            'id', 'is_opened', 'message', 'is_forwarded', 'status','created',
            'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
            'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title', 
            'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
            from_user_name=F('from_user__username'),
            to_user_name=F('to_user__username')
        )
    
    
    # Handling the case where the ID might not exist.
    if not notings.exists():
        return render(request, 'noting.html', {'section': "view_noting_map", 'notings': [], 'error': "No data found"})
    
    # Prepare the data with file extensions
    notings_with_extension = []
    for noting in notings:
        file_doc_extension = os.path.splitext(noting['noting__filename_doc'])[1][1:]
        file_dak_doc_extension = os.path.splitext(noting['noting__filename_dak_doc'])[1][1:] if noting['noting__filename_dak_doc'] else None

        notings_with_extension.append({ 
            'noting': noting,
            'file_doc_extension': file_doc_extension,
            'file_dak_doc_extension': file_dak_doc_extension,
        })

    # Query for notings2 with additional fields
    notings2 = NotingUserMap.objects \
        .filter(noting_id=noting['noting__id']) \
        .select_related('noting', 'from_user', 'to_user') \
        .values(
                'id', 'is_opened', 'message', 'is_forwarded', 'status', 'created', 'updated','digital_signature','signature_image',
                'noting__id', 'noting__noting_no', 'noting__filename_doc', 'noting__filename_dak_doc',
                'noting__comment', 'noting__digital_signature', 'noting__status', 'noting__title',
                'noting__user_id', 'noting__selected_user_id', 'noting__role_id',
                from_user_name=F('from_user__username'),
                from_user_role_name=F('from_user__user_role_maps__role__role_name'),  # Get the role name of from_user
                to_user_name=F('to_user__username'),
                to_user_role_name=F('to_user__user_role_maps__role__role_name')  # Get the role name of to_user
            ).order_by('-id') 

    update_noting_open_value(uid, noting_user_map_id)    
    roles = Role.objects.filter(role_name__in=['co', 'go', 'do', 'hos','gm']) 
    receive_forwarded_count = get_receive_forwarded_count(uid)  
     
    data = {'section': "view_noting_map", 'notings_with_extension': notings_with_extension, 'roles': roles, 'receive_forwarded_count': receive_forwarded_count, 'notings2': notings2}  
    return render(request, 'noting.html', data)








def update_noting_open_value(uid,noting_user_map_id):  
    NotingUserMap.objects.filter(id=noting_user_map_id).exclude(from_user_id=uid).update(is_opened=1)





def update_noting_forward_value(noting_user_map_id):     
    NotingUserMap.objects.filter(id=noting_user_map_id).update(is_forwarded=1) 




def get_receive_forwarded_count(uid):   
    received_noting_count  = NotingUserMap.objects.filter(to_user_id = uid).count()
    forwarded_noting_count = NotingUserMap.objects.filter(from_user_id = uid).count()
    created_noting_count   = Noting.objects.filter(user_id = uid).count()  
    corr_count = {
                   'received_noting_count' : received_noting_count,
                   'forwarded_noting_count':forwarded_noting_count,
                   'created_noting_count' : created_noting_count
                } 
    return corr_count 


