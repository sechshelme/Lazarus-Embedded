## -*- mode: rpm-spec; -*-
##
## $Id$
##
## avrdude.spec.  Generated from avrdude.spec.in by configure.
##

%define debug_package %{nil}

%define _with_docs 1
%{?_without_docs: %define _with_docs 0}

Summary: AVRDUDE is software for programming Atmel AVR Microcontrollers.
Name: avrdude
Version: 7.0
Release: 1
URL: http://savannah.nongnu.org/projects/avrdude
Source0: %{name}-%{version}.tar.gz
License: GPL
Group: Development/Tools
BuildRoot: %{_tmppath}/%{name}-%{version}-root

%description
AVRDUDE is software for programming Atmel AVR Microcontrollers.

%if %{_with_docs}
## The avrdude-docs subpackage
%package docs
Summary: Documentation for AVRDUDE.
Group: Documentation
%description docs
Documentation for avrdude in info, html, postscript and pdf formats.
%endif

%prep
%setup -q

%build

./configure --prefix=%{_prefix} --sysconfdir=/etc --mandir=%{_mandir} \
	--infodir=%{_infodir} \
%if %{_with_docs}
	--enable-doc=yes
%else
	--enable-doc=no
%endif

make

%install
rm -rf $RPM_BUILD_ROOT
make prefix=$RPM_BUILD_ROOT%{_prefix} \
	sysconfdir=$RPM_BUILD_ROOT/etc \
	mandir=$RPM_BUILD_ROOT%{_mandir} \
	infodir=$RPM_BUILD_ROOT%{_infodir} \
	install

rm -rf $RPM_BUILD_ROOT%{_datadir}/doc/%{name}-%{version}
rm -f $RPM_BUILD_ROOT%{_infodir}/dir

%clean
rm -rf $RPM_BUILD_ROOT

%if %{_with_docs}
%post docs
[ -f %{_infodir}/avrdude.info ] && \
	/sbin/install-info %{_infodir}/avrdude.info %{_infodir}/dir || :
[ -f %{_infodir}/avrdude.info.gz ] && \
	/sbin/install-info %{_infodir}/avrdude.info.gz %{_infodir}/dir || :

%preun docs
if [ $1 = 0 ]; then
	[ -f %{_infodir}/avrdude.info ] && \
		/sbin/install-info --delete %{_infodir}/avrdude.info %{_infodir}/dir || :
	[ -f %{_infodir}/avrdude.info.gz ] && \
		/sbin/install-info --delete %{_infodir}/avrdude.info.gz %{_infodir}/dir || :
fi
%endif

%files
%defattr(-,root,root)
%{_prefix}/bin/avrdude
%{_mandir}/man1/avrdude.1.gz
%attr(0644,root,root)   %config /etc/avrdude.conf

%if %{_with_docs}
%files docs
%doc %{_infodir}/*info*
%doc doc/avrdude-html/*.html
%doc doc/TODO
%doc doc/avrdude.ps
%doc doc/avrdude.pdf
%endif

%changelog
* Fri Sep 23 2005 Galen Seitz <galens@seitzassoc.com>
- Default to enable-doc=yes during configure.
- Move info file to docs package.
- Make building of docs package conditional.  Basic idea copied from avr-gcc.

* Wed Aug 27 2003 Theodore A. Roth <troth@openavr.org>
  [Thanks to Artur Lipowski <LAL@pro.onet.pl>]
- Do not build debug package.
- Remove files not packaged to quell RH9 rpmbuild complaints.

* Wed Mar 05 2003 Theodore A. Roth <troth@openavr.org>
- Add docs sub-package.
- Add %post and %preun scriptlets for handling info files.

* Wed Feb 26 2003 Theodore A. Roth <troth@openavr.org>
- Initial build.


