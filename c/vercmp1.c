/* This file is part of Mailfromd.
   Copyright (C) 2005-2020 Sergey Poznyakoff

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>. */

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif

#include "libmf.h"
#include <stdlib.h>

int
mf_vercmp(const char *a, const char *b, int *pres)
{
	int res = 0;

	if (!pres)
		pres = &res;
	if (!a || !*a) {
		*pres = 0;
		return -1;
	}
	if (!b || !*b) {
		*pres = 1;
		return -1;
	}
	
	while (1) {
		char *p;
		unsigned long an, bn;

		if (!a) {
			if (b) {
				strtoul(b, &p, 10);
				if (*p && *p != '.') {
					*pres = 1;
					return -1;
				}
				*pres = -1;
			} else
				*pres = 0;
			break;
		}

		if (!b) {
			if (a) {
				strtoul(a, &p, 10);
				if (*p && *p != '.') {
					*pres = 0;
					return -1;
				}
				*pres = 1;
			} else
				*pres = 0;
			break;
		}
		
		an = strtoul(a, &p, 10);
		if (*p) {
			if (*p != '.') {
				*pres = 0;
				return -1;
			}
			a = p + 1;
		} else
			a = NULL;

		bn = strtoul(b, &p, 10);
		if (*p) {
			if (*p != '.') {
				*pres = 1;
				return -1;
			}
			b = p + 1;
		} else
			b = NULL;

		if (an < bn) {
			*pres = -1;
			break;
		}
		if (an > bn) {
			*pres = 1;
			break;
		}
		
	}
	return *pres != 0;
}


		
			
			

