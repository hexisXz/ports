# probably also on (32-bit) arm
BROKEN-i386 =	pkg/disk/stat_other.go:40:91: cannot use st.Atim.Nsec (type int32) as type int64 in argument to strconv.FormatInt

COMMENT =	cli for minio

V =		2022-10-22T03-39-29Z
CID =		88796ea618092bb27368c00e2b387857945357fb
SHORTCID =	${CID:C/(............).*/\1/}

MODGO_MODNAME =	github.com/minio/mc
MODGO_VERSION =	v0.0.0-${V:C/[-TZ]//g}-${SHORTCID}

DISTNAME =	mc-${MODGO_VERSION}
PKGNAME =	minioc-0.${V:C/T.*//:S/-//g}

MODGO_LDFLAGS =	-s -w \
		-X github.com/minio/mc/cmd.Version=${V:C/T([0-9]+)-([0-9]+)-([0-9]+)/T\1:\2:\3/} \
		-X github.com/minio/mc/cmd.ReleaseTag=RELEASE.${V} \
		-X github.com/minio/mc/cmd.CommitID=${CID} \
		-X github.com/minio/mc/cmd.ShortCommitID=${SHORTCID}

post-install:
	mv ${PREFIX}/bin/{mc,minioc}

.include "modules.inc"

.include <bsd.port.mk>
