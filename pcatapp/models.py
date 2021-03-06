from django.db import models
from django.contrib.auth.models import User
from django.core.mail import send_mail
from django.utils import timezone


class Student(models.Model):
	gpa = models.DecimalField('gpa', max_digits = 3, decimal_places = 2, null = True, blank = True)
	zip_code = models.CharField('zip code', max_length = 5, null = True, blank = True)
	pcat = models.IntegerField('pcat', max_length = 3, null = True, blank = True)
	min_tuition = models.IntegerField('min_tuition', null = True, blank = True)
	max_tuition = models.IntegerField('max_tuition', null = True, blank = True)
	ranked_favorites = models.ManyToManyField('Ranked')
	unranked_favorites = models.ManyToManyField('Unranked')
	user = models.OneToOneField(User)


class Ranked(models.Model):
	name = models.CharField('name', max_length = 100)
	city = models.CharField('city', max_length = 50)
	state = models.CharField('state', max_length = 30)
	zip_code = models.CharField('zip code', max_length = 5)
	gpa_overall = models.DecimalField('gpa overall', max_digits = 3, decimal_places = 2, null = True, blank = True)
	gpa_expected = models.DecimalField('gpa expected', max_digits = 3, decimal_places = 2, null = True, blank = True)
	gpa_avg = models.DecimalField('gpa average', max_digits = 3, decimal_places = 2, null = True, blank = True)
	min_pcat = models.IntegerField('min pcat', max_length = 3, null = True, blank = True)
	resident_tuition = models.IntegerField('resident tuition', max_length = 6)
	nonresident_tuition = models.IntegerField('non-resident tuition', max_length = 6)

	regional_tuition = models.CharField('regional tuition', max_length = 100, null = True, blank = True, default = False)
	regional_bool = models.BooleanField('regional boolean', default = False)

	supplemental = models.BooleanField(default = False)
	three_year = models.BooleanField(default = False)
	dual_degree = models.BooleanField(default = False)
	full_accred = models.BooleanField(default = True)
	cand_accred = models.BooleanField(default = False)
	prec_accred = models.BooleanField(default = False)

	lat = models.DecimalField('latitude', max_digits = 7, decimal_places = 4, null = True, blank = True)
	lon = models.DecimalField('longitude', max_digits = 7, decimal_places = 4, null = True, blank = True)

	school_url = models.URLField('School URL', null = True, blank = True, max_length = 75)
	street = models.CharField('Street Address', null = True, blank = True, max_length = 100)
	email = models.EmailField('Email', null = True, blank = True)
	phone = models.CharField('Phone', null = True, blank = True, max_length = 12)


	rank = models.IntegerField('rank', max_length = 3)

	def __unicode__(self):
		return self.name

	def save(self, *args, **kwargs):
         if not self.regional_tuition:
              self.regional_tuition = None
         super(Ranked, self).save(*args, **kwargs)

class Unranked(models.Model):
	name = models.CharField('name', max_length = 100)
	city = models.CharField('city', max_length = 50)
	state = models.CharField('state', max_length = 30)
	zip_code = models.CharField('zip code', max_length = 5)
	gpa_overall = models.DecimalField('gpa overall', max_digits = 3, decimal_places = 2, null = True, blank = True)
	gpa_expected = models.DecimalField('gpa expected', max_digits = 3, decimal_places = 2, null = True, blank = True)
	gpa_avg = models.DecimalField('gpa average', max_digits = 3, decimal_places = 2, null = True, blank = True)
	min_pcat = models.IntegerField('min pcat', max_length = 3, null = True, blank = True)
	resident_tuition = models.IntegerField('resident tuition', max_length = 6)
	nonresident_tuition = models.IntegerField('non-resident tuition', max_length = 6)

	regional_tuition = models.CharField('regional tuition', max_length = 100, null = True, blank = True)
	regional_bool = models.BooleanField('regional boolean', default = False)


	supplemental = models.BooleanField(default = False)
	three_year = models.BooleanField(default = False)
	dual_degree = models.BooleanField(default = False)
	
	full_accred = models.BooleanField(default = True)
	cand_accred = models.BooleanField(default = False)
	prec_accred = models.BooleanField(default = False)

	lat = models.DecimalField('latitude', max_digits = 7, decimal_places = 4, null = True, blank = True)
	lon = models.DecimalField('longitude', max_digits = 7, decimal_places = 4, null = True, blank = True)

	school_url = models.URLField('School URL', null = True, blank = True, max_length = 75)
	street = models.CharField('Street Address', null = True, blank = True, max_length = 100)
	email = models.EmailField('Email', null = True, blank = True)
	phone = models.CharField('Phone', null = True, blank = True, max_length = 12)

	def __unicode__(self):
		return self.name

	def save(self, *args, **kwargs):
         if not self.regional_tuition:
              self.regional_tuition = None
         super(Unranked, self).save(*args, **kwargs)




