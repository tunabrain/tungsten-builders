Summary: Physically based renderer for computer graphics research.
Name: tungsten
Version: {VERSION}
Release: 1%{?dist}
Source0: %{name}-%{version}.tar.gz
License: zlib/libpng
Group: Development/Libraries
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Vendor: Benedikt Bitterli <benedikt-bitterli@gmail.com>
Url: https://tungsten-renderer.com/
Requires: openexr, turbojpeg
BuildRequires: make gcc gcc-c++ cmake OpenEXR-devel libjpeg-turbo-devel zlib-devel

%description
A high performance physically based renderer for computer graphics research.

%prep
%setup

%build
%cmake -DCMAKE_BUILD_TYPE=Release .
make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%clean
rm -rf %{buildroot}

%files
/usr/bin/*
/usr/share/*
