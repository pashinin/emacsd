from django.db import models
from django.utils.translation import gettext_lazy as _


class Test(models.Model):
    T_SITE = 0
    T_PROG = 1
    T_ADMIN = 2
    T_CONSULT = 3
    TYPES = (
        (T_SITE, 'Site'),
        (T_PROG, 'prog'),
        (T_ADMIN, 'admin'),
        (T_CONSULT, 'Consult'),
    )
    type = models.IntegerField(blank=True, null=True, choices=TYPES)
    title = models.CharField(max_length=150, blank=True, null=True)

    # def get_absolute_url(self):
    #     return reverse('books.author', args=[str(self.pk)])

    # def __str__(self):
    #     return self.title

    class Meta:
        verbose_name = _('Book')
        verbose_name_plural = _('Books')
