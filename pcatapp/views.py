from django.shortcuts import render_to_response, render
from pcatapp.models import Student, Ranked, Unranked
from pcatapp.forms import ParameterForm, RefineForm, StudentForm, ContactForm, NameForm
from django.template import RequestContext
from pcatapp.models import Ranked
from xlrd import open_workbook
import requests
import json
from math import sin, cos, radians, degrees, acos
from django.core.exceptions import ObjectDoesNotExist
from decimal import *
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect
from django.contrib.auth.models import User
from django.core.mail import EmailMessage


## Function to get latitude and longitude for all Ranked and Unranked Institutions
def getPosition():

	ranked = Ranked.objects.all() # Select all Ranked objects
	unranked = Unranked.objects.all() # Select all Unranked objects

	print "\n Ranked"

	for x in ranked:
		if x.zip_code == '00906': # This zip throws errors, needs to be recorded manually
			pass
		elif x.zip_code == '63005': # This zip throws errors, needs to be recorded manually
			pass
		else:
			city = x.city
			state = x.state
			url = 'http://api.zippopotam.us/us/' # URL to retrieve location information 
			zipp_call = "{}{}/{}".format(url, state, city)
			r = requests.get(zipp_call) # Make API request
			j = r.json() # Convert request to JSON
			print "City: {}".format(city)
			lat = float(j['places'][0]['latitude']) # Pull latitude
			lon = float(j['places'][0]['longitude']) # Pull longitude
			x.lat = lat
			x.lon = lon
			x.save()
			print "Latitude: {} Longitude: {}".format(lat, lon)

	print "\n Unranked" # Same as above but for Unranked institutions 

	for y in unranked:
		if y.zip_code == '20001': # This zip throws errors, needs to be recorded manually
			pass
		else:
			city = y.city
			state = y.state
			url = 'http://api.zippopotam.us/us/'
			zipp_call = "{}{}/{}".format(url, state, city)
			r = requests.get(zipp_call)
			j = r.json()
			print "City: {}".format(city)
			lat = float(j['places'][0]['latitude'])
			lon = float(j['places'][0]['longitude'])
			y.lat = lat
			y.lon = lon
			y.save()
			print "Latitude: {} Longitude: {}".format(lat, lon)

	return True

## Get latitue and longitude of user based on city and state
def getPos(city, state):
	url = 'http://api.zippopotam.us/us/' #URL to get location information
	zipp_call = "{}{}/{}".format(url, state, city)
	r = requests.get(zipp_call) # Make API call
	j = r.json() # Conver to JSON
	try:
		lat = float(j['places'][0]['latitude'])
		print "{} Latitude: {}".format(city, lat)

		lon = float(j['places'][0]['longitude'])
		print "{} Longitude: {}".format(city, lon)

		answer = {'lat' : lat, 'lon' : lon}
	except KeyError:
		answer = None

	print answer

	return answer

## Tester function to determine distance between two cities
def positionDifference(city1, state1, city2, state2):
    
	EARTH_RADIUS_IN_MILES = 3958.761

	position1 = getPos(city1, state1)
	print position1

	position2 = getPos(city2, state2)
	print position2
	print "Latitude: {} Longitude: {}".format(position1['lat'], position1['lon'])
	print "Latitude: {} Longitude: {}".format(position2['lat'], position2['lon'])

	lat1 = radians(position1['lat'])
	#print lat1
	lon1 = position1['lon']
	#print lon1

	lat2 = radians(position2['lat'])
	#print lat2
	lon2 = position2['lon']
	#print lon2

	delta_lon = radians(lon1 - lon2)
	cos_x = (sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(delta_lon))
	distance = acos(cos_x) * EARTH_RADIUS_IN_MILES

	return "The distance between these cities is {} miles".format(distance)


## Position difference function
def posDifference(lat1, lon1, lat2, lon2):
	EARTH_RADIUS_IN_MILES = 3958.761

	lat1 = radians(lat1)
	lat2 = radians(lat2)

	delta_lon = radians(lon1 - lon2)
	cos_x = (sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(delta_lon)) # Distance formula
	distance = acos(cos_x) * EARTH_RADIUS_IN_MILES # Conversion to miles

	return distance

def index(request):

	parameter_form = ParameterForm()
	name_form = NameForm()

	return render_to_response('pcatapp/index.html', {'form' : parameter_form, 'name_form' : name_form}, context_instance = RequestContext(request))


def sByInfo2(request):
	parameter_form = ParameterForm(request.GET)

	if parameter_form.is_valid():
		ranked = Ranked.objects.all()
		unranked = Unranked.objects.all()

		ranked_matches = []
		unranked_matches = []

		ranked_matches_p = []
		unranked_matches_p = []

		if (len(parameter_form.data['gpa']) != 0) & (len(parameter_form.data['pcat']) != 0) & (len(parameter_form.data['city']) != 0) & (len(parameter_form.data['state']) != 0):
			#print "GPA PCAT CITY STATE"
			gpa = parameter_form.data['gpa']
			gpa = float(gpa)
			pcat = parameter_form.data['pcat']
			pcat = int(pcat)
			city = parameter_form.data['city']
			state = parameter_form.data['state']

			position = getPos(city, state)

			if position == None:
				form = RefineForm()
				error = "The city you entered did not match our database"
				return render_to_response('pcatapp/results.html', {'form' : form, 'error' : error}, context_instance = RequestContext(request))

			else:
				lati = Decimal(position['lat'])
				loni = Decimal(position['lon'])


			#print "\n RANKED"
			for x in ranked:#Runs this loop for each Ranked school
				inc = 0
				#print x.name
				average_gpa = (x.gpa_expected + x.gpa_overall) / 2
				print average_gpa
				if gpa >= x.gpa_avg:
					#print "GPA good"
					inc += 1
					try:## Checking to see if the school is already in matches
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:## If school is not in matches it adds it
						ranked_matches.append(x)
						#print "{} added to matches".format(x.name)
				else:
					#print "GPA too low"
					pass

				if (pcat >= x.min_pcat) & (x.min_pcat != 0):
					inc += 1
					try:## Checking to see if the school is already in matches
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:## If school is not in matches it adds it
						ranked_matches.append(x)
						#print "{} added to matches".format(x.name)
				else:
					#print "PCAT too low"
					pass

				lat = Decimal(x.lat)
				lon = Decimal(x.lon)
				difference = posDifference(lati, loni, lat, lon)
				#print "Distance is {} miles".format(difference)

				if difference <= 150:
					inc += 1
					try:## Checking to see if the school is already in matches
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:## If school is not in matches it adds it
						ranked_matches.append(x)
						#print "School added"
				else:
					#print "School out of range"
					pass

				if inc > 1:
					#print "The priority for {} is {}".format(x.name, inc)
					ranked_matches.index(x)
					ranked_matches.remove(x)
					ranked_matches_p.append(x)
				else:
					pass


			## Same process for Unranked schools

			#print "\n UNRANKED"
			for y in unranked:
				inc = 0
				#print y.name
				average_gpa = (y.gpa_expected + y.gpa_overall) / 2
				if gpa >= y.gpa_avg:
					inc += 1
					try: 
						unranked_matches.index(y)
						#print "School already added"
					except ValueError:
						unranked_matches.append(y)
						#print "School added"
				else:
					#print "GPA too low"
					pass

				if (pcat >= y.min_pcat) & (y.min_pcat != 0):
					inc += 1
					try: 
						unranked_matches.index(y)
						#print "School already added"
					except ValueError:
						unranked_matches.append(y)
						#print "School added"
				else:
					#print "PCAT too low"
					pass

				lat = Decimal(y.lat)
				lon = Decimal(y.lon)
				difference = posDifference(lati, loni, lat, lon)
				#print "Distance is {} miles".format(difference)

				if difference <= 150:
					inc += 1
					try: 
						unranked_matches.index(y)
						#print "School already added"
					except ValueError:
						unranked_matches.append(y)
						#print "School added"
				else:
					#print "School out of range"
					pass

				if inc > 1:
					#print "The priority for {} is {}".format(y.name, inc)
					unranked_matches.index(y)
					unranked_matches.remove(y)
					unranked_matches_p.append(y)

				else:
					pass

			#print "{} Unranked Matches".format(len(unranked_matches))
			#print "{} Ranked Matches".format(len(ranked_matches))

		elif (len(parameter_form.data['gpa']) != 0) & (len(parameter_form.data['pcat']) != 0) & (len(parameter_form.data['state']) != 0):
			#print "GPA PCAT STATE"
			gpa = parameter_form.data['gpa']
			gpa = float(gpa)
			pcat = parameter_form.data['pcat']
			pcat = int(pcat)
			state = parameter_form.data['state']

			for x in ranked:
				inc = 0
				average_gpa = (x.gpa_overall + x.gpa_expected) / 2
				#print "{} >= {}".format(gpa, average_gpa)
				if gpa >= x.gpa_avg:
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "GPA not good enough for {}".format(x.name)
					pass

				if (pcat >= x.min_pcat) & (x.min_pcat != 0):
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "PCAT not good enough for {}".format(x.name)
					pass


				if state.lower() == x.state.lower():
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "{} is not in {}".format(x.name, state)
					pass


				if inc > 1:
					#print "The priority for {} is {}".format(x.name, inc)
					ranked_matches.index(x)
					ranked_matches.remove(x)
					ranked_matches_p.append(x)
				else:
					pass


			for y in unranked:
				inc = 0
				average_gpa = (y.gpa_overall + y.gpa_expected) / 2
				#print "{} >= {}".format(gpa, average_gpa)
				if gpa >= y.gpa_avg:
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "GPA not good enough for {}".format(y.name)
					pass

				if (pcat >= y.min_pcat) & (y.min_pcat != 0):
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "PCAT not good enough for {}".format(y.name)
					pass


				if state.lower() == y.state.lower():
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(x)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "{} is not in {}".format(y.name, state)
					pass

				if inc > 1:
					#print "The priority for {} is {}".format(y.name, inc)
					unranked_matches.index(y)
					unranked_matches.remove(y)
					unranked_matches_p.append(y)
				else:
					pass

			#print "{} Unranked Matches".format(len(unranked_matches))
			#print "{} Ranked Matches".format(len(ranked_matches))



		elif (len(parameter_form.data['gpa']) != 0) & (len(parameter_form.data['state']) != 0):
			#print "GPA PCAT STATE"
			gpa = parameter_form.data['gpa']
			gpa = float(gpa)

			state = parameter_form.data['state']

			for x in ranked:
				inc = 0
				average_gpa = (x.gpa_overall + x.gpa_expected) / 2
				#print "{} >= {}".format(gpa, average_gpa)
				if gpa >= x.gpa_avg:
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "GPA not good enough for {}".format(x.name)
					pass


				if state.lower() == x.state.lower():
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "{} is not in {}".format(x.name, state)
					pass


				if inc > 1:
					#print "The priority for {} is {}".format(x.name, inc)
					ranked_matches.index(x)
					ranked_matches.remove(x)
					ranked_matches_p.append(x)
				else:
					pass


			for y in unranked:
				inc = 0
				average_gpa = (y.gpa_overall + y.gpa_expected) / 2
				#print "{} >= {}".format(gpa, average_gpa)
				if gpa >= y.gpa_avg:
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "GPA not good enough for {}".format(y.name)
					pass



				if state.lower() == y.state.lower():
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(x)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "{} is not in {}".format(y.name, state)
					pass

				if inc > 1:
					#print "The priority for {} is {}".format(y.name, inc)
					unranked_matches.index(y)
					unranked_matches.remove(y)
					unranked_matches_p.append(y)
				else:
					pass






		elif (len(parameter_form.data['pcat']) != 0) & (len(parameter_form.data['state']) != 0):
			#print "GPA PCAT STATE"

			pcat = parameter_form.data['pcat']
			pcat = int(pcat)
			state = parameter_form.data['state']

			for x in ranked:
				inc = 0


				if (pcat >= x.min_pcat) & (x.min_pcat != 0):
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "PCAT not good enough for {}".format(x.name)
					pass


				if state.lower() == x.state.lower():
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "{} is not in {}".format(x.name, state)
					pass


				if inc > 1:
					#print "The priority for {} is {}".format(x.name, inc)
					ranked_matches.index(x)
					ranked_matches.remove(x)
					ranked_matches_p.append(x)
				else:
					pass


			for y in unranked:
				inc = 0


				if (pcat >= y.min_pcat) & (y.min_pcat != 0):
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "PCAT not good enough for {}".format(y.name)
					pass


				if state.lower() == y.state.lower():
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(x)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "{} is not in {}".format(y.name, state)
					pass

				if inc > 1:
					#print "The priority for {} is {}".format(y.name, inc)
					unranked_matches.index(y)
					unranked_matches.remove(y)
					unranked_matches_p.append(y)
				else:
					pass
############






		elif (len(parameter_form.data['gpa']) != 0) & (len(parameter_form.data['city']) != 0) & (len(parameter_form.data['state']) != 0):
			#print "GPA CITY STATE"

			gpa = parameter_form.data['gpa']
			gpa = float(gpa)
			city = parameter_form.data['city']
			state = parameter_form.data['state']

			position = getPos(city, state)

			if position == None:
				form = RefineForm()
				error = "The city you entered did not match our database"
				return render_to_response('pcatapp/results.html', {'form' : form, 'error' : error}, context_instance = RequestContext(request))

			else:
				lati = Decimal(position['lat'])
				loni = Decimal(position['lon'])

			for x in ranked:
				inc = 0
				average_gpa = (x.gpa_overall + x.gpa_expected) / 2
				#print "{} >= {}".format(gpa, average_gpa)
				if gpa >= x.gpa_avg:
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "GPA not good enough for {}".format(x.name)
					pass

				lat = Decimal(x.lat)
				lon = Decimal(x.lon)
				difference = posDifference(lati, loni, lat, lon)
				#print "Distance is {} miles".format(difference)

				if difference <= 150:
					inc += 1
					try:## Checking to see if the school is already in matches
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:## If school is not in matches it adds it
						ranked_matches.append(x)
						#print "School added"
				else:
					#print "School out of range"
					pass


				if inc > 1:
					#print "The priority for {} is {}".format(x.name, inc)
					ranked_matches.index(x)
					ranked_matches.remove(x)
					ranked_matches_p.append(x)
				else:
					pass


			for y in unranked:
				inc = 0
				average_gpa = (y.gpa_overall + y.gpa_expected) / 2
				#print "{} >= {}".format(gpa, average_gpa)
				if gpa >= y.gpa_avg:
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "GPA not good enough for {}".format(y.name)
					pass


				lat = Decimal(y.lat)
				lon = Decimal(y.lon)
				difference = posDifference(lati, loni, lat, lon)
				#print "Distance is {} miles".format(difference)

				if difference <= 150:
					inc += 1
					try: 
						unranked_matches.index(y)
						#print "School already added"
					except ValueError:
						unranked_matches.append(y)
						#print "School added"
				else:
					#print "School out of range"
					pass


				if inc > 1:
					#print "The priority for {} is {}".format(y.name, inc)
					unranked_matches.index(y)
					unranked_matches.remove(y)
					unranked_matches_p.append(y)
				else:
					pass








############



############






		elif (len(parameter_form.data['pcat']) != 0) & (len(parameter_form.data['city']) != 0) & (len(parameter_form.data['state']) != 0):
			#print "GPA CITY STATE"

			pcat = parameter_form.data['pcat']
			pcat = int(pcat)
			city = parameter_form.data['city']
			state = parameter_form.data['state']

			position = getPos(city, state)

			if position == None:
				form = RefineForm()
				error = "The city you entered did not match our database"
				return render_to_response('pcatapp/results.html', {'form' : form, 'error' : error}, context_instance = RequestContext(request))

			else:
				lati = Decimal(position['lat'])
				loni = Decimal(position['lon'])

			for x in ranked:
				inc = 0
				if (pcat >= x.min_pcat) & (x.min_pcat != 0):
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "PCAT not good enough for {}".format(x.name)
					pass

				lat = Decimal(x.lat)
				lon = Decimal(x.lon)
				difference = posDifference(lati, loni, lat, lon)
				#print "Distance is {} miles".format(difference)

				if difference <= 150:
					inc += 1
					try:## Checking to see if the school is already in matches
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:## If school is not in matches it adds it
						ranked_matches.append(x)
						#print "School added"
				else:
					#print "School out of range"
					pass


				if inc > 1:
					#print "The priority for {} is {}".format(x.name, inc)
					ranked_matches.index(x)
					ranked_matches.remove(x)
					ranked_matches_p.append(x)
				else:
					pass


			for y in unranked:
				inc = 0
				if (pcat >= y.min_pcat) & (y.min_pcat != 0):
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "PCAT not good enough for {}".format(y.name)
					pass


				lat = Decimal(y.lat)
				lon = Decimal(y.lon)
				difference = posDifference(lati, loni, lat, lon)
				#print "Distance is {} miles".format(difference)

				if difference <= 150:
					inc += 1
					try: 
						unranked_matches.index(y)
						#print "School already added"
					except ValueError:
						unranked_matches.append(y)
						#print "School added"
				else:
					#print "School out of range"
					pass


				if inc > 1:
					#print "The priority for {} is {}".format(y.name, inc)
					unranked_matches.index(y)
					unranked_matches.remove(y)
					unranked_matches_p.append(y)
				else:
					pass








############


		elif (len(parameter_form.data['gpa']) != 0) & (len(parameter_form.data['pcat']) != 0):
			#print "GPA PCAT"
			gpa = parameter_form.data['gpa']
			gpa = float(gpa)
			pcat = parameter_form.data['pcat']
			pcat = int(pcat)

			for x in ranked:
				inc = 0
				average_gpa = (x.gpa_overall + x.gpa_expected) / 2
				#print "{} >= {}".format(gpa, average_gpa)
				if gpa >= x.gpa_avg:
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "GPA not good enough for {}".format(x.name)
					pass

				if (pcat >= x.min_pcat) & (x.min_pcat != 0):
					inc += 1
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print "PCAT not good enough for {}".format(x.name)
					pass

				if inc > 1:
					#print "The priority for {} is {}".format(x.name, inc)
					ranked_matches.index(x)
					ranked_matches.remove(x)
					ranked_matches_p.append(x)
				else:
					pass


			for y in unranked:
				inc = 0
				average_gpa = (y.gpa_overall + y.gpa_expected) / 2
				#print "{} >= {}".format(gpa, average_gpa)
				if gpa >= y.gpa_avg:
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "GPA not good enough for {}".format(y.name)
					pass

				if (pcat >= y.min_pcat) & (y.min_pcat != 0):
					inc += 1
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print "PCAT not good enough for {}".format(y.name)
					pass

				if inc > 1:
					#print "The priority for {} is {}".format(y.name, inc)
					unranked_matches.index(y)
					unranked_matches.remove(y)
					unranked_matches_p.append(y)
				else:
					pass


		elif (len(parameter_form.data['state']) != 0) & (len(parameter_form.data['city']) != 0):
			#print "CITY STATE"
			state = parameter_form.cleaned_data['state']
			city = parameter_form.cleaned_data['city']

			position = getPos(city, state)

			if position == None:
				form = RefineForm()
				error = "The city you entered did not match our database"
				return render_to_response('pcatapp/results.html', {'form' : form, 'error' : error}, context_instance = RequestContext(request))

			else:
				lati = Decimal(position['lat'])
				loni = Decimal(position['lon'])



			for x in ranked:
				lat = Decimal(x.lat)
				lon = Decimal(x.lon)
				difference = posDifference(lati, loni, lat, lon)
				#print "Distance is {} miles".format(difference)

				if difference <= 150:
					try:## Checking to see if the school is already in matches
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:## If school is not in matches it adds it
						ranked_matches.append(x)
						#print "School added"
				else:
					#print "School out of range"
					pass


			for y in unranked:

				lat = Decimal(y.lat)
				lon = Decimal(y.lon)
				difference = posDifference(lati, loni, lat, lon)
				#print "Distance is {} miles".format(difference)

				if difference <= 150:
					try: 
						unranked_matches.index(y)
						#print "School already added"
					except ValueError:
						unranked_matches.append(y)
						#print "School added"
				else:
					#print "School out of range"
					pass


		elif (len(parameter_form.data['state']) != 0):
			#print "STATE"
			state = parameter_form.data['state']

			for x in ranked:
				#print "\nRANKED"
				if state.lower() == x.state.lower():
					try:
						ranked_matches.index(x)
						#print "{} already added".format(x.name)
					except ValueError:
						ranked_matches.append(x)
						#print "{} added to ranked matches".format(x.name)
				else:
					#print x.name
					#print "{} is not in {}".format(x.name, state)
					pass
			for y in unranked:
				#print "\nUNRANKED"
				if state.lower() == y.state.lower():
					try:
						unranked_matches.index(y)
						#print "{} already added".format(y.name)
					except ValueError:
						unranked_matches.append(y)
						#print "{} added to ranked matches".format(y.name)
				else:
					#print y.name
					#print "{} is not in {}".format(y.name, state)
					pass
		elif (len(parameter_form.data['gpa']) != 0):
			#print "GPA"

			gpa = parameter_form.cleaned_data['gpa']

			ranked = ranked.filter(gpa_avg__lte = gpa)
			unranked = unranked.filter(gpa_avg__lte = gpa)

			for x in ranked:
				ranked_matches.append(x)

			for y in unranked:
				unranked_matches.append(y)


		elif (len(parameter_form.data['pcat']) != 0):
			#print "PCAT"

			pcat = parameter_form.cleaned_data['pcat']
			ranked = ranked.filter(min_pcat__lte = pcat)
			unranked = unranked.filter(min_pcat__lte = pcat)

			for x in ranked:
				ranked_matches.append(x)

			for y in unranked:
				unranked_matches.append(y)


		if (len(parameter_form.data['pcat']) != 0) & (len(parameter_form.data['state']) == 0) & (len(parameter_form.data['city']) == 0) & (len(parameter_form.data['gpa']) == 0):
			print "they searched for pcat"

			ranked_matches2 = ranked_matches
			unranked_matches2 = unranked_matches
			ranked_matches_p2 = ranked_matches_p
			unranked_matches_p2 = unranked_matches_p
			i = 0

			for x in ranked_matches[:]:
				if x.min_pcat == 0:
					ranked_matches.remove(x)
				else:
					pass

			for w in ranked_matches_p[:]:
				if w.min_pcat == 0:
					ranked_matches_p.remove(w)
				else:
					pass
			for y in unranked_matches[:]:
				if y.min_pcat == 0:
					unranked_matches.remove(y)
				else:
					pass

			for z in unranked_matches_p[:]:
				if z.min_pcat == 0:
					unranked_matches_p.remove(z)
				else:
					pass


		form = RefineForm()
		name_form = NameForm()

		ranked_matches.sort(key=lambda x: (x.rank, x.name.lower()), reverse=False)
		ranked_matches_p.sort(key=lambda x: (x.rank, x.name.lower()), reverse=False)
		unranked_matches.sort(key=lambda x: x.name.lower(), reverse=False)
		unranked_matches_p.sort(key=lambda x: x.name.lower(), reverse=False)

		print len(ranked_matches)
		print len(ranked_matches_p)
		print len(unranked_matches)
		print len(unranked_matches_p)

		return render_to_response('pcatapp/results.html', {'ranked_matches' : ranked_matches, 'unranked_matches' : unranked_matches, 'ranked_matches_p' : ranked_matches_p, 'unranked_matches_p' : unranked_matches_p, 'form' : form, 'name_form' : name_form }, context_instance = RequestContext(request))
	else:
		return render_to_response('pcatapp/index.html', { 'form' : parameter_form })



def sByInfo(request):
	print "\n \n NEW CALL"

	parameter_form = ParameterForm(request.GET)

	if parameter_form.is_valid():


		ranked = Ranked.objects.all()
		unranked = Unranked.objects.all()

		ranked_matches = [] # List for ranked institution matches
		unranked_matches = [] # List for unranked institution matches

		if len(parameter_form.data['gpa']) != 0:
			gpa = parameter_form.data['gpa']

		else:
			pass

		if len(parameter_form.data['pcat']) != 0:
			pcat = parameter_form.data['pcat']
		else:
			pass

		if len(parameter_form.data['state']) != 0:
			state = parameter_form.data['state']
			if len(parameter_form.data['city']) != 0:
				city = parameter_form.data['city']
			else:
				pass
		else:
			pass


		if (parameter_form.data['gpa'] != 0) & (parameter_form.data['pcat'] != 0):
			gpa = parameter_form.data['gpa']
			gpa = float(gpa)
			print gpa
			pcat = parameter_form.data['pcat']
			pcat = int(pcat)
			print pcat

			if  len(parameter_form.data['city']) != 0:
				city = parameter_form.data['city']
				print city
				state = parameter_form.data['state']
				print state
				
				position = getPos(city, state)
				lati = Decimal(position['lat'])
				loni = Decimal(position['lon'])

				print "\n RANKED"
				for x in ranked:#Runs this loop for each Ranked school
					print x.name
					average_gpa = (x.gpa_expected + x.gpa_overall) / 2
					print average_gpa
					if gpa >= average_gpa:
						print "GPA good"
						try:## Checking to see if the school is already in matches
							ranked_matches.index(x)
							print "School already added"
						except ValueError:## If school is not in matches it adds it
							ranked_matches.append(x)
							print "School added"
					else:
						print "GPA too low"

					if pcat >= x.min_pcat:
						try:## Checking to see if the school is already in matches
							ranked_matches.index(x)
							print "School already added"
						except ValueError:## If school is not in matches it adds it
							ranked_matches.append(x)
							print "School added"
					else:
						print "PCAT too low"

					lat = Decimal(x.lat)
					lon = Decimal(x.lon)
					difference = posDifference(lati, loni, lat, lon)
					print "Distance is {} miles".format(difference)

					if difference <= 150:
						try:## Checking to see if the school is already in matches
							ranked_matches.index(x)
							print "School already added"
						except ValueError:## If school is not in matches it adds it
							ranked_matches.append(x)
							print "School added"
					else:
						print "School out of range"


				## Same process for Unranked schools

				print "\n UNRANKED"
				for y in unranked:
					print y.name
					average_gpa = (y.gpa_expected + y.gpa_overall) / 2
					if gpa >= average_gpa:
						try: 
							unranked_matches.index(y)
							print "School already added"
						except ValueError:
							unranked_matches.append(y)
							print "School added"
					else:
						print "GPA too low"

					if pcat >= y.min_pcat:
						try: 
							unranked_matches.index(y)
							print "School already added"
						except ValueError:
							unranked_matches.append(y)
							print "School added"
					else:
						print "PCAT too low"

					lat = Decimal(y.lat)
					lon = Decimal(y.lon)
					difference = posDifference(lati, loni, lat, lon)
					print "Distance is {} miles".format(difference)

					if difference <= 150:
						try: 
							unranked_matches.index(y)
							print "School already added"
						except ValueError:
							unranked_matches.append(y)
							print "School added"
					else:
						print "School out of range"



			else: ## City was not submitted
				print "City  missing"

				if len(parameter_form.data['state']) != 0:
					state = parameter_form.data['state']

					for x in ranked:
						average_gpa = (x.gpa_overall + x.gpa_expected) / 2
						if gpa >= average_gpa:
							try:
								ranked_matches.index(x)
								print "School already added"
							except ValueError:
								ranked_matches.append(x)
								print "School added"
						else:
							print "GPA too low"

						if pcat >= x.min_pcat:
							try:
								ranked_matches.index(x)
								print "School already added"
							except ValueError:
								ranked_matches.append(x)
								print "School added"
						else:
							print "PCAT too low"

						if state.lower() == x.state.lower():
							try:
								ranked_matches.index(x)
								print "School already added"
							except ValueError:
								ranked_matches.append(x)
								print "School added"
						else:
							print "School not in state"


					for y in unranked:
						average_gpa = (y.gpa_expected + y.gpa_overall) / 2
						if gpa >= average_gpa:
							try:
								unranked_matches.index(y)
								print "School already added"
							except ValueError:
								unranked_matches.append(y)
								print "School added"
						else:
							print "GPA too low"

						if pcat >= y.min_pcat:
							try:
								unranked_matches.index(y)
								print "School already added"
							except ValueError:
								unranked_matches.append(y)
								print "School added"
						else:
							print "PCAT too low"

						if state.lower() == y.state.lower():
							try:
								unranked_matches.index(y)
								print "School already added"
							except ValueError:
								unranked_matches.append(y)
								print "School added"
						else:
							print "School out of state"

				else:
					print "City and state missing"

					for x in ranked:
						average_gpa = (x.gpa_expected + x.gpa_overall) / 2

						if gpa >= average_gpa:
							try:
								ranked_matches.index(x)
								print "School already added"
							except ValueError:
								ranked_matches.append(x)
								print "School added"
						else:
							print "GPA too low"

						if pcat >= x.min_pcat:
							try:
								ranked_matches.index(x)
								print "School already added"
							except ValueError:
								ranked_matches.append(x)
								print "School added"
						else:
							print "PCAT too low"

					for y in unranked:
						average_gpa = (y.gpa_expected + y.gpa_overall) / 2
						if gpa >= average_gpa:
							try:
								unranked_matches.index(y)
								print "School already added"
							except ValueError:
								unranked_matches.append(y)
								print "School added"
						else:
							print "GPA too low"

						if pcat >= y.min_pcat:
							try:
								unranked_matches.index(y)
								print "School already added"
							except ValueError:
								unranked_matches.append(y)
								print "School added"
						else:
							print "PCAT too low"



		else:
			return render('You must enter both GPA & PCAT scores')
	else:
		return render_to_response('pcatapp/index.html', { 'form' : parameter_form })

	form = RefineForm()

	print "{} Unranked Matches".format(len(unranked_matches))
	print "{} Ranked Matches".format(len(ranked_matches))

	return render_to_response('pcatapp/results.html', {'ranked_matches' : ranked_matches, 'unranked_matches' : unranked_matches, 'form' : form }, context_instance = RequestContext(request))


	#return render_to_response('pcatapp/results.html', {'ranked_matches' : ranked_matches, 'unranked_matches' : unranked_matches}, context_instance = RequestContext(request))





def refineSearch3(request):
	#print "\n REFINDED SEARCH 3"

	ranked = Ranked.objects.all()
	unranked = Unranked.objects.all()

	ranked_matches = []
	unranked_matches = []

	error = None

	form = RefineForm(request.GET)

	if form.is_valid():
		#print "FORM VALID"

		#print form.cleaned_data['accred']

		if form.cleaned_data['full_accred'] == True:
			ranked = ranked.filter(full_accred = True)
			unranked = unranked.filter(full_accred = True)
		else:
			full_accred = False

		if form.cleaned_data['cand_accred'] == True:
			ranked = ranked.filter(cand_accred = True)
			unranked = unranked.filter(cand_accred = True)
		else:
			cand_accred = False

		if form.cleaned_data['prec_accred'] == True:
			ranked = ranked.filter(prec_accred = True)
			unranked = unranked.filter(prec_accred = True)
		else:
			prec_accred = False

		if form.cleaned_data['dual'] == True:
			ranked = ranked.filter(dual_degree = True)
			unranked = unranked.filter(dual_degree = True)
		else:
			dual = False

		if form.cleaned_data['three'] == True:
			ranked = ranked.filter(three_year = True)
			unranked = unranked.filter(three_year = True)
		else:
			three = False

		if form.cleaned_data['supp'] == True:
			ranked = ranked.filter(supplemental = True)
			unranked = unranked.filter(supplemental = True)
		else:
			supp = False



		if (len(form.data['min_pcat']) != 0) & (len(form.data['max_pcat']) != 0):
			#print "MIN AND MAX PCAT"
			min_pcat = form.cleaned_data['min_pcat']
			max_pcat = form.cleaned_data['max_pcat']

			ranked = ranked.filter(min_pcat__gte = int(min_pcat)).filter(min_pcat__lte = int(max_pcat))
			unranked = unranked.filter(min_pcat__gte = min_pcat).filter(min_pcat__lte = max_pcat)

		elif (len(form.data['min_pcat']) != 0):
			#print "MIN PCAT"
			min_pcat = form.cleaned_data['min_pcat']

			ranked = ranked.filter(min_pcat__gte = min_pcat)
			unranked = unranked.filter(min_pcat__gte = min_pcat)

		elif (len(form.data['max_pcat']) != 0):
			#print "MAX PCAT"
			max_pcat = form.cleaned_data['max_pcat']

			ranked = ranked.filter(min_pcat__lte = max_pcat)
			unranked = unranked.filter(min_pcat__lte = max_pcat)


		if (len(form.data['min_tuition']) != 0) & (len(form.data['max_tuition'])):
			#print "MIN AND MAX TUITION"
			max_tuition = form.cleaned_data['max_tuition']
			min_tuition = form.cleaned_data['min_tuition']
			ranked = ranked.filter(nonresident_tuition__gte = min_tuition).filter(nonresident_tuition__lte = max_tuition)
			unranked = unranked.filter(nonresident_tuition__gte = min_tuition).filter(nonresident_tuition__lte = max_tuition)

		elif (len(form.data['min_tuition']) != 0):
			#print "MIN TUITION"
			min_tuition = form.cleaned_data['min_tuition']
			ranked = ranked.filter(nonresident_tuition__gte = min_tuition)
			unranked = unranked.filter(nonresident_tuition__gte = min_tuition)

		elif (len(form.data['max_tuition']) != 0):
			#print "MAX TUITION"
			max_tuition = form.cleaned_data['max_tuition']
			ranked = ranked.filter(nonresident_tuition__lte = max_tuition)
			unranked = unranked.filter(nonresident_tuition__lte = max_tuition)



		if (len(form.data['min_gpa']) != 0) & (len(form.data['max_gpa']) != 0):
			#print "MAX AND MIN GPA"
			max_gpa = form.cleaned_data['max_gpa']
			min_gpa = form.cleaned_data['min_gpa']

			ranked = ranked.filter(gpa_avg__gte = min_gpa).filter(gpa_avg__lte = max_gpa)
			unranked = unranked.filter(gpa_avg__gte = min_gpa).filter(gpa_avg__lte = max_gpa)
		elif (len(form.data['max_gpa']) != 0):
			#print "MAX GPA"
			max_gpa = form.cleaned_data['max_gpa']

			ranked = ranked.filter(gpa_avg__lte = max_gpa)
			unranked = unranked.filter(gpa_avg__lte = max_gpa)

			#print len(ranked)
			#print len(unranked)
		elif (len(form.data['min_gpa']) != 0 ):
			#print "MIN GPA"
			min_gpa = form.cleaned_data['min_gpa']

			ranked = ranked.filter(gpa_avg__gte = min_gpa)
			unranked = unranked.filter(gpa_avg__gte = min_gpa)


		if (len(form.data['min_distance']) != 0) | (len(form.data['max_distance']) != 0) | (len(form.data['city']) != 0) | (len(form.data['state']) != 0):
			if (len(form.data['city']) != 0) & (len(form.data['state']) != 0):

				city = form.cleaned_data['city']
				state = form.cleaned_data['state']

				position = getPos(city, state)

				if position == None:
					form = RefineForm()
					error = "The city you entered did not match our database"
					return render_to_response('pcatapp/results.html', {'form' : form, 'error' : error}, context_instance = RequestContext(request))

				else:
					lati = Decimal(position['lat'])
					loni = Decimal(position['lon'])					



			else:
				pass


			for x in ranked:

				if (len(form.data['city']) != 0) & (len(form.data['state']) != 0):

					city = form.cleaned_data['city']
					state = form.cleaned_data['state']


					lat = Decimal(x.lat)
					lon = Decimal(x.lon)
					difference = posDifference(lati, loni, lat, lon) 

					if (len(form.data['min_distance']) != 0) & (len(form.data['max_distance']) != 0):
						#print "MIN AND MAX DISTANCE"
						min_distance = form.cleaned_data['min_distance']
						max_distance = form.cleaned_data['max_distance']
						if (difference >= min_distance) & (difference <= max_distance):
							try:
								ranked_matches.index(x)
								#print "{} already added".format(x.name)
							except ValueError:
								ranked_matches.append(x)
								#print "{} added".format(x.name)
						else:
							#print "{} is out of range".format(x.name)
							try:
								ranked_matches.index(x)
								ranked_matches.remove(x)
								#print "{} was removed".format(x.name)
							except ValueError:
								pass

					elif (len(form.data['min_distance']) != 0):
						#print "MIN DISTANCE"
						min_distance = form.cleaned_data['min_distance']
						if (difference >= min_distance):
							try:
								ranked_matches.index(x)
								#print "{} already added".format(x.name)
							except ValueError:
								ranked_matches.append(x)
								#print "{} added".format(x.name)
						else:
							#print "{} was inside the minimum distance".format(x.name)
							try:
								ranked_matches.index(x)
								ranked_matches.remove(x)
								#print "{} was removed".format(x.name)
							except ValueError:
								pass

					elif (len(form.data['max_distance']) != 0):
						#print "MAX DISTANCE"
						max_distance = form.cleaned_data['max_distance']
						if (difference <= max_distance):
							try:
								ranked_matches.index(x)
								#print "{} already added".format(x.name)
							except ValueError:
								ranked_matches.append(x)
								#print "{} added".format(x.name)
						else:
							#print "{} was outside the maximum distance".format(x.name)
							try:
								ranked_matches.index(x)
								ranked_matches.remove(x)
								#print "{} was removed".format(x.name)
							except ValueError:
								pass


				elif (len(form.data['state']) != 0):
					state = form.cleaned_data['state']

					if x.state.lower() == state.lower():
						try:
							ranked_matches.index(x)
							#print "{} already added".format(x.name)
						except ValueError:
							ranked_matches.append(x)
							#print "{} added".format(x.name)
					else:
						#print x.name
						print "{} not in {}".format(x.name, state)
						try:
							ranked_matches.index(x)
							ranked_matches.remove(x)
							#print "{} was removed".format(x.name)
						except ValueError:
							pass






			for y in unranked:

				if (len(form.data['city']) != 0) & (len(form.data['state']) != 0):

					city = form.cleaned_data['city']
					state = form.cleaned_data['state']


					lat = Decimal(y.lat)
					lon = Decimal(y.lon)
					difference = posDifference(lati, loni, lat, lon) 

					if (len(form.data['min_distance']) != 0) & (len(form.data['max_distance']) != 0):
						#print "MIN AND MAX DISTANCE"
						min_distance = form.cleaned_data['min_distance']
						max_distance = form.cleaned_data['max_distance']
						if (difference >= min_distance) & (difference <= max_distance):
							try:
								unranked_matches.index(y)
								#print "{} already added".format(y.name)
							except ValueError:
								unranked_matches.append(y)
								#print "{} added".format(y.name)
						else:
							#print "{} is out of range".format(y.name)
							try:
								unranked_matches.index(y)
								unranked_matches.remove(y)
								#print "{} was removed".format(y.name)
							except ValueError:
								pass


					elif (len(form.data['min_distance']) != 0):
						#print "MIN DISTANCE"
						min_distance = form.cleaned_data['min_distance']
						if (difference >= min_distance):
							try:
								unranked_matches.index(y)
								#print "{} already added".format(y.name)
							except ValueError:
								unranked_matches.append(y)
								#print "{} added".format(y.name)
						else:
							#print "{} was inside the minimum distance".format(y.name)
							try:
								unranked_matches.index(y)
								unranked_matches.remove(y)
								#print "{} was removed".format(y.name)
							except ValueError:
								pass

					elif (len(form.data['max_distance']) != 0):
						#print "MAX DISTANCE"
						max_distance = form.cleaned_data['max_distance']
						if (difference <= max_distance):
							try:
								unranked_matches.index(y)
								#print "{} already added".format(y.name)
							except ValueError:
								unranked_matches.append(y)
								#print "{} added".format(y.name)
						else:
							#print "{} was outside the maximum distance".format(y.name)
							try:
								unranked_matches.index(y)
								unranked_matches.remove(y)
								#print "{} was removed".format(y.name)
							except ValueError:
								pass


				elif (len(form.data['state']) != 0):
					state = form.cleaned_data['state']

					if y.state.lower() == state.lower():
						try:
							unranked_matches.index(y)
							#print "{} already added, is in {}".format(y.name, state)
						except ValueError:
							unranked_matches.append(y)
							#print "{} added".format(y.name)
					else:
						#print y.name
						#print "{} not in {}".format(y.name, state)
						try:
							unranked_matches.index(y)
							unranked_matches.remove(y)
							#print "{} was removed".format(y.name)
						except ValueError:
							pass


		else:
			#print "NO MIN OR MAX DISTANCE, CITY, OR STATE"

			for x in ranked:
				ranked_matches.append(x)

			for y in unranked:
				unranked_matches.append(y)





	name_form = NameForm()

	#print "{} Unranked Matches".format(len(unranked_matches))
	#print "{} Ranked Matches".format(len(ranked_matches))

	name_form = NameForm()

	if (len(form.data['min_pcat']) != 0) | (len(form.data['max_pcat']) != 0):
		for x in ranked_matches[:]:
			if x.min_pcat == 0:
				ranked_matches.remove(x)
			else:
				pass

		for y in unranked_matches[:]:
			if y.min_pcat == 0:
				unranked_matches.remove(y)
			else:
				pass

	if (len(ranked_matches) == 0) & (len(unranked_matches) == 0):
		error = "Sorry, no schools matched your results. Trying altering your search and try again."

	ranked_matches.sort(key=lambda x: x.rank, reverse=False)
	unranked_matches.sort(key=lambda x: x.name.lower(), reverse=False)


	return render_to_response('pcatapp/results.html', {'form' : form, 'ranked_matches' : ranked_matches, 'unranked_matches' : unranked_matches, 'error' : error, 'name_form' : name_form}, context_instance = RequestContext(request))



## Refining the search
def refineSearch2(request):
	print "\n REFINDED SEARCH"

	ranked = Ranked.objects.all()
	unranked = Unranked.objects.all()

	#ranked_matches = []
	#unranked_matches = []

	form = RefineForm(request.GET)

	if form.is_valid():
		print "FORM VALID"


		print form.cleaned_data['accred']

		if form.cleaned_data['accred'] == True:
			ranked.filter(accred_status = True)
			unranked.filter(accred_status = True)
		else:
			accred = False

		if form.cleaned_data['dual'] == True:
			ranked.filter(dual_degree = True)
			unranked.filter(dual_degree = True)
		else:
			dual = False

		if form.cleaned_data['three'] == True:
			ranked.filter(three_year = True)
			unranked.filter(three_year = True)
		else:
			three = False

		if (len(form.data['min_pcat']) != 0) & (len(form.data['min_gpa']) != 0) & (len(form.data['min_distance']) != 0) & (len(form.data['min_tuition']) != 0) & (len(form.data['city']) != 0) & (len(form.data['state']) != 0):

			if (len(form.data['max_pcat']) != 0) & (len(form.data['max_gpa']) != 0) & (len(form.data['max_distance']) != 0) & (len(form.data['max_tuition']) != 0):

				print "Min & Max PCAT, Min & Max GPA, Min & Max Distance, Min & Max Tuition City, State"
			else:
				error = "If you submit Min Value you must also submit a Max Value."
				print error


		elif (len(form.data['min_gpa']) != 0) & (len(form.data['min_distance']) != 0) & (len(form.data['city']) != 0) & (len(form.data['state']) != 0):

			if (len(form.data['max_gpa']) != 0) & (len(form.data['max_distance']) != 0):	

				print "Min & Max GPA, Min & Max Distance, City, State"
			else:
				error = "If you submit Min Value you must also submit a Max Value."
				print error


		elif (len(form.data['min_pcat']) != 0) & (len(form.data['min_distance']) != 0) & (len(form.data['city']) != 0) & (len(form.data['state']) != 0):

			if (len(form.data['max_pcat']) != 0) & (len(form.data['max_distance']) != 0): 

				print "Min & Max PCAT, Min & Max Distance, City, State"
			else:
				error = "If you submit Min Value you must also submit a Max Value."
				print error

		elif (len(form.data['min_pcat']) != 0) & (len(form.data['min_gpa']) != 0) & (len(form.data['state']) != 0):
			if (len(form.data['max_pcat']) != 0) & (len(form.data['max_gpa']) != 0):
				print "Min & Max PCAT, Min & Max GPA, State"
			else:
				error = "If you submit Min Value you must also submit a Max Value."
				print error

		elif (len(form.data['min_distance']) != 0) & (len(form.data['city']) != 0) & (len(form.data['state']) != 0):
			if (len(form.data['max_distance']) != 0):
				print "Min & Max Distance, City, State"
			else:
				error = "If you submit Min Value you must also submit a Max Value."
				print error		

	return render_to_response('pcatapp/results.html', {'form' : form, 'ranked_matches' : ranked, 'unranked_matches' : unranked, 'error' : error}, context_instance = RequestContext(request))


## Refining the search
def refineSearch(request):
	print "\n REFINDED SEARCH"

	ranked = Ranked.objects.all()
	unranked = Unranked.objects.all()

	ranked_matches = []
	unranked_matches = []

	form = RefineForm(request.GET)

	if form.is_valid():
		print "FORM VALID"
		min_gpa = form.cleaned_data['min_gpa']
		max_gpa = form.cleaned_data['max_gpa']

		min_pcat = form.cleaned_data['min_pcat']
		max_pcat = form.cleaned_data['max_pcat']

		print form.cleaned_data['accred']

		if form.cleaned_data['accred'] == True:
			ranked.filter(accred_status = True)
			unranked.filter(accred_status = True)
		else:
			accred = False

		if form.cleaned_data['dual'] == True:
			ranked.filter(dual_degree = True)
			unranked.filter(dual_degree = True)
		else:
			dual = False

		if form.cleaned_data['three'] == True:
			ranked.filter(three_year = True)
			unranked.filter(three_year = True)
		else:
			three = False



		### CHECK STATE AND CITY FIELDS ARE NOT BLANK
		if len(form.data['city']) != 0:
			if len(form.data['state']) != 0:

				state = form.cleaned_data['state']
				city = form.cleaned_data['city']
				print "GOT CITY AND STATE"

				position = getPos(city, state)
				lati = Decimal(position['lat'])
				loni = Decimal(position['lon'])

				## CHECK MIN AND MAX DISTANCE ARE NOT BLANK
				if len(form.data['min_distance']) != 0:
					if len(form.data['max_distance']) != 0:
						print "\nGOT CITY AND STATE"
						min_distance = form.cleaned_data['min_distance']
						max_distance = form.cleaned_data['max_distance']

						## RANKED
						for x in ranked:
							average_gpa = (x.gpa_expected + x.gpa_overall) / 2
							average_gpa = float(average_gpa)
							if average_gpa >= min_gpa:
								if average_gpa <= max_gpa:
									try:
										ranked_matches.index(x)
										print "School already added"
									except ValueError:
										ranked_matches.append(x)
										print "School added"
							else:
								"GPA not in range"

							if x.min_pcat >= min_pcat & x.min_pcat <= max_pcat:
								try:
									ranked_matches.index(x)
									print "School already added"
								except ValueError:
									ranked_matches.append(x)
									print "School added"
							else:
								print "PCAT not in range"

							lat = Decimal(x.lat)
							lon = Decimal(x.lon)
							difference = posDifference(lati, loni, lat, lon) 

							if difference >= min_distance: 
								if difference <= max_distance:
									try:
										ranked_matches.index(x)
										print "School already added"
									except ValueError:
										ranked_matches.append(x)
										print "School added"
							else:
								print "School out of range"


						## UNRANKED
						for y in unranked:
							average_gpa = (y.gpa_expected + y.gpa_overall) / 2
							average_gpa = float(average_gpa)
							if average_gpa >= min_gpa:
								if average_gpa <= max_gpa:
									try:
										unranked_matches.index(y)
										print "School already added"
									except ValueError:
										unranked_matches.append(y)
										print "School added"
							else:
								"GPA not in range"

							if y.min_pcat >= min_pcat & y.min_pcat <= max_pcat:
								try:
									unranked_matches.index(y)
									print "School already added"
								except ValueError:
									unranked_matches.append(y)
									print "School added"
							else:
								print "PCAT not in range"

							lat = Decimal(y.lat)
							lon = Decimal(y.lon)
							difference = posDifference(lati, loni, lat, lon) 

							if difference >= min_distance:
								if difference <= max_distance:
									try:
										unranked_matches.index(y)
										print "School already added"
									except ValueError:
										unranked_matches.append(y)
										print "School added"
							else:
								print "School out of range"
				else:
					error = "Min & Max Distance Must be Submitted When You Submit City"
					return render_to_response('pcatapp/results.html', {'form' : form, 'error' : error}, context_instance = RequestContext(request))


		## IF CITY OR STATE WERE BLANK, CHECK THAT STATE IS NOT BLANK
		elif len(form.data['state']) != 0:
			print "\nGOT ONLY STATE"
			
			state = form.data['state']
			## RANKED
			for x in ranked:
				average_gpa = (x.gpa_expected + x.gpa_overall) / 2
				average_gpa = float(average_gpa)
				if average_gpa >= min_gpa:
					if average_gpa <= max_gpa:
						try:
							ranked_matches.index(x)
							print "School already added"
						except ValueError:
							ranked_matches.append(x)
							print "School added"
				else:
					"GPA not in range"

				if x.min_pcat >= min_pcat & x.min_pcat <= max_pcat:
					try:
						ranked_matches.index(x)
						print "School already added"
					except ValueError:
						ranked_matches.append(x)
						print "School added"
				else:
					print "PCAT not in range"


				if state.lower() == x.state.lower():
					try:
						ranked_matches.index(x)
						print "School already added"
					except ValueError:
						ranked_matches.append(x)
						print "School added"
				else:
					print "School not in state"


			## UNRANKED
			for y in unranked:
				average_gpa = (y.gpa_expected + y.gpa_overall) / 2
				average_gpa = float(average_gpa)
				if average_gpa >= min_gpa:
					if average_gpa <= max_gpa:
						try:
							unranked_matches.index(y)
							print "School already added"
						except ValueError:
							unranked_matches.append(y)
							print "School added"
				else:
					"GPA not in range"

				if y.min_pcat >= min_pcat:
					if y.min_pcat <= max_pcat:
						try:
							unranked_matches.index(y)
							print "School already added"
						except ValueError:
							unranked_matches.append(y)
							print "School added"
				else:
					print "PCAT not in range"



				if state.lower() == y.state.lower():
					try:
						unranked_matches.index(y)
						print "School already added"
					except ValueError:
						unranked_matches.append(y)
						print "School added"
				else:
					print "School not in state"

		## NO CITY OR STATE
		else:

			print "\nNO CITY OR STATE"
			## RANKED
			for x in ranked:
				print x.name
				print x.gpa_overall
				print x.gpa_expected
				average_gpa = (x.gpa_expected + x.gpa_overall) / 2
				average_gpa = float(average_gpa)
				if average_gpa >= min_gpa:
					if average_gpa <= max_gpa:
						try:
							ranked_matches.index(x)
							print "School already added"
						except ValueError:
							ranked_matches.append(x)
							print "School added"
				else:
					"GPA not in range"

				if x.min_pcat >= min_pcat & x.min_pcat <= max_pcat:
					try:
						ranked_matches.index(x)
						print "School already added"
					except ValueError:
						ranked_matches.append(x)
						print "School added"
				else:
					print "PCAT not in range"


			## UNRANKED
			for y in unranked:
				average_gpa = (y.gpa_expected + y.gpa_overall) / 2
				average_gpa = float(average_gpa)
				if average_gpa >= min_gpa:
					if average_gpa <= max_gpa:
						try:
							unranked_matches.index(y)
							print "School already added"
						except ValueError:
							unranked_matches.append(y)
							print "School added"
				else:
					"GPA not in range"

				if y.min_pcat >= min_pcat & y.min_pcat <= max_pcat:
					try:
						unranked_matches.index(y)
						print "School already added"
					except ValueError:
						unranked_matches.append(y)
						print "School added"
				else:
					print "PCAT not in range"


		return render_to_response('pcatapp/results.html', {'form' : form, 'ranked_matches' : ranked_matches, 'unranked_matches' : unranked_matches}, context_instance = RequestContext(request))

	else:
		print "FORM INVALID"
		return render_to_response('pcatapp/results.html', {'form' : form}, context_instance = RequestContext(request))








def createStudent(zip_code, gpa, user_id):
	user = User.objects.get(id = user_id)

	student = Student(user = user, gpa = gpa, zip_code = zip_code)
	student.save()

	return True

def contactPage(request):

	form = ContactForm()

	return render_to_response('pcatapp/contact.html', {'form' : form}, context_instance = RequestContext(request))

def aboutPage(request):
	return render_to_response('pcatapp/about.html', context_instance = RequestContext(request))

def faq(request):
	return render_to_response('pcatapp/faq.html', context_instance = RequestContext(request))

def sByName(request):


	name_form = NameForm(request.GET)

	if name_form.is_valid():

		name = name_form.cleaned_data['name']

		ranked_matches = Ranked.objects.filter(name__icontains = name).order_by('rank')
		unranked_matches = Unranked.objects.filter(name__icontains = name).order_by('name')

		if (len(ranked_matches) == 0) & (len(unranked_matches) == 0):
			error = "No Schools Matched Your Search"
		else:
			error = False 


		form = RefineForm()


		return render_to_response('pcatapp/results.html', {'ranked_matches' : ranked_matches, 'unranked_matches' : unranked_matches, 'form' : form, 'error' : error, 'name_form' : name_form}, context_instance = RequestContext(request))


	else:

		return render_to_response('pcatapp:index', {'name_form' : name_form}, context_instance = RequestContext(request))


def rankedDetail(request, id):
	school = Ranked.objects.get(id = id)
	is_fav = False

	if request.user.is_authenticated():
		print "1"
		if request.user.student:
			print "2"
			student = request.user.student
			if student.ranked_favorites.filter(name=school.name).exists():
				print "is a favorite"
				is_fav = True
			else:
				print "nope"
		else:
			print "here"
	else:
		print "or here"		

	return render_to_response('pcatapp/ranked_detail.html', {'school' : school, 'is_fav' : is_fav}, context_instance = RequestContext(request))

def unrankedDetail(request, id):
	school = Unranked.objects.get(id = id)
	is_fav = False

	if request.user.is_authenticated():
		if request.user.student:
			student = request.user.student
			if student.unranked_favorites.filter(name=school.name).exists():
				is_fav = True

	return render_to_response('pcatapp/unranked_detail.html', {'school' : school, 'is_fav' : is_fav}, context_instance = RequestContext(request))

def createStudent(request):
	if request.user.is_authenticated():
		try:
			student = request.user.student
			return HttpResponseRedirect(reverse('pcatapp:showProfile'))
		except ObjectDoesNotExist:

			if request.method == 'POST':
				form = StudentForm(request.POST)
				if form.is_valid():

					user = request.user

					student = Student(user = user)
					student.save()
					print "Student Created"

					if (len(form.data['pcat']) != 0):
						pcat = form.cleaned_data['pcat']
						print pcat
						student.pcat = pcat

					if (len(form.data['gpa']) != 0):
						gpa = form.cleaned_data['gpa']
						print gpa
						student.gpa = gpa

					if (len(form.data['zip_code']) != 0):
						zip_code = form.cleaned_data['zip_code']
						print zip_code
						student.zip_code = zip_code

					student.save()

					return HttpResponseRedirect(reverse('pcatapp:showProfile'))
				else:
					return render_to_response('pcatapp/show_profile.html', {'form' : form}, context_instance = RequestContext(request))


			else:
				return HttpResponseRedirect(reverse('pcatapp:index'))

			return HttpResponseRedirect(reverse('pcatapp:showProfile'))
	else:
		return HttpResponseRedirect(reverse('pcatapp:index'))

def showProfile(request):
	if request.user.is_authenticated():
		try:
			student = request.user.student
		except ObjectDoesNotExist:
			student = False


		form = StudentForm()
		return render_to_response('pcatapp/show_profile.html', {'student' : student, 'form' : form}, context_instance = RequestContext(request))
	else:
		return HttpResponseRedirect(reverse('pcatapp:index'))

def editProfile(request):
	if request.user.is_authenticated():
		user = request.user
		if user.student:
			student = user.student
			if request.method == 'POST':
				
				form = StudentForm(request.POST)
				if form.is_valid():

					print "Got Student"

					if (len(form.data['pcat']) != 0):
						pcat = form.cleaned_data['pcat']
						print pcat
						student.pcat = pcat

					if (len(form.data['gpa']) != 0):
						gpa = form.cleaned_data['gpa']
						print gpa
						student.gpa = gpa

					if (len(form.data['zip_code']) != 0):
						zip_code = form.cleaned_data['zip_code']
						print zip_code
						student.zip_code = zip_code

					student.save()

					return HttpResponseRedirect(reverse('pcatapp:showProfile'))
				else:	
					return render_to_response('pcatapp/edit_profile.html', {'form' : form}, context_instance = RequestContext(request))
			else:
				form = StudentForm(instance = student)

				return render_to_response('pcatapp/edit_profile.html', {'form' : form}, context_instance = RequestContext(request))

		else:
			return HttpResponseRedirect(reverse('pcatapp:showProfile'))
	else:
		return HttpResponseRedirect(reverse('pcatapp:index'))


def feedback(request):
	form = ContactForm(request.POST)

	if form.is_valid():

		if (len(form.data['name']) != 0):
			name = form.cleaned_data['name']
		else:
			name = ""

		if (len(form.data['subject']) != 0):
			subject = form.cleaned_data['subject']
		else:
			subject = ""

		email = form.data['email']
		message = form.data['message']

		body = "{} | {} | {} | {}".format(email, message, name, subject)
		print body

		msg = EmailMessage(subject, body, to=['pharmschoolsearch@gmail.com'])
		msg.send()

		message = "Thank you for your feedback! A member of our team will reach out to you soon!"

		return render_to_response('pcatapp/results.html', {'error' : message}, context_instance = RequestContext(request))




def addFavoriteR(request, id):
	if request.user.is_authenticated():
		user = request.user
		if user.student:
			school = Ranked.objects.get(id = id)
			student = user.student
			student.ranked_favorites.add(school)
			student.save()

			return HttpResponseRedirect(reverse('pcatapp:showFavorites'))
		else:
			return HttpResponseRedirect(reverse('pcatapp:createStudent'))
	else:
		return HttpResponseRedirect(reverse('pcatapp:index'))

def addFavoriteU(request, id):
	if request.user.is_authenticated():
		user = request.user
		if user.student:
			school = Unranked.objects.get(id = id)
			student = user.student
			student.unranked_favorites.add(school)
			student.save()

			return HttpResponseRedirect(reverse('pcatapp:showFavorites'))
		else:
			return HttpResponseRedirect(reverse('pcatapp:createStudent'))
	else:
		return HttpResponseRedirect(reverse('pcatapp:index'))

def showFavorites(request):
	if request.user.is_authenticated():
		user = request.user
		if user.student:
			student = user.student
			ranked_favorites = student.ranked_favorites.all()
			unranked_favorites = student.unranked_favorites.all()

			return render_to_response('pcatapp/favorites.html', {'ranked_favorites' : ranked_favorites, 'unranked_favorites' : unranked_favorites}, context_instance = RequestContext(request))

		else:
			return HttpResponseRedirect(reverse('pcatapp:createStudent'))
	else:
		return HttpResponseRedirect(reverse('pcatapp:index'))

def removeFavoriteR(request, id):
	if request.user.is_authenticated():
		user = request.user
		if user.student:
			student = user.student
			favorites = student.ranked_favorites.all()
			school = Ranked.objects.get(id = id)

			if student.ranked_favorites.filter(name=school.name).exists():
				student.ranked_favorites.remove(school)
			else:
				pass

			return HttpResponseRedirect(reverse('pcatapp:showFavorites'))
		else:
			return HttpResponseRedirect(reverse('pcatapp:createStudent'))
	else:
		return HttpResponseRedirect(reverse('pcatapp:index'))

def removeFavoriteU(request, id):
	if request.user.is_authenticated():
		user = request.user
		if user.student:
			student = user.student
			favorites = student.unranked_favorites.all()
			school = Unranked.objects.get(id = id)

			if student.unranked_favorites.filter(name=school.name).exists():
				student.unranked_favorites.remove(school)
			else:
				pass

			return HttpResponseRedirect(reverse('pcatapp:showFavorites'))
		else:
			return HttpResponseRedirect(reverse('pcatapp:createStudent'))
	else:
		return HttpResponseRedirect(reverse('pcatapp:index'))




## HELPER FUNCTION TO SET GPA_AVG
def setGpaAvg():
	ranked = Ranked.objects.all()
	unranked = Unranked.objects.all()

	for x in ranked:
		gpa_avg = (x.gpa_expected + x.gpa_overall) / 2
		x.gpa_avg = gpa_avg
		x.save()

	for y in unranked:
		gpa_avg = (y.gpa_expected + y.gpa_overall) / 2
		y.gpa_avg = gpa_avg
		y.save()



## Script to load data from excel spreadsheet
## Broken
def dmE():
	#va = 33
	wb = open_workbook('pcatapp/UnrankedDB.xlsx')
	sheet = wb.sheet_by_index(0)

	for i in range(sheet.nrows):

		#rank = int(sheet.cell(i,0).value)
		#print '\n{}'.format(rank)

		name = str(sheet.cell(i,0).value)
		print name

		location = str(sheet.cell(i,1).value)
		city, state = location.split(', ')
		print city
		print state



		url = 'http://api.zippopotam.us/us/'
		zipp_call = "{}{}/{}".format(url, state, city)
		r = requests.get(zipp_call)
		j = r.json()

		zip_code = str(j['places'][0]['post code'])
		print zip_code

		try:
			overall_gpa = float(sheet.cell(i,2).value)
			print overall_gpa
		except ValueError:
			overall_gpa = None

		try:
			expected_gpa = float(sheet.cell(i,3).value)
			print expected_gpa
		except ValueError:
			expected_gpa = None

		try:
			pcat = int(sheet.cell(i,4).value)
			print pcat
		except ValueError:
			pass

		rtuition = int(sheet.cell(i,5).value)
		print rtuition

		ntuition = int(sheet.cell(i,6).value)
		print ntuition

		if str(sheet.cell(i,7).value) == 'Y':
			supp = True
		else:
			supp = False

		print supp

		accred = str(sheet.cell(i,8).value)
		print accred


		if str(sheet.cell(i,9).value) == 'Y':
			three = True
		else:
			three = False

		print three

		if str(sheet.cell(i,10).value) == 'Y':
			dual = True
		else:
			dual = False

		print dual

		obj = Unranked(name = name, city = city, state = state, zip_code = zip_code, gpa_overall = overall_gpa, gpa_expected = expected_gpa, min_pcat = pcat, resident_tuition = rtuition, nonresident_tuition = ntuition, supplemental = supp, three_year = three, dual_degree = dual, accred_status = accred)
		obj.save()

	rankeds = Ranked.objects.all()
	return render_to_response('pcatapp/test.html', {'ranked' : rankeds})




def setFromExcel():

	wb = open_workbook('pcatapp/DatabaseforPharmSchools.xlsx')
	sheet = wb.sheet_by_index(0)

	for i in range(sheet.nrows):

		name = str(sheet.cell(i,1).value)
		phone = str(sheet.cell(i,11).value)
		url = str(sheet.cell(i,14).value)
		email = str(sheet.cell(i,12).value)
		street = str(sheet.cell(i, 13).value)

		x = 0
		try:
			school = Ranked.objects.get(name = name)
			print "\n"
			print name
			print street
			school.street = street
			#school.phone = phone
			#school.school_url = url
			#school.email = email
			school.save()

		except ObjectDoesNotExist:
			x += 1


		try:
			uschool = Unranked.objects.get(name = name)
			print "\n"
			print name
			print street
			uschool.street = street
			#uschool.phone = phone
			#uschool.school_url = url
			#uschool.email = email
			uschool.save()

		except ObjectDoesNotExist:
			x += 1


		if x == 2:
			print "\nno match for {}".format(name)

	return True


def matchGPA():
	ranked = Ranked.objects.all()
	unranked = Unranked.objects.all()

	for x in ranked:
		if x.gpa_expected == 0:
			print x.name
			print x.gpa_expected
			x.gpa_expected = x.gpa_overall
			print x.gpa_expected
			x.save()

	for y in unranked:
		if y.gpa_expected == 0:
			print y.name
			print y.gpa_expected
			y.gpa_expected = y.gpa_overall
			print y.gpa_expected
			y.save()

	return True




