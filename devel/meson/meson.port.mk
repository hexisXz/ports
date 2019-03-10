# $OpenBSD: meson.port.mk,v 1.32 2019/03/10 12:38:57 ajacoutot Exp $

BUILD_DEPENDS +=	devel/meson>=0.49.2p1v0
SEPARATE_BUILD ?=	Yes

MODMESON_WANTCOLOR ?=	No
.if ${MODMESON_WANTCOLOR:L} == "no"
CONFIGURE_ENV += TERM="dumb"
.endif

.for solib sover in ${SHARED_LIBS}
CONFIGURE_ENV += LIB${solib}_VERSION=${sover}
.endfor

.if empty(CONFIGURE_STYLE)
CONFIGURE_STYLE=	meson
.endif

.if ! empty(INSTALL_STRIP)
CONFIGURE_ARGS +=	--strip
.endif

# from ${LOCALBASE}/bin/meson:
# Warn if the locale is not UTF-8. This can cause various unfixable issues
# such as os.stat not being able to decode filenames with unicode in them.
# There is no way to reset both the preferred encoding and the filesystem
# encoding, so we can just warn about it.
MAKE_ENV +=		LC_CTYPE="en_US.UTF-8"

# don't pick up llvm-ar(1)
CONFIGURE_ENV +=	AR="ar"

MODMESON_configure=	${SETENV} CC="${CC}" CFLAGS="${CFLAGS}" CXX="${CXX}" \
				CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" \
				LC_CTYPE="en_US.UTF-8" ${CONFIGURE_ENV} \
				${LOCALBASE}/bin/meson --buildtype=plain \
				--prefix "${PREFIX}" --mandir="${PREFIX}/man" \
				--sysconfdir="${SYSCONFDIR}" \
				--localstatedir="${LOCALSTATEDIR}" \
				--sharedstatedir="/var/db" \
				${CONFIGURE_ARGS} ${WRKSRC} ${WRKBUILD}

.if !target(do-build)
do-build:
	exec ${SETENV} ${MAKE_ENV} \
		${LOCALBASE}/bin/ninja -C ${WRKBUILD} -v -j ${MAKE_JOBS}
.endif

.if !target(do-install)
do-install:
	exec ${SETENV} ${MAKE_ENV} ${FAKE_SETUP} \
		${LOCALBASE}/bin/ninja -C ${WRKBUILD} ${FAKE_TARGET}
.endif

.if !target(do-test)
do-test:
	exec ${SETENV} ${ALL_TEST_ENV} \
		${LOCALBASE}/bin/ninja -C ${WRKBUILD} ${TEST_TARGET}
.endif
