OPENRESTY_PREFIX=/usr/local/openresty-debug

PREFIX ?=          /usr/local
LUA_INCLUDE_DIR ?= $(PREFIX)/include
LUA_LIB_DIR ?=     $(PREFIX)/lib/lua/$(LUA_VERSION)
INSTALL ?= install

#export TEST_NGINX_USE_VALGRIND=1

.PHONY: all test install

all: ;

install: all
	$(INSTALL) -d $(DESTDIR)/$(LUA_LIB_DIR)/ngx/ssl/session/
	$(INSTALL) -d $(DESTDIR)/$(LUA_LIB_DIR)/ngx/ssl/session/ticket/
	$(INSTALL) lualib/ngx/ssl/session/*.lua $(DESTDIR)/$(LUA_LIB_DIR)/ngx/ssl/session/
	$(INSTALL) lualib/ngx/ssl/session/ticket/*.lua $(DESTDIR)/$(LUA_LIB_DIR)/ngx/ssl/session/ticket/

test: all
	PATH=$(OPENRESTY_PREFIX)/nginx/sbin:$$PATH prove -I../test-nginx/lib -r t/

