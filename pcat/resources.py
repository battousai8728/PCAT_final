from tastypie.resources import ModelResource
from pcatapp.models import Ranked, Unranked, Student
from pcatapp.views import getPos, posDifference

from tastypie.resources import ModelResource
from tastypie import fields
from django.core.serializers import json
from django.utils import simplejson
from tastypie.serializers import Serializer 
from tastypie.authorization import Authorization
from tastypie.authentication import Authentication, SessionAuthentication
from django.contrib.auth.models import User
from django.utils import timezone
from django.contrib.auth import authenticate, login, logout
from tastypie.http import HttpUnauthorized, HttpForbidden
from django.db import IntegrityError
from tastypie.exceptions import BadRequest
from django.conf.urls import url
from tastypie.utils import trailing_slash
from django.core.mail import EmailMessage
from tastypie.resources import ALL, ALL_WITH_RELATIONS
from django.core.exceptions import ObjectDoesNotExist
from django.forms import ValidationError
from decimal import *

from allauth.account.models import EmailAddress


class PrettyJSONSerializer(Serializer):
	json_indent = 4

	def to_json(self, data, options = None):
		options = options or {}
		data = self.to_simple(data, options)
		return simplejson.dumps(data, cls = json.DjangoJSONEncoder, sort_keys = True, ensure_ascii = False, indent = self.json_indent)



class UserResource(ModelResource):
	#student = fields.ToOneField(StudentResource, 'student', full = True)
	class Meta:
		queryset = User.objects.all()
		fields = ['username', 'email']
		serializer = PrettyJSONSerializer()
		authorization = Authorization()
		resource_name = 'user'


	def obj_create(self, bundle, request = None, **kwargs):
		password = bundle.data['password']
		email = bundle.data['email']

		try:
			username = email
			bundle.obj = User.objects.create_user(username, email, password)

			email_address = EmailAddress(user = bundle.obj, email = email, verified = True, primary = True)
			email_address.save()


			#print "Success"
			#student = Student(user = bundle.obj)
			#print student 
			#student.save()

			#try:
			#	student.gpa = bundle.data['gpa']
			#	student.save()
			#except ValueError:
			#	pass

			#try:
			#	student.zip_code = bundle.data['zip_code']
			#	student.save()
			#except ValueError:
			#	pass

			#bundle.obj = User(username = username, email = email, password = password)
			#bundle.obj.save()
		except IntegrityError:
			raise BadRequest('That username already exists')
		

		return bundle 

	def prepend_urls(self):
		return [
			url(r'^(?P<resource_name>%s)/login%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('login'), name = 'api_login'),
			url(r'^(?P<resource_name>%s)/logout%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('logout'), name = 'api_logout'),
			url(r'^(?P<resource_name>%s)/changepassword%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('changePassword'), name = 'changePassword'),
			url(r'^(?P<resource_name>%s)/changeemail%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('changeEmail'), name = 'changeEmail'),
			url(r'^(?P<resource_name>%s)/feedback%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('feedback'), name = 'feedback'),
			]

	def feedback(self, request, **kwargs):
		self.method_check(request, allowed = ['post'])
		data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))
		#print "\nSENDING FEEDBACK"
		try:
			name = data.get('name', '')
			#print "NAME received"
		except KeyError:
			name = 'NO NAME'
			#print "NAME = blank"

		try:
			subject = data.get('subject', '')
			#print "SUBJECT received"
		except KeyError:
			subject = 'NO SUBJECT'
			#print "SUBJECT = blank"

		email = data.get('email', '')
		#print email
		message = data.get('message', '')
		#print message
		message = "{} | {} | {}".format(name, email, message)
		#print message
		

		msg = EmailMessage(subject, message, to=['pharmschoolsearch@gmail.com'])
		#print message
		msg.send()

		return self.create_response(request, {'Success' : True})


	def changeEmail(self, request, **kwargs):
		self.method_check(request, allowed = ['post'])
		data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))

		if request.user and request.user.is_authenticated():
			user = request.user

			new_email = data.get('new_email', '')

			user.email = new_email
			user.save()


			return self.create_response(request, {'success' : True})
			
		else:
			return self.create_response(request, {'success' : False, 'reason' : 'incorrect'}, HttpUnauthorized)

	def changePassword(self, request, **kwargs):
		self.method_check(request, allowed = ['post'])
		data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))

		if request.user and request.user.is_authenticated():
			user = request.user

			opw = data.get('old_password', '')
			#print opw
			#print user.check_password(opw)
			if user.check_password(opw):
				npw = data.get('new_password', '')
				user.set_password(npw)
				user.save()

				return self.create_response(request, {'success' : True})
			else:
				return self.create_response(request, {'success' : False, 'reason' : 'old password incorrect'}, HttpUnauthorized)

		else:
			return self.create_response(request, {'success' : False, 'reason' : 'incorrect'}, HttpUnauthorized)



	def login(self, request, **kwargs):
		self.method_check(request, allowed = ['post'])

		data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))

		username = data.get('email', '')
		password = data.get('password', '')
		#print username
		#print password

		user = authenticate(username = username, password = password)
		#member = user.member
		#print user 

		if user is not None:
			if user.is_active:
				login(request, user)
				#user = user.id
				#print "Success"

				user_id = user.id
				#print user_id
				#return self.create_response(request, {'success' : True, 'user_id' : user_id})

				try: 
					student = user.student
					#print 'user has student'

					return self.create_response(request, {'success' : True, 'student' : student.id, 'user_id' : user_id})
				except ObjectDoesNotExist:
					#print 'user does not have student'
					return self.create_response(request, {'success' : True, 'student' : False, 'user_id' : user_id})
			

			else:
				return self.create_response(request, {'success' : False, 'reason' : 'disabled'}, HttpForbidden)
		else:
			return self.create_response(request, {'success' : False, 'reason' : 'incorrect'}, HttpUnauthorized)



	def logout(self, request, **kwargs):
		self.method_check(request, allowed = ['get'])
		if request.user and request.user.is_authenticated():
			#print request.user
			logout(request)
			return self.create_response(request, {'success' : True })
		else:
			return self.create_response(request, {'success' : False}, HttpUnauthorized)




class RankedResource(ModelResource):
	class Meta:
		queryset = Ranked.objects.all()
		resource_name = 'ranked'
		serializer = PrettyJSONSerializer()

	def prepend_urls(self):
		return [
			url(r'^(?P<resource_name>%s)/test%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('test'), name = 'test'),
			url(r'^(?P<resource_name>%s)/returndistance%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('returnDistances'), name = 'returnDistances'),
		]

	def test(self, request, **kwargs):
		#print "starting"
		data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))
		#print "got data"
		gpa = data.get('gpa', '')

		#print gpa

		return self.create_response(request, {'success' : True})


	def returnDistances(self, request, **kwargs):
		data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))

		city = data.get('city', '')
		state = data.get('state', '')

		position = getPos(city, state)
		lati = Decimal(position['lat'])
		loni = Decimal(position['lon'])
		#print "Latitude: {} Longitude: {}".format(lati, loni)

		ranked = Ranked.objects.all()
		unranked = Unranked.objects.all()
		ranked_results = {}
		unranked_results = {}
		
		#print "\nRANKED"
		for x in ranked:
			lat = Decimal(x.lat)
			lon = Decimal(x.lon)
			difference = posDifference(lati, loni, lat, lon)
			#print "{} miles away.".format(x.name, difference)
			ranked_results[x.name] = difference
		
		#print "\nUNRANKED"
		for y in unranked:
			lat = Decimal(y.lat)
			lon = Decimal(y.lon)
			difference = posDifference(lati, loni, lat, lon)
			#print "{} is {} miles away.".format(y.name, difference)
			unranked_results[y.name] = difference

		#print "\n UNRANKED RESULTS"
		#print unranked_results

		#print "\nRANKED RESULTS"
		#print ranked_results


		return self.create_response(request, {'success' : True, 'ranked_results' : ranked_results, 'unranked_results' : unranked_results})

class UnrankedResource(ModelResource):
	class Meta:
		queryset = Unranked.objects.all()
		resource_name = 'unranked'
		serializer = PrettyJSONSerializer()

class StudentResource(ModelResource):
	user = fields.ToOneField(UserResource, 'user', full = True)
	ranked_favorites = fields.ToManyField('pcat.api.resources2.RankedResource', 'ranked_favorites', full = True)
	unranked_favorites = fields.ToManyField('pcat.api.resources2.UnrankedResource', 'unranked_favorites', full = True)

	class Meta:
		queryset = Student.objects.all()
		resource_name = 'student'
		serializer = PrettyJSONSerializer()
		allowed_methods = ['get', 'post', 'put', 'delete', 'patch']
		authorization = Authorization()


	def prepend_urls(self):
		return [
			url(r'^(?P<resource_name>%s)/addfavr%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('addFavR'), name = 'addFavR'),
			url(r'^(?P<resource_name>%s)/addfavu%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('addFavU'), name = 'addFavU'),
			url(r'^(?P<resource_name>%s)/removefavr%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('removeFavR'), name = 'removeFavR'),
			url(r'^(?P<resource_name>%s)/removefavu%s$' % (self._meta.resource_name, trailing_slash()), self.wrap_view('removeFavU'), name = 'removeFavU'),
		]

	def obj_create(self, bundle, request = None, **kwargs):
		user = bundle.request.user
		#print user

		bundle.obj = Student(user = user)
		bundle.obj.save()
		#print "Success"

		try:
			zip_code = bundle.data['zip_code']
			bundle.obj.zip_code = zip_code
			#print "Got zip code"
			bundle.obj.save()
		except KeyError:
			pass
			#print "No zip code"

		try:
			gpa = bundle.data['gpa']
			bundle.obj.gpa = gpa
			#print "Got gpa"
			bundle.obj.save()
		except KeyError:
			pass
			#print "No gpa"

	def addFavR(self, request, **kwargs):
		if request.user.student:
			student = request.user.student
			data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))

			school_id = data.get('school_id', '')

			school = Ranked.objects.get(id = school_id)

			student.ranked_favorites.add(school)
			student.save()

			return self.create_response(request, {'success' : True})
		else:
			return self.create_response(request, {'success' : False, 'reason' : 'no student'}, HttpUnauthorized)


	def addFavU(self, request, **kwargs):
		if request.user.student:
			student = request.user.student
			data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))

			school_id = data.get('school_id', '')

			school = Unranked.objects.get(id = school_id)

			student.unranked_favorites.add(school)
			student.save()

			return self.create_response(request, {'success' : True})
		else:
			return self.create_response(request, {'success' : False, 'reason' : 'no student'}, HttpUnauthorized)


	def removeFavR(self, request, **kwargs):
		if request.user.student:
			student = request.user.student
			data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))

			school_id = data.get('school_id', '')

			school = Ranked.objects.get(id = school_id)

			if student.ranked_favorites.filter(name=school.name).exists():
				student.ranked_favorites.remove(school)

				return self.create_response(request, {'success' : True})
			else:
				return self.create_response(request, {'success' : False, 'reason' : 'school not in favorites'})
		else:
			return self.create_response(request, {'success' : False, 'reason' : 'no student'}, HttpUnauthorized)


	def removeFavU(self, request, **kwargs):
		if request.user.student:
			student = request.user.student
			data = self.deserialize(request, request.body, format = request.META.get('CONTENT_TYPE', 'application/json'))

			school_id = data.get('school_id', '')
			print school_id

			school = Unranked.objects.get(id = school_id)
			print school

			if student.unranked_favorites.filter(name=school.name).exists():
				student.unranked_favorites.remove(school)
				print "Success"

				return self.create_response(request, {'success' : True})
			else:
				print "Failure"
				return self.create_response(request, {'success' : False, 'reason' : 'school not in favorites'})
		else:
			return self.create_response(request, {'success' : False, 'reason' : 'no student'}, HttpUnauthorized)


