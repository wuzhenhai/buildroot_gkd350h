################################################################################
#
# mesa3d
#
################################################################################

MESA3D_ETNA_VIV_VERSION = pre_rebase_2014_09
MESA3D_ETNA_VIV_SITE = $(call github,laanwj,mesa,$(MESA3D_ETNA_VIV_VERSION))
MESA3D_ETNA_VIV_AUTORECONF = YES
MESA3D_ETNA_VIV_INSTALL_STAGING = YES

MESA3D_ETNA_VIV_CONF_ENV := \
	AWK="$(HOST_DIR)/usr/bin/gawk" \
	LEX="$(HOST_DIR)/usr/bin/flex" \
	YACC="$(HOST_DIR)/usr/bin/bison -y" \
	LIBTOOL_FOR_BUILD="$(HOST_DIR)/usr/bin/libtool" \
	PYTHON2="$(HOST_DIR)/usr/bin/python2" \
	ETNA_LIBS="$(STAGING_DIR)/usr/lib/libetnaviv.a"

MESA3D_ETNA_VIV_CONF_OPT = \
	--disable-glx \
	--enable-dri --with-dri-drivers= \
	--with-gallium-drivers=swrast,etna

ifeq ($(BR2_PREFER_STATIC_LIB),y)
MESA3D_ETNA_VIV_CONF_OPT += --enable-static --disable-shared
else
MESA3D_ETNA_VIV_CONF_OPT += --disable-static --enable-shared
endif

ifeq ($(BR2_PACKAGE_MESA3D_ETNA_VIV_DEBUG),y)
MESA3D_ETNA_VIV_CONF_OPT += --enable-debug
endif

ifeq ($(BR2_PACKAGE_MESA3D_ETNA_VIV_EGL),y)
MESA3D_ETNA_VIV_CONF_OPT += --enable-egl --with-egl-platforms=fbdev --enable-gallium-egl
else
MESA3D_ETNA_VIV_CONF_OPT += --disable-egl
endif

ifeq ($(BR2_PACKAGE_MESA3D_ETNA_VIV_GLES),y)
MESA3D_ETNA_VIV_CONF_OPT += --enable-gles1 --enable-gles2
else
MESA3D_ETNA_VIV_CONF_OPT += --disable-gles1 --disable-gles2
endif

ifeq ($(BR2_PACKAGE_MESA3D_ETNA_VIV_VG),y)
MESA3D_ETNA_VIV_CONF_OPT += --enable-openvg
else
MESA3D_ETNA_VIV_CONF_OPT += --disable-openvg
endif

MESA3D_ETNA_VIV_DEPENDENCIES = \
	etna_viv \
	expat \
	libdrm \
	host-gawk \
	host-flex \
	host-bison \
	host-pkgconf \
	host-python \
	host-libxml2

$(eval $(autotools-package))
