COMMENT =		fast implementation of the Cassowary constraint solver

MODPY_EGG_VERSION =	1.3.2
DISTNAME =		kiwisolver-${MODPY_EGG_VERSION}
PKGNAME =		py-${DISTNAME}
REVISION =		3

CATEGORIES =		devel

# BSD
PERMIT_PACKAGE =	Yes

# C++11
COMPILER =		base-clang ports-gcc ports-clang

WANTLIB =	${COMPILER_LIBCXX} ${MODPY_WANTLIB} m

MODULES =		lang/python

FLAVORS =	python3
FLAVOR  =	python3

MODPY_PI =		Yes
MODPY_PYBUILD =		setuptools

BUILD_DEPENDS =		devel/py-cppy${MODPY_FLAVOR}

.include <bsd.port.mk>
