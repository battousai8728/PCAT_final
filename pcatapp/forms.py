from django import forms
from django.forms import ModelForm
from pcatapp.models import Student

MY_CHOICES = (
		('', ''),
		('AL', 'AL'),
		('AK', 'AK'),
		('AZ', 'AZ'),
		('AR', 'AR'),
		('CA', 'CA'),
		('CO', 'CO'),
		('CT', 'CT'),
		('DE', 'DE'),
		('DC', 'DC'),
		('FL', 'FL'),
		('GA', 'GA'),
		('HI', 'HI'),
		('ID', 'ID'),
		('IL', 'IL'),
		('IN', 'IN'),
		('IA', 'IA'),
		('KS', 'KS'),
		('KY', 'KY'),
		('LA', 'LA'),
		('ME', 'ME'),
		('MD', 'MD'),
		('MA', 'MA'),
		('MI', 'MI'),
		('MN', 'MN'),
		('MS', 'MS'),
		('MO', 'MO'),
		('MT', 'MT'),
		('NE', 'NE'),
		('NV', 'NV'),
		('NH', 'NH'),
		('NJ', 'NJ'),
		('NM', 'NM'),
		('NY', 'NY'),
		('NC', 'NC'),
		('ND', 'ND'),
		('OH', 'OH'),
		('OK', 'OK'),
		('OR', 'OR'),
		('PA', 'PA'),
		('RI', 'RI'),
		('SC', 'SC'),
		('SD', 'SD'),
		('TN', 'TN'),
		('TX', 'TX'),
		('UT', 'UT'),
		('VT', 'VT'),
		('VA', 'VA'),
		('WA', 'WA'),
		('WV', 'WV'),
		('WI', 'WI'),
		('WY', 'WY'),
	)


class NameForm(forms.Form):
	name = forms.CharField(required = False, widget=forms.TextInput(attrs={'id':'id_name', 'placeholder': 'School Name'}))

class ParameterForm(forms.Form):
	pcat = forms.IntegerField(max_value = 100, min_value = 0, required = False)
	gpa = forms.FloatField(max_value = 4.0, min_value = 0.0, required = False)
	city = forms.CharField(required = False)
	state = forms.ChoiceField(choices=MY_CHOICES, required = False)

class RefineForm(forms.Form):
	min_pcat = forms.IntegerField(max_value = 100, min_value = 1, required = False, widget=forms.NumberInput(attrs={'class' : 'range_min'}))
	max_pcat = forms.IntegerField(max_value = 99, min_value = 0, required = False, widget=forms.NumberInput(attrs={'class' : 'range_max'}))
	min_gpa = forms.FloatField(max_value = 3.9, min_value = 0.0, required = False, widget=forms.NumberInput(attrs={'class' : 'range_min'}))
	max_gpa = forms.FloatField(max_value = 4.0, min_value = 0.1, required = False, widget=forms.NumberInput(attrs={'class' : 'range_max'}))

	city = forms.CharField(required = False)
	state = forms.ChoiceField(choices=MY_CHOICES, required = False)

	min_distance = forms.IntegerField(min_value = 1, required = False, widget=forms.NumberInput(attrs={'class' : 'range_min'}))
	max_distance = forms.IntegerField(min_value = 10, required = False, widget=forms.NumberInput(attrs={'class' : 'range_max'}))

	full_accred = forms.BooleanField(required = False, initial = False)
	cand_accred = forms.BooleanField(required = False, initial = False)
	prec_accred = forms.BooleanField(required = False, initial = False)

	dual = forms.BooleanField(required = False, initial=False)
	three = forms.BooleanField(required = False, initial=False)
	supp = forms.BooleanField(required = False, initial = False)

	max_tuition = forms.IntegerField(required = False, widget=forms.NumberInput(attrs={'class' : 'range_max'}))
	min_tuition = forms.IntegerField(required = False, widget=forms.NumberInput(attrs={'class' : 'range_min'}))


class StudentForm(ModelForm):
	class Meta:
		model = Student
		fields = ['pcat', 'gpa', 'zip_code']



class ContactForm(forms.Form):
	name = forms.CharField(required = False)
	email = forms.EmailField(required = True)
	subject = forms.CharField(required = False)
	message = forms.CharField(required = True, widget=forms.Textarea)
