Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAA82D2903
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 11:36:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqxRM6gv3zDqZB
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 21:35:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12d;
 helo=mail-lf1-x12d.google.com; envelope-from=nl6720@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=jo1gvBoK; dkim-atps=neutral
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqxRF1dvWzDqGn
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 21:35:49 +1100 (AEDT)
Received: by mail-lf1-x12d.google.com with SMTP id l11so22363051lfg.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FFS6tPB9J9YiuLyrcW7rl7S57NbYuO0GpIU4D0lgfbI=;
 b=jo1gvBoKa6j8Vw9AFcQ9J+zGtrg6V8bO8zf5Kv/rzu9Ns5pMmr5/i5gMMdVquF1R+D
 vQagaHGVK9fjr2RObx9e1DKlVqefDQYNnLV7qyJmQUU4cSzA44/QqsLGJQ3rGtThqJ4C
 n2Q1LJXGjngBXMJI0zXuv8dkP8xkI+UdfAvBmrO1ZSiWCl9WGjPnqEELMVsYFtyeyyjZ
 ONoUUQhPFrst1kfgzEnHW3s0leFKPfVSorFDh4jvx4RC6+UI1UPTGmYEuMQRUlYhbl46
 BlIJSu0EFO+IwkNnFx7ZKBJ+73VxC50Qdp/CCYsgS2R315tWsO6nP1qtdX6ajRKg1D8L
 7/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FFS6tPB9J9YiuLyrcW7rl7S57NbYuO0GpIU4D0lgfbI=;
 b=inj4iOvRPW9AfcIenJUpJqq8Ybq67V5YP0fyNub2QVadAVIENCOT8im3ldhIcWr+iO
 ZRmBiRQLel3A83uqTM/99Ww16OOB12+frjv7xYB7FT1ZhyqR7BZIoPbIxvrkfBgCgrx4
 mWiorxCMmYYKr+JhwMGGL71+tQyqLWK7f9Ti4SGOtpE8AmFM2j8nW5unt2NPnb2nlOeR
 8wq1Qv+NC2Rp1f6MmCtOkKocEDowaZSQVq/MvDL9ovcpp1wA0Me6x28y7RUzHs5gs2u9
 uSGBMXvORYNuUMD7Ef3RNkXc7FH8v4ACArDrzKpbeGZVrL8rhxyOA6+LrO7Mk2blvvaQ
 ccGg==
X-Gm-Message-State: AOAM533+dI+t8KfZ5bomN/GA5aNepgKxE6aNRGcVuHke3wWBNXVAI17N
 D1Bb0H9vjZ0vnB9EKSDBBrM=
X-Google-Smtp-Source: ABdhPJydzb8h64tN3+7QNkvUMXyyeFlQEN7QNA1A7+A7tpybR6YEngIJDPJGvaC35RyCj2uPWF3p+g==
X-Received: by 2002:a19:4ad6:: with SMTP id x205mr9945981lfa.128.1607423744665; 
 Tue, 08 Dec 2020 02:35:44 -0800 (PST)
Received: from localhost (balticom-231-46.balticom.lv. [83.99.231.46])
 by smtp.gmail.com with ESMTPSA id u17sm1540823lfo.192.2020.12.08.02.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 02:35:43 -0800 (PST)
From: nl6720 <nl6720@gmail.com>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Cannot build erofs-utils 1.2: multiple definition of `sbi'
Date: Tue, 08 Dec 2020 12:35:42 +0200
Message-ID: <10789285.Na0ui7I3VY@walnut>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1765667.ppGbgfjBbT"
Content-Transfer-Encoding: 7Bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.

--nextPart1765667.ppGbgfjBbT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

I'm having trouble building erofs-utils 1.2. It fails in "Making all in mkfs":

/bin/sh ../libtool  --tag=CC   --mode=link gcc -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt  -Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -o mkfs.erofs mkfs_erofs-main.o -luuid  ../lib/liberofs.la  -R/usr/lib -llz4 
libtool: link: gcc -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z -Wl,relro -Wl,-z -Wl,now -o mkfs.erofs mkfs_erofs-main.o  -luuid ../lib/.libs/liberofs.a -llz4 -Wl,-rpath -Wl,/usr/lib
/usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-inode.o):(.bss+0x40000): multiple definition of `sbi'; ../lib/.libs/liberofs.a(liberofs_la-super.o):(.bss+0x0): first defined here

This is on Arch Linux with:
binutils 2.35.1-1
gcc 10.2.0-4
libtool 2.4.6+42+gb88cebd5-14

--nextPart1765667.ppGbgfjBbT
Content-Disposition: attachment; filename="build.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="utf-8"; name="build.log"

aclocal: warning: couldn't open directory 'm4': No such file or directory
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, 'config'.
libtoolize: linking file 'config/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIRS, 'm4'.
libtoolize: linking file 'm4/libtool.m4'
libtoolize: linking file 'm4/ltoptions.m4'
libtoolize: linking file 'm4/ltsugar.m4'
libtoolize: linking file 'm4/ltversion.m4'
libtoolize: linking file 'm4/lt~obsolete.m4'
configure.ac:17: installing 'config/ar-lib'
configure.ac:17: installing 'config/compile'
configure.ac:21: installing 'config/config.guess'
configure.ac:21: installing 'config/config.sub'
configure.ac:14: installing 'config/install-sh'
configure.ac:14: installing 'config/missing'
fuse/Makefile.am: installing 'config/depcomp'
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /usr/bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking whether make supports the include directive... yes (GNU style)
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking whether gcc understands -c and -o together... yes
checking dependency style of gcc... gcc3
checking for ar... ar
checking the archiver (ar) interface... ar
checking for gcc... (cached) gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking whether gcc understands -c and -o together... (cached) yes
checking dependency style of gcc... (cached) gcc3
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking how to print strings... printf
checking for a sed that does not truncate output... /usr/bin/sed
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for fgrep... /usr/bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking how to convert x86_64-pc-linux-gnu file names to x86_64-pc-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-pc-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for a working dd... /usr/bin/dd
checking how to truncate binary pipes... /usr/bin/dd bs=4096 count=1
checking for mt... no
checking if : is a manifest tool... no
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld -m elf_x86_64) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking pkg-config m4 macros... yes
checking dirent.h usability... yes
checking dirent.h presence... yes
checking for dirent.h... yes
checking fcntl.h usability... yes
checking fcntl.h presence... yes
checking for fcntl.h... yes
checking getopt.h usability... yes
checking getopt.h presence... yes
checking for getopt.h... yes
checking for inttypes.h... (cached) yes
checking linux/falloc.h usability... yes
checking linux/falloc.h presence... yes
checking for linux/falloc.h... yes
checking linux/fs.h usability... yes
checking linux/fs.h presence... yes
checking for linux/fs.h... yes
checking linux/types.h usability... yes
checking linux/types.h presence... yes
checking for linux/types.h... yes
checking linux/xattr.h usability... yes
checking linux/xattr.h presence... yes
checking for linux/xattr.h... yes
checking limits.h usability... yes
checking limits.h presence... yes
checking for limits.h... yes
checking stddef.h usability... yes
checking stddef.h presence... yes
checking for stddef.h... yes
checking for stdint.h... (cached) yes
checking for stdlib.h... (cached) yes
checking for string.h... (cached) yes
checking sys/ioctl.h usability... yes
checking sys/ioctl.h presence... yes
checking for sys/ioctl.h... yes
checking for sys/stat.h... (cached) yes
checking sys/sysmacros.h usability... yes
checking sys/sysmacros.h presence... yes
checking for sys/sysmacros.h... yes
checking sys/time.h usability... yes
checking sys/time.h presence... yes
checking for sys/time.h... yes
checking for unistd.h... (cached) yes
checking for inline... inline
checking for int64_t... yes
checking for size_t... yes
checking for ssize_t... yes
checking for struct stat.st_rdev... yes
checking for uint64_t... yes
checking whether llseek is declared... no
checking whether lseek64 is declared... yes
checking for fallocate... yes
checking for gettimeofday... yes
checking for memset... yes
checking for realpath... yes
checking for strdup... yes
checking for strerror... yes
checking for strrchr... yes
checking for strtoull... yes
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for libuuid... yes
checking libuuid usability... yes
checking lz4.h usability... yes
checking lz4.h presence... yes
checking for lz4.h... yes
checking for LZ4_compress_destSize in -llz4... yes
checking for LZ4_compress_HC_destSize in -llz4... yes
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating man/Makefile
config.status: creating lib/Makefile
config.status: creating mkfs/Makefile
config.status: creating fuse/Makefile
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands
make  all-recursive
make[1]: Entering directory '/build/erofs-utils/src/erofs-utils-1.2'
Making all in man
make[2]: Entering directory '/build/erofs-utils/src/erofs-utils-1.2/man'
make[2]: Nothing to be done for 'all'.
make[2]: Leaving directory '/build/erofs-utils/src/erofs-utils-1.2/man'
Making all in lib
make[2]: Entering directory '/build/erofs-utils/src/erofs-utils-1.2/lib'
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-config.lo -MD -MP -MF .deps/liberofs_la-config.Tpo -c -o liberofs_la-config.lo `test -f 'config.c' || echo './'`config.c
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-io.lo -MD -MP -MF .deps/liberofs_la-io.Tpo -c -o liberofs_la-io.lo `test -f 'io.c' || echo './'`io.c
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-cache.lo -MD -MP -MF .deps/liberofs_la-cache.Tpo -c -o liberofs_la-cache.lo `test -f 'cache.c' || echo './'`cache.c
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-super.lo -MD -MP -MF .deps/liberofs_la-super.Tpo -c -o liberofs_la-super.lo `test -f 'super.c' || echo './'`super.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-config.lo -MD -MP -MF .deps/liberofs_la-config.Tpo -c config.c  -fPIC -DPIC -o .libs/liberofs_la-config.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-super.lo -MD -MP -MF .deps/liberofs_la-super.Tpo -c super.c  -fPIC -DPIC -o .libs/liberofs_la-super.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-cache.lo -MD -MP -MF .deps/liberofs_la-cache.Tpo -c cache.c  -fPIC -DPIC -o .libs/liberofs_la-cache.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-io.lo -MD -MP -MF .deps/liberofs_la-io.Tpo -c io.c  -fPIC -DPIC -o .libs/liberofs_la-io.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-config.lo -MD -MP -MF .deps/liberofs_la-config.Tpo -c config.c -o liberofs_la-config.o >/dev/null 2>&1
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-super.lo -MD -MP -MF .deps/liberofs_la-super.Tpo -c super.c -o liberofs_la-super.o >/dev/null 2>&1
mv -f .deps/liberofs_la-config.Tpo .deps/liberofs_la-config.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-inode.lo -MD -MP -MF .deps/liberofs_la-inode.Tpo -c -o liberofs_la-inode.lo `test -f 'inode.c' || echo './'`inode.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-io.lo -MD -MP -MF .deps/liberofs_la-io.Tpo -c io.c -o liberofs_la-io.o >/dev/null 2>&1
mv -f .deps/liberofs_la-super.Tpo .deps/liberofs_la-super.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-xattr.lo -MD -MP -MF .deps/liberofs_la-xattr.Tpo -c -o liberofs_la-xattr.lo `test -f 'xattr.c' || echo './'`xattr.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-inode.lo -MD -MP -MF .deps/liberofs_la-inode.Tpo -c inode.c  -fPIC -DPIC -o .libs/liberofs_la-inode.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-cache.lo -MD -MP -MF .deps/liberofs_la-cache.Tpo -c cache.c -o liberofs_la-cache.o >/dev/null 2>&1
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-xattr.lo -MD -MP -MF .deps/liberofs_la-xattr.Tpo -c xattr.c  -fPIC -DPIC -o .libs/liberofs_la-xattr.o
mv -f .deps/liberofs_la-io.Tpo .deps/liberofs_la-io.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-exclude.lo -MD -MP -MF .deps/liberofs_la-exclude.Tpo -c -o liberofs_la-exclude.lo `test -f 'exclude.c' || echo './'`exclude.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-exclude.lo -MD -MP -MF .deps/liberofs_la-exclude.Tpo -c exclude.c  -fPIC -DPIC -o .libs/liberofs_la-exclude.o
mv -f .deps/liberofs_la-cache.Tpo .deps/liberofs_la-cache.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-namei.lo -MD -MP -MF .deps/liberofs_la-namei.Tpo -c -o liberofs_la-namei.lo `test -f 'namei.c' || echo './'`namei.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-namei.lo -MD -MP -MF .deps/liberofs_la-namei.Tpo -c namei.c  -fPIC -DPIC -o .libs/liberofs_la-namei.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-exclude.lo -MD -MP -MF .deps/liberofs_la-exclude.Tpo -c exclude.c -o liberofs_la-exclude.o >/dev/null 2>&1
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-xattr.lo -MD -MP -MF .deps/liberofs_la-xattr.Tpo -c xattr.c -o liberofs_la-xattr.o >/dev/null 2>&1
mv -f .deps/liberofs_la-exclude.Tpo .deps/liberofs_la-exclude.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-data.lo -MD -MP -MF .deps/liberofs_la-data.Tpo -c -o liberofs_la-data.lo `test -f 'data.c' || echo './'`data.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-namei.lo -MD -MP -MF .deps/liberofs_la-namei.Tpo -c namei.c -o liberofs_la-namei.o >/dev/null 2>&1
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-inode.lo -MD -MP -MF .deps/liberofs_la-inode.Tpo -c inode.c -o liberofs_la-inode.o >/dev/null 2>&1
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-data.lo -MD -MP -MF .deps/liberofs_la-data.Tpo -c data.c  -fPIC -DPIC -o .libs/liberofs_la-data.o
mv -f .deps/liberofs_la-namei.Tpo .deps/liberofs_la-namei.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compress.lo -MD -MP -MF .deps/liberofs_la-compress.Tpo -c -o liberofs_la-compress.lo `test -f 'compress.c' || echo './'`compress.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-data.lo -MD -MP -MF .deps/liberofs_la-data.Tpo -c data.c -o liberofs_la-data.o >/dev/null 2>&1
mv -f .deps/liberofs_la-xattr.Tpo .deps/liberofs_la-xattr.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor.lo -MD -MP -MF .deps/liberofs_la-compressor.Tpo -c -o liberofs_la-compressor.lo `test -f 'compressor.c' || echo './'`compressor.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compress.lo -MD -MP -MF .deps/liberofs_la-compress.Tpo -c compress.c  -fPIC -DPIC -o .libs/liberofs_la-compress.o
mv -f .deps/liberofs_la-data.Tpo .deps/liberofs_la-data.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-zmap.lo -MD -MP -MF .deps/liberofs_la-zmap.Tpo -c -o liberofs_la-zmap.lo `test -f 'zmap.c' || echo './'`zmap.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor.lo -MD -MP -MF .deps/liberofs_la-compressor.Tpo -c compressor.c  -fPIC -DPIC -o .libs/liberofs_la-compressor.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-zmap.lo -MD -MP -MF .deps/liberofs_la-zmap.Tpo -c zmap.c  -fPIC -DPIC -o .libs/liberofs_la-zmap.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor.lo -MD -MP -MF .deps/liberofs_la-compressor.Tpo -c compressor.c -o liberofs_la-compressor.o >/dev/null 2>&1
mv -f .deps/liberofs_la-inode.Tpo .deps/liberofs_la-inode.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-decompress.lo -MD -MP -MF .deps/liberofs_la-decompress.Tpo -c -o liberofs_la-decompress.lo `test -f 'decompress.c' || echo './'`decompress.c
mv -f .deps/liberofs_la-compressor.Tpo .deps/liberofs_la-compressor.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor_lz4.lo -MD -MP -MF .deps/liberofs_la-compressor_lz4.Tpo -c -o liberofs_la-compressor_lz4.lo `test -f 'compressor_lz4.c' || echo './'`compressor_lz4.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compress.lo -MD -MP -MF .deps/liberofs_la-compress.Tpo -c compress.c -o liberofs_la-compress.o >/dev/null 2>&1
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-decompress.lo -MD -MP -MF .deps/liberofs_la-decompress.Tpo -c decompress.c  -fPIC -DPIC -o .libs/liberofs_la-decompress.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-zmap.lo -MD -MP -MF .deps/liberofs_la-zmap.Tpo -c zmap.c -o liberofs_la-zmap.o >/dev/null 2>&1
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor_lz4.lo -MD -MP -MF .deps/liberofs_la-compressor_lz4.Tpo -c compressor_lz4.c  -fPIC -DPIC -o .libs/liberofs_la-compressor_lz4.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-decompress.lo -MD -MP -MF .deps/liberofs_la-decompress.Tpo -c decompress.c -o liberofs_la-decompress.o >/dev/null 2>&1
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor_lz4.lo -MD -MP -MF .deps/liberofs_la-compressor_lz4.Tpo -c compressor_lz4.c -o liberofs_la-compressor_lz4.o >/dev/null 2>&1
mv -f .deps/liberofs_la-compressor_lz4.Tpo .deps/liberofs_la-compressor_lz4.Plo
/bin/sh ../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor_lz4hc.lo -MD -MP -MF .deps/liberofs_la-compressor_lz4hc.Tpo -c -o liberofs_la-compressor_lz4hc.lo `test -f 'compressor_lz4hc.c' || echo './'`compressor_lz4hc.c
mv -f .deps/liberofs_la-decompress.Tpo .deps/liberofs_la-decompress.Plo
mv -f .deps/liberofs_la-compress.Tpo .deps/liberofs_la-compress.Plo
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor_lz4hc.lo -MD -MP -MF .deps/liberofs_la-compressor_lz4hc.Tpo -c compressor_lz4hc.c  -fPIC -DPIC -o .libs/liberofs_la-compressor_lz4hc.o
mv -f .deps/liberofs_la-zmap.Tpo .deps/liberofs_la-zmap.Plo
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT liberofs_la-compressor_lz4hc.lo -MD -MP -MF .deps/liberofs_la-compressor_lz4hc.Tpo -c compressor_lz4hc.c -o liberofs_la-compressor_lz4hc.o >/dev/null 2>&1
mv -f .deps/liberofs_la-compressor_lz4hc.Tpo .deps/liberofs_la-compressor_lz4hc.Plo
/bin/sh ../libtool  --tag=CC   --mode=link gcc -Wall -Werror -I../include  -march=x86-64 -mtune=generic -O2 -pipe -fno-plt  -Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -o liberofs.la  liberofs_la-config.lo liberofs_la-io.lo liberofs_la-cache.lo liberofs_la-super.lo liberofs_la-inode.lo liberofs_la-xattr.lo liberofs_la-exclude.lo liberofs_la-namei.lo liberofs_la-data.lo liberofs_la-compress.lo liberofs_la-compressor.lo liberofs_la-zmap.lo liberofs_la-decompress.lo liberofs_la-compressor_lz4.lo liberofs_la-compressor_lz4hc.lo  
libtool: link: ar cr .libs/liberofs.a .libs/liberofs_la-config.o .libs/liberofs_la-io.o .libs/liberofs_la-cache.o .libs/liberofs_la-super.o .libs/liberofs_la-inode.o .libs/liberofs_la-xattr.o .libs/liberofs_la-exclude.o .libs/liberofs_la-namei.o .libs/liberofs_la-data.o .libs/liberofs_la-compress.o .libs/liberofs_la-compressor.o .libs/liberofs_la-zmap.o .libs/liberofs_la-decompress.o .libs/liberofs_la-compressor_lz4.o .libs/liberofs_la-compressor_lz4hc.o 
libtool: link: ranlib .libs/liberofs.a
libtool: link: ( cd ".libs" && rm -f "liberofs.la" && ln -s "../liberofs.la" "liberofs.la" )
make[2]: Leaving directory '/build/erofs-utils/src/erofs-utils-1.2/lib'
Making all in mkfs
make[2]: Entering directory '/build/erofs-utils/src/erofs-utils-1.2/mkfs'
gcc -DHAVE_CONFIG_H -I. -I..  -I/usr/include/uuid   -D_FORTIFY_SOURCE=2 -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -MT mkfs_erofs-main.o -MD -MP -MF .deps/mkfs_erofs-main.Tpo -c -o mkfs_erofs-main.o `test -f 'main.c' || echo './'`main.c
mv -f .deps/mkfs_erofs-main.Tpo .deps/mkfs_erofs-main.Po
/bin/sh ../libtool  --tag=CC   --mode=link gcc -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt  -Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -o mkfs.erofs mkfs_erofs-main.o -luuid  ../lib/liberofs.la  -R/usr/lib -llz4 
libtool: link: gcc -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z -Wl,relro -Wl,-z -Wl,now -o mkfs.erofs mkfs_erofs-main.o  -luuid ../lib/.libs/liberofs.a -llz4 -Wl,-rpath -Wl,/usr/lib
/usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-inode.o):(.bss+0x40000): multiple definition of `sbi'; ../lib/.libs/liberofs.a(liberofs_la-super.o):(.bss+0x0): first defined here
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile:400: mkfs.erofs] Error 1
make[2]: Leaving directory '/build/erofs-utils/src/erofs-utils-1.2/mkfs'
make[1]: *** [Makefile:415: all-recursive] Error 1
make[1]: Leaving directory '/build/erofs-utils/src/erofs-utils-1.2'
make: *** [Makefile:347: all] Error 2

--nextPart1765667.ppGbgfjBbT--



