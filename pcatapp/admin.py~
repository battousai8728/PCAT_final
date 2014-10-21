from django.contrib import admin
from pcatapp.models import Ranked, Unranked, Student

# Register your models here.

class StudentAdmin(admin.ModelAdmin):
	fields = ['gpa', 'zip_code', 'user']

class RankedAdmin(admin.ModelAdmin):
	fields = ['name', 'rank', 'city', 'state', 'zip_code', 'gpa_overall', 'gpa_expected', 'gpa_avg', 'min_pcat', 'resident_tuition', 'nonresident_tuition', 'regional_tuition', 'supplemental', 'three_year', 'dual_degree', 'full_accred', 'cand_accred', 'prec_accred', 'lat', 'lon', 'street', 'school_url', 'email', 'phone', 'regional_bool']
	list_display = ['id', 'name', 'rank', 'city', 'state', 'zip_code', 'gpa_overall', 'gpa_expected', 'gpa_avg', 'min_pcat', 'lat', 'lon', 'full_accred', 'cand_accred', 'prec_accred', 'street', 'school_url', 'email', 'regional_tuition']

class UnrankedAdmin(admin.ModelAdmin):
	fields = ['name', 'city', 'state', 'zip_code', 'gpa_overall', 'gpa_expected', 'gpa_avg', 'min_pcat', 'resident_tuition', 'nonresident_tuition', 'regional_tuition', 'supplemental', 'three_year', 'dual_degree', 'full_accred', 'cand_accred', 'prec_accred', 'lat', 'lon', 'street', 'school_url', 'email', 'phone', 'regional_bool']
	list_display = ['id', 'name', 'city', 'state', 'zip_code', 'gpa_overall', 'gpa_expected', 'gpa_avg', 'min_pcat', 'lat', 'lon', 'full_accred', 'cand_accred', 'prec_accred', 'street', 'school_url', 'email', 'regional_tuition']

admin.site.register(Ranked, RankedAdmin)
admin.site.register(Student, StudentAdmin)
admin.site.register(Unranked, UnrankedAdmin)