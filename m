Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB412B2FA6
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:26:16 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP114hJJzDqSY
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:26:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378373;
	bh=zLMD8YGKxw6HP/qj9yCsMb8VRBz2ZzX6VL7Wyo4Q4Ak=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fov5uGcNuq7RImHxuSw9AZ798e/lXK8zuPSQYR5dZJaFzqFWVlASklaIDs6l1370g
	 3N/Mct5TY1w7xssfymCSx/v4KjpARLJndVUc48llw4FZIBET5Wl/70kwVdjeI4Mpe6
	 riYiR+XljLLXhVESd3HH3HpZHP08zki6GKpKND9eEd1JgNFe5O1pKkYBzJfeA7jzRK
	 bxKi2SKMUIIQHqJj8ng3ZsVvF6KKrPhwpPucjHuiAy66rE+Dt8WF/O/7mDfAFVBp2g
	 j2pLtxKS+fCjGYN3ZPaDYbUQq2h478K1mheM2Dh9cRxcy4ZrHuMhagoJfIVytVy+ST
	 R3LkplJpxGVjw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.147; helo=sonic310-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic310-21.consmr.mail.gq1.yahoo.com
 (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP0X3SVHzDqRt
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:25:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378341; bh=vbhqlEhiH+OwFI/LKjAqTR7qyxoRJOZH29520fIbjZ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=jbdIrsQYdI5bzzMAZ3MsS0mG4lVppJvvIBJ+RccCJAEn7A/p7b2V6lTKGAN6FtJCTaVoxcxjP/2QILsrg7IYk8zafV6gubLi5A42JQGbgqbnp5+jCMvdftpXC60QiOrA67FWEJnlmVyzy6zasuBYxsDH0m+xqWxNKr6f27E5V9Jn6xasxprN0JYx3/ytmAg+qqEU0G4f5QZUW2CkTiY9s6hCCBjuj/DZSL5xOrK7JP+Ech4eK6leITGlDo/y0ijbr+gDFvr8UlYRvpKKveFzR4nprD5+P5L8OhAl5WQggtH5CTWjzlBbU1wqLmbWhmAqoaQejZyiXEBZWVhqhTXWXg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378341; bh=qxam5fi7ML0spz1lAJg19VDiKeSVk3olWiL7aQ3aRAS=;
 h=From:To:Subject:Date:From:Subject;
 b=W1jmOWMUzbXakJa+980nFkbI3i9JJR8z8jsIM6LpvlaE72meVjLuOJ+pcSXBlK6C89qs76bWCRv4I3lagujtIeJX5R8sVlXoyo1N+jI5jsD2ZuKS40niD/EB/z/XSJN7KPsJ60Sa+/uk/p7tWYtht7cWTPk4hVkgTYtWDEHqYEJmUVzGm0EFUYCIyy3Sp8O24s3eBEY4Ej1wF/ChECIhdUE659IV4IVvP70ZUkrExzKhFet6A9p6ztoU8i47dL6YAol0BBUm98sw86qh5NbzqDPO6H3Q60cTBSA1Mnun5U58d2OSpDVFk4GRBT1HxB1R9gF+awsPaEKkbcF2Yl9/Kg==
X-YMail-OSG: 6dqLqa8VM1m7mssLJ45Sur47UuArA_eZ_DzOFxE86rmro8k08nOtgfnX906frTs
 4v63IdWgbtkpGw1aqjrPDmK_N9Y6sUz5D03diDzOPSaLlNrw7Au6khpnlX7Ot4ICCrZXD9pCCBYx
 D6M6Co5E.bQDmjl_M07MCF0uDRaHI2XFcxeNTjurRkXWkOjGBzGuh_1v6ORv9mod5PJOlYuI5EoA
 S1se5duNYCLwnYjNGVxKPviUpScjV4mAYD_CVRKX0apWlv7SONU9Ss29b1P_xeiYFhDKTS4rYfRZ
 GIQMA0iyAqknH8_AWQKFiFkTXdV2XEbYPhb5ts_H744FzXAYjh3hmIU0qCLDX3hCj1H1HDumb5n6
 06U6iUer938PMu1YyLdFcFUG.4U04jtVjVpJRSAqysu5JJ0OGGNXtpcrnCpAi0BbIpZi4CR0Z7A4
 HlKFo.iUjPRZI6oq95YsbuaJ1CBTY5Dd1M076SsFbK.n4SA4JLDI28dvb1acxHRNp0_zyGCNZ_28
 mIDHnQcNOmdsdqA2_JKiURe6lO1cV40SFpzIhMFeW73B8DJzWaWLKbk5HYkdw7hlSrYW9sUkIjxJ
 bKbYsJdxh7nY.q0BbD1238DzsyQXus2X.r67ndzknRtnXXH94VTCMOEeaWGrCe16PYtYhKqS4hit
 Iw3QzD8tgDr9cQwp.JsD6h3udehnKwjJvDI0_OsiedbnCEkC9mre1Dolb.sDlAwABcwhFKcfKhJX
 N8gFUQIRK8LMEhGWnH1po207__krMTVhEYAWdWa6sMGByj5VOliRHJywARwmvl2OgY0IxT68wIrT
 SJtlhMKzsayjoDnH2IAvLayoY1mpr6G8LfL9ASXhK.JG1YADngtSIl52QRNjkMArQ5WZ_EXmhiYq
 xtAwEPTq5rktlJCeHajaCTSMs21PfAkGHxxf_uXJy9dG_zEWBaFeO1Uw_GLJlpwr02cT_HfJqCm6
 WwbyndAVSj9N4SM.Zl3WBAk7JmARHCM8yRH8OFruqNxvu2q7S73_BNBaoz7F1Hr.jNTZg55_TJ.Q
 f2S3KzHPA3Eg8iwjrHnQSe_EDAvwWrTFvxQNmHITy0B66XDDiloZOcom1VcVM796kBT6Mq3JoWpK
 di__G1UMMcrrbV8HO2Eb_TeGjthu867NQis9.2_HhuCrv8EFLBsXr3mKtgeCsNg6N5bmPq0W5nxK
 QPu7_ob5OIMD7TSjNrtDbiAGIHKngBMkPiuKJtOvyU2k_QJtzZ0H1T.Uo.gu8Yk8oYfqkstTgljr
 QJU1vjccHAG.5scGiz9McR0W5MjxvQ4IiFpNq8SI1EM_ufyAdBskRw8fTy7IMwiRjJfBNmGnOJxL
 At4JeZr_8g1ps6wDZsWkqVRGJrO.TH_P2AmDRNLkwBo_dqqb8u7rzdyQkImWhCCxi2DIAwzLUOh6
 SI3gs7LR2F.Fsjm975neCPPKC9esnbQxL4eDHKkSCe4sc2Syn3YGn6CLIjEisyGH4CjqIn27Kkxz
 6WFW5pbSeLPFEfpPG5jvURl9.cFX6y3VdwG6VgUYB9x_cCzf9GSv0Gz.AUm69l5UwztGFinCJ6um
 Cc3.s9r8zJmvGhordRL3YUqaqPzMf0_zPSlLGe6IoJU_RobYUts3m3BUkfG7ig2XY0GmUs4PuBdL
 coYSkQnbHP1WpfpWhmegig2QtFiSTpXV_HXE4voCkrS.bDUyaPCKG58UD7tmvWRjS06G5GSnQGNl
 WfewzOqSTc0Lv91S.YPgvURnXsJsw9VK8MeeBO2xgRE4zJDgn8vt5F0ouE7Bbv5Au8obpJBM2ASD
 S4SBExx3IfrSGR9hE7ULD8OTRCuCp.Rt12c2FKEXf.QMzYNV4B6wpK8UhRUlJYSas8W5lp6yC_T.
 SVyL_Uh9716g5ymxbTOcYZCaNiBzH7IZK4Euhqqru5zjiKTwZyXjewL1lc4y96o2A_HLXtYatOmg
 EZeKEbIIpwyVzvHqOR3klcygqiHK7Dl1Mw5NEwUbN9xLI4MFpCUXP0hFabakNwAOybIJPbxcuCMx
 VfeTAJHWbICV0PtDDl6bp4aMQSN9cTgXnTot12u.8Huf0LytV.rRyBmP1.SluRRtNHVeAoxiwAeb
 XUlfRDoIGlZEigBn0kh0HZG73YObwMVINTRfl34wQjQBbOajOAjVc9dFgmMLSTumRvw1b2.CK0Jo
 a_LWjP2h4Ge0oxUsRMQZ1nmGdPDUcCHli2e_fhkzfj.w5irkeeY55Xd3WTqaz.yIyLHyTbv5FVvJ
 tXoAkFoXX6nEf9Vpjmq7LCXLdurkaHFEo_h0dtwpPHNgR_dBMHnYfN3OPyW6gwW6XmrmAnRP4xhz
 BO9HirIuPiyeS1augZisndWlhKYbaY3ppE9aC1blz..r9eTajsr5QdKa1v_xa5GVtoFbb0qzBfEW
 iZLoKIKOgGlo0_hykDIUGiM9ySrUspaVit07m8kvv_LCW6S6Wr5B60dBtGDENwCVU4YNKrGvoF.5
 hKok1xFIrKOEdY1r3pz.bvRjKd3T8sJ_2OUvulgkmigT1zz3P1TRgv96FafQBpz.9yh3jF9Yzxq5
 wtN3fqe18gr8Va6u22b_nvv7Ub5dZr59RQi1XGdR_5RMDOxkPCUA2_WPjcGKHyiH.L9gl9oOBORH
 ZbZdsD4xuV5Z10i7NQ9KVZcRoobncDIf.oXk.Efc4h5NGiBMmyRGyRRTN9DuWEjpp6hbBHWuPK77
 qdAYcXlRPqmBZBsH0fZ_dTesaFfIPmGLzdh2XODwkZw6cx7df5FdylMLaoYn8Q6q0xj1rawnmLPp
 fvewArOKJbpHhifjCl0TpWmzOO01.Zsj_f__m6yYzh2zntQPDksC5FD9Wx0Byx3ij0_5Q4sBMBWj
 qJgkmgpMkFAirc5nHiY.Gs0YQ7if4Kl0LurS8Jaw2fv3MYFXAuki4BBELqcIIf.vcvQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:25:41 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:25:36 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 01/12] erofs-utils: introduce fuse implementation
Date: Sun, 15 Nov 2020 02:25:06 +0800
Message-Id: <20201114182517.9738-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201114182517.9738-1-hsiangkao@aol.com>
References: <20201114182517.9738-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <blucerlee@gmail.com>

Let's add erofsfuse approach, and benefits are:

 - images can be supported on various platforms;
 - new unpack tool can be developed based on this;
 - new on-disk features can be iterated, verified effectively.

This commit only aims at reading a regular file.
Other file (e.g. compressed file) support is out of scope for now.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 Makefile.am              |   2 +-
 README                   |  28 ++++-
 configure.ac             |   3 +-
 fuse/Makefile.am         |  14 +++
 fuse/main.c              | 203 +++++++++++++++++++++++++++++++++++
 fuse/namei.c             | 222 +++++++++++++++++++++++++++++++++++++++
 fuse/namei.h             |  17 +++
 fuse/read.c              |  72 +++++++++++++
 fuse/read.h              |  16 +++
 fuse/readir.c            | 121 +++++++++++++++++++++
 fuse/readir.h            |  17 +++
 include/erofs/defs.h     |   3 +
 include/erofs/internal.h |  83 +++++++++++++++
 include/erofs/io.h       |   1 +
 lib/Makefile.am          |   4 +-
 lib/data.c               | 117 +++++++++++++++++++++
 lib/io.c                 |  16 +++
 17 files changed, 934 insertions(+), 5 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/main.c
 create mode 100644 fuse/namei.c
 create mode 100644 fuse/namei.h
 create mode 100644 fuse/read.c
 create mode 100644 fuse/read.h
 create mode 100644 fuse/readir.c
 create mode 100644 fuse/readir.h
 create mode 100644 lib/data.c

diff --git a/Makefile.am b/Makefile.am
index 1d20577068c5..24f4a7b3d5ad 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,4 +3,4 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS = man lib mkfs
+SUBDIRS = man lib mkfs fuse
diff --git a/README b/README
index 5addd6b80e04..870858c48b7d 100644
--- a/README
+++ b/README
@@ -2,7 +2,8 @@ erofs-utils
 ===========
 
 erofs-utils includes user-space tools for erofs filesystem images.
-Currently only mkfs.erofs is available.
+One is mkfs.erofs to create a image, the other is erofsfuse which
+is used to mount a image on a directory
 
 mkfs.erofs
 ----------
@@ -95,6 +96,31 @@ It may still be useful since new erofs-utils has not been widely used in
 commercial products. However, if that happens, please report bug to us
 as well.
 
+erofs-utils: erofsfuse
+----------------------
+erofsfuse mount a erofs filesystem image created by mkfs.erofs to a directory, and then
+It can be listed, read files and so on.
+
+Dependencies
+~~~~~~~~~~~~
+FUSE library version: 2.9.7
+fusermount version: 2.9.7
+using FUSE kernel interface version 7.19
+
+How to installed fuse
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+sudo apt-get update
+sudo apt-get install -y fuse libfuse-dev
+
+How to build erofsfuse
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+	$ ./autogen.sh
+	$ ./configure
+	$ make
+
+erofsfuse binary will be generated under fuse folder.
+
 Contribution
 ------------
 
diff --git a/configure.ac b/configure.ac
index bff1e293789a..e6d2e5fd3702 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,6 +247,7 @@ AC_SUBST([liblz4_LIBS])
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
 		 lib/Makefile
-		 mkfs/Makefile])
+		 mkfs/Makefile
+		 fuse/Makefile])
 AC_OUTPUT
 
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
new file mode 100644
index 000000000000..0c1a24763f59
--- /dev/null
+++ b/fuse/Makefile.am
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS     = erofsfuse
+erofsfuse_SOURCES = main.c namei.c read.c readir.c
+erofsfuse_CFLAGS = -Wall -Werror \
+                   -I$(top_srcdir)/include \
+                   $(shell pkg-config fuse --cflags) \
+                   -DFUSE_USE_VERSION=26 \
+                   -std=gnu99
+LDFLAGS += $(shell pkg-config fuse --libs)
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl
+
diff --git a/fuse/main.c b/fuse/main.c
new file mode 100644
index 000000000000..5121e8325f32
--- /dev/null
+++ b/fuse/main.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/main.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <execinfo.h>
+#include <signal.h>
+#include <stddef.h>
+
+#include "erofs/print.h"
+#include "namei.h"
+#include "read.h"
+#include "readir.h"
+#include "erofs/io.h"
+
+/* XXX: after liberofs is linked in, it should be removed */
+struct erofs_configure cfg;
+
+enum {
+	EROFS_OPT_HELP,
+	EROFS_OPT_VER,
+};
+
+struct options {
+	const char *disk;
+	const char *mount;
+	const char *logfile;
+	unsigned int debug_lvl;
+};
+static struct options fusecfg;
+
+#define OPTION(t, p)    { t, offsetof(struct options, p), 1 }
+
+static const struct fuse_opt option_spec[] = {
+	OPTION("--log=%s", logfile),
+	OPTION("--dbg=%u", debug_lvl),
+	FUSE_OPT_KEY("-h", EROFS_OPT_HELP),
+	FUSE_OPT_KEY("-v", EROFS_OPT_VER),
+	FUSE_OPT_END
+};
+
+static void usage(void)
+{
+	fprintf(stderr, "\terofsfuse [options] <image> <mountpoint>\n");
+	fprintf(stderr, "\t    --log=<file>    output log file\n");
+	fprintf(stderr, "\t    --dbg=<level>   log debug level 0 ~ 7\n");
+	fprintf(stderr, "\t    -h   show help\n");
+	fprintf(stderr, "\t    -v   show version\n");
+	exit(1);
+}
+
+static void dump_cfg(void)
+{
+	fprintf(stderr, "\tdisk :%s\n", fusecfg.disk);
+	fprintf(stderr, "\tmount:%s\n", fusecfg.mount);
+	fprintf(stderr, "\tdebug_lvl:%u\n", fusecfg.debug_lvl);
+	fprintf(stderr, "\tlogfile  :%s\n", fusecfg.logfile);
+}
+
+static int optional_opt_func(void *data, const char *arg, int key,
+			     struct fuse_args *outargs)
+{
+	UNUSED(data);
+	UNUSED(outargs);
+
+	switch (key) {
+	case FUSE_OPT_KEY_OPT:
+		return 1;
+
+	case FUSE_OPT_KEY_NONOPT:
+		if (!fusecfg.disk) {
+			fusecfg.disk = strdup(arg);
+			return 0;
+		} else if (!fusecfg.mount)
+			fusecfg.mount = strdup(arg);
+
+		return 1;
+	case EROFS_OPT_HELP:
+		usage();
+		break;
+
+	case EROFS_OPT_VER:
+		fprintf(stderr, "EROFS FUSE VERSION v 1.0.0\n");
+		exit(0);
+	}
+
+	return 1;
+}
+
+static void signal_handle_sigsegv(int signal)
+{
+	void *array[10];
+	size_t nptrs;
+	char **strings;
+	size_t i;
+
+	UNUSED(signal);
+	erofs_dbg("========================================");
+	erofs_dbg("Segmentation Fault.  Starting backtrace:");
+	nptrs = backtrace(array, 10);
+	strings = backtrace_symbols(array, nptrs);
+	if (strings) {
+		for (i = 0; i < nptrs; i++)
+			erofs_dbg("%s", strings[i]);
+		free(strings);
+	}
+	erofs_dbg("========================================");
+
+	abort();
+}
+
+void *erofs_init(struct fuse_conn_info *info)
+{
+	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
+	return NULL;
+}
+
+int erofs_open(const char *path, struct fuse_file_info *fi)
+{
+	erofs_info("open path=%s", path);
+
+	if ((fi->flags & O_ACCMODE) != O_RDONLY)
+		return -EACCES;
+
+	return 0;
+}
+
+int erofs_getattr(const char *path, struct stat *stbuf)
+{
+	struct erofs_vnode v;
+	int ret;
+
+	erofs_dbg("getattr(%s)", path);
+	memset(&v, 0, sizeof(v));
+	ret = erofs_iget_by_path(path, &v);
+	if (ret)
+		return -ENOENT;
+
+	stbuf->st_mode  = v.i_mode;
+	stbuf->st_nlink = v.i_nlink;
+	stbuf->st_size  = v.i_size;
+	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
+	stbuf->st_uid = v.i_uid;
+	stbuf->st_gid = v.i_gid;
+	stbuf->st_atime = sbi.build_time;
+	stbuf->st_mtime = sbi.build_time;
+	stbuf->st_ctime = sbi.build_time;
+	return 0;
+}
+
+static struct fuse_operations erofs_ops = {
+	.getattr = erofs_getattr,
+	.readdir = erofs_readdir,
+	.open = erofs_open,
+	.read = erofs_read,
+	.init = erofs_init,
+};
+
+int main(int argc, char *argv[])
+{
+	int ret = EXIT_FAILURE;
+	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+
+	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
+		fprintf(stderr, "Failed to initialize signals\n");
+		return EXIT_FAILURE;
+	}
+
+	/* Parse options */
+	if (fuse_opt_parse(&args, &fusecfg, option_spec, optional_opt_func) < 0)
+		return 1;
+
+	dump_cfg();
+
+	cfg.c_dbg_lvl = fusecfg.debug_lvl;
+
+	if (dev_open_ro(fusecfg.disk) < 0) {
+		fprintf(stderr, "Failed to open disk:%s\n", fusecfg.disk);
+		goto exit;
+	}
+
+	if (erofs_read_superblock()) {
+		fprintf(stderr, "Failed to read erofs super block\n");
+		goto exit_dev;
+	}
+
+	erofs_info("fuse start");
+
+	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
+
+	erofs_info("fuse done ret=%d", ret);
+
+exit_dev:
+	dev_close();
+exit:
+	fuse_opt_free_args(&args);
+	return ret;
+}
+
diff --git a/fuse/namei.c b/fuse/namei.c
new file mode 100644
index 000000000000..cd747ad1be56
--- /dev/null
+++ b/fuse/namei.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/namei.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "namei.h"
+#include <linux/kdev_t.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/stat.h>
+
+#include "erofs/defs.h"
+#include "erofs/print.h"
+#include "erofs/io.h"
+
+#define IS_PATH_SEPARATOR(__c)      ((__c) == '/')
+#define MINORBITS	20
+#define MINORMASK	((1U << MINORBITS) - 1)
+#define DT_UNKNOWN	0
+
+static const char *skip_trailing_backslash(const char *path)
+{
+	while (IS_PATH_SEPARATOR(*path))
+		path++;
+	return path;
+}
+
+static uint8_t get_path_token_len(const char *path)
+{
+	uint8_t len = 0;
+
+	while (path[len] != '/' && path[len])
+		len++;
+	return len;
+}
+
+int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
+{
+	int ret;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_inode_compact *v1;
+	const erofs_off_t addr = iloc(nid);
+	const size_t size = EROFS_BLKSIZ - erofs_blkoff(addr);
+
+	ret = dev_read(buf, addr, size);
+	if (ret < 0)
+		return -EIO;
+
+	v1 = (struct erofs_inode_compact *)buf;
+	vi->datalayout = __inode_data_mapping(le16_to_cpu(v1->i_format));
+	vi->inode_isize = sizeof(struct erofs_inode_compact);
+	vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
+	vi->i_size = le32_to_cpu(v1->i_size);
+	vi->i_mode = le16_to_cpu(v1->i_mode);
+	vi->i_uid = le16_to_cpu(v1->i_uid);
+	vi->i_gid = le16_to_cpu(v1->i_gid);
+	vi->i_nlink = le16_to_cpu(v1->i_nlink);
+	vi->nid = nid;
+
+	switch (vi->i_mode & S_IFMT) {
+	case S_IFBLK:
+	case S_IFCHR:
+		/* fixme: add special devices support
+		 * vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
+		 */
+		break;
+	case S_IFIFO:
+	case S_IFSOCK:
+		/*fixme: vi->i_rdev = 0; */
+		break;
+	case S_IFREG:
+	case S_IFLNK:
+	case S_IFDIR:
+		vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		break;
+	default:
+		return -EIO;
+	}
+
+	return 0;
+}
+
+
+struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
+					void *dentry_blk,
+					const char *name, unsigned int len,
+					unsigned int nameoff,
+					unsigned int maxsize)
+{
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + nameoff;
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		/* a corrupted entry is found */
+		if (nameoff + de_namelen > maxsize ||
+		    de_namelen > EROFS_NAME_LEN) {
+			erofs_err("bogus dirent @ nid %llu", pnid | 0ULL);
+			DBG_BUGON(1);
+			return ERR_PTR(-EFSCORRUPTED);
+		}
+
+		if (len == de_namelen && !memcmp(de_name, name, de_namelen))
+			return de;
+		++de;
+	}
+	return NULL;
+}
+
+int erofs_namei(erofs_nid_t *nid,
+		const char *name, unsigned int len)
+{
+	int ret;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_vnode v;
+
+	ret = erofs_iget_by_nid(*nid, &v);
+	if (ret)
+		return ret;
+
+	{
+		unsigned int offset = 0;
+
+		struct erofs_inode tmp = {
+			.u = {
+				.i_blkaddr = v.raw_blkaddr,
+			},
+			.nid = v.nid,
+			.i_size = v.i_size,
+			.datalayout = v.datalayout,
+			.inode_isize = v.inode_isize,
+			.xattr_isize = v.xattr_isize,
+		};
+
+		while (offset < v.i_size) {
+			int maxsize = min(v.i_size - offset, EROFS_BLKSIZ);
+			struct erofs_dirent *de = (void *)buf;
+			unsigned int nameoff;
+
+			ret = erofs_read_raw_data(&tmp, buf, offset, maxsize);
+			if (ret)
+				return ret;
+
+			nameoff = le16_to_cpu(de->nameoff);
+
+			if (nameoff < sizeof(struct erofs_dirent) ||
+			    nameoff >= PAGE_SIZE) {
+				erofs_err("invalid de[0].nameoff %u @ nid %llu",
+					  nameoff, *nid | 0ULL);
+				return -EFSCORRUPTED;
+			}
+
+			de = find_target_dirent(*nid, buf, name, len,
+						nameoff, maxsize);
+			if (IS_ERR(de))
+				return PTR_ERR(de);
+
+			if (de) {
+				*nid = le64_to_cpu(de->nid);
+				return 0;
+			}
+			offset += maxsize;
+		}
+	}
+	return -ENOENT;
+}
+
+extern struct dcache_entry root_entry;
+int walk_path(const char *_path, erofs_nid_t *out_nid)
+{
+	int ret;
+	erofs_nid_t nid = sbi.root_nid;
+	const char *path = _path;
+
+	for (;;) {
+		uint8_t path_len;
+
+		path = skip_trailing_backslash(path);
+		path_len = get_path_token_len(path);
+		if (path_len == 0)
+			break;
+
+		ret = erofs_namei(&nid, path, path_len);
+		if (ret)
+			return ret;
+
+		path += path_len;
+	}
+
+	erofs_dbg("find path = %s nid=%llu", _path, nid | 0ULL);
+
+	*out_nid = nid;
+	return 0;
+
+}
+
+int erofs_iget_by_path(const char *path, struct erofs_vnode *v)
+{
+	int ret;
+	erofs_nid_t nid;
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	return erofs_iget_by_nid(nid, v);
+}
+
diff --git a/fuse/namei.h b/fuse/namei.h
new file mode 100644
index 000000000000..2625ec58d434
--- /dev/null
+++ b/fuse/namei.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/inode.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __INODE_H
+#define __INODE_H
+
+#include "erofs/internal.h"
+#include "erofs_fs.h"
+
+int erofs_iget_by_path(const char *path, struct erofs_vnode *v);
+int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *v);
+int walk_path(const char *path, erofs_nid_t *out_nid);
+
+#endif
diff --git a/fuse/read.c b/fuse/read.c
new file mode 100644
index 000000000000..446e0837cbc4
--- /dev/null
+++ b/fuse/read.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/read.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "read.h"
+#include <errno.h>
+#include <linux/fs.h>
+#include <sys/stat.h>
+#include <string.h>
+
+#include "erofs/defs.h"
+#include "erofs/internal.h"
+#include "erofs/print.h"
+#include "namei.h"
+#include "erofs/io.h"
+
+size_t erofs_read_data_wrapper(struct erofs_vnode *vnode, char *buffer,
+			       size_t size, off_t offset)
+{
+	struct erofs_inode tmp = {
+		.u = {
+			.i_blkaddr = vnode->raw_blkaddr,
+		},
+		.nid = vnode->nid,
+		.i_size = vnode->i_size,
+		.datalayout = vnode->datalayout,
+		.inode_isize = vnode->inode_isize,
+		.xattr_isize = vnode->xattr_isize,
+	};
+
+	int ret = erofs_read_raw_data(&tmp, buffer, offset, size);
+	if (ret)
+		return ret;
+
+	erofs_info("nid:%llu size=%zd done", (unsigned long long)vnode->nid, size);
+	return size;
+}
+
+int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
+	       struct fuse_file_info *fi)
+{
+	int ret;
+	erofs_nid_t nid;
+	struct erofs_vnode v;
+
+	UNUSED(fi);
+	erofs_info("path:%s size=%zd offset=%llu", path, size, (long long)offset);
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	erofs_info("path:%s nid=%llu mode=%u", path, (unsigned long long)nid, v.datalayout);
+	switch (v.datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_FLAT_INLINE:
+		return erofs_read_data_wrapper(&v, buffer, size, offset);
+
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		/* Fixme: */
+	default:
+		return -EINVAL;
+	}
+}
+
diff --git a/fuse/read.h b/fuse/read.h
new file mode 100644
index 000000000000..3f4af1495510
--- /dev/null
+++ b/fuse/read.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/read.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __EROFS_READ_H
+#define __EROFS_READ_H
+
+#include <fuse.h>
+#include <fuse_opt.h>
+
+int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
+	    struct fuse_file_info *fi);
+
+#endif
diff --git a/fuse/readir.c b/fuse/readir.c
new file mode 100644
index 000000000000..5281c8b80e59
--- /dev/null
+++ b/fuse/readir.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/fuse/readir.c
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#include "readir.h"
+#include <errno.h>
+#include <linux/fs.h>
+#include <sys/stat.h>
+
+#include "erofs/defs.h"
+#include "erofs/internal.h"
+#include "erofs_fs.h"
+#include "namei.h"
+#include "erofs/io.h"
+#include "erofs/print.h"
+
+erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name,
+			uint32_t dirend)
+{
+	struct erofs_dirent *de = (struct erofs_dirent *)(entry + ofs);
+	uint16_t nameoff = le16_to_cpu(de->nameoff);
+	const char *de_name = entry + nameoff;
+	uint32_t de_namelen;
+
+	if ((void *)(de + 1) >= (void *)end)
+		de_namelen = strnlen(de_name, dirend - nameoff);
+	else
+		de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+	memcpy(name, de_name, de_namelen);
+	name[de_namelen] = '\0';
+	return le64_to_cpu(de->nid);
+}
+
+int fill_dir(char *entrybuf, fuse_fill_dir_t filler, void *buf,
+	     uint32_t dirend)
+{
+	uint32_t ofs;
+	uint16_t nameoff;
+	char *end;
+	char name[EROFS_BLKSIZ];
+
+	nameoff = le16_to_cpu(((struct erofs_dirent *)entrybuf)->nameoff);
+	end = entrybuf + nameoff;
+	ofs = 0;
+	while (ofs < nameoff) {
+		(void)split_entry(entrybuf, ofs, end, name, dirend);
+		filler(buf, name, NULL, 0);
+		ofs += sizeof(struct erofs_dirent);
+	}
+
+	return 0;
+}
+
+/** Function to add an entry in a readdir() operation
+ *
+ * @param buf the buffer passed to the readdir() operation
+ * @param name the file name of the directory entry
+ * @param stat file attributes, can be NULL
+ * @param off offset of the next entry or zero
+ * @return 1 if buffer is full, zero otherwise
+ */
+int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
+		  off_t offset, struct fuse_file_info *fi)
+{
+	int ret;
+	erofs_nid_t nid;
+	struct erofs_vnode v;
+	char dirsbuf[EROFS_BLKSIZ];
+	uint32_t dir_nr, dir_off, nr_cnt;
+
+	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
+	UNUSED(fi);
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	erofs_dbg("path=%s nid = %llu", path, (unsigned long long)nid);
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	if (!S_ISDIR(v.i_mode))
+		return -ENOTDIR;
+
+	if (!v.i_size)
+		return 0;
+
+	dir_nr = erofs_blknr(v.i_size);
+	dir_off = erofs_blkoff(v.i_size);
+	nr_cnt = 0;
+
+	erofs_dbg("dir_size=%u dir_nr = %u dir_off=%u", v.i_size, dir_nr, dir_off);
+
+	while (nr_cnt < dir_nr) {
+		memset(dirsbuf, 0, sizeof(dirsbuf));
+		ret = blk_read(dirsbuf, v.raw_blkaddr + nr_cnt, 1);
+		if (ret < 0)
+			return -EIO;
+		fill_dir(dirsbuf, filler, buf, EROFS_BLKSIZ);
+		++nr_cnt;
+	}
+
+	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
+		off_t addr;
+
+		addr = iloc(nid) + v.inode_isize + v.xattr_isize;
+
+		memset(dirsbuf, 0, sizeof(dirsbuf));
+		ret = dev_read(dirsbuf, addr, dir_off);
+		if (ret < 0)
+			return -EIO;
+		fill_dir(dirsbuf, filler, buf, dir_off);
+	}
+
+	return 0;
+}
+
diff --git a/fuse/readir.h b/fuse/readir.h
new file mode 100644
index 000000000000..ee2ab8bdd0f0
--- /dev/null
+++ b/fuse/readir.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/fuse/readir.h
+ *
+ * Created by Li Guifu <blucerlee@gmail.com>
+ */
+#ifndef __EROFS_READDIR_H
+#define __EROFS_READDIR_H
+
+#include <fuse.h>
+#include <fuse_opt.h>
+
+int erofs_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
+	       off_t offset, struct fuse_file_info *fi);
+
+
+#endif
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 8dee661ab9f0..e97de36aa04b 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -24,6 +24,9 @@
 #ifdef HAVE_LINUX_TYPES_H
 #include <linux/types.h>
 #endif
+#ifndef UNUSED
+#define UNUSED(_X)    ((void) _X)
+#endif
 
 /*
  * container_of - cast a member of a structure out to the containing structure
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index cabb2faa0072..f9e757316efe 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -55,10 +55,14 @@ typedef u32 erofs_blk_t;
 #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
 
 #define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, EROFS_BLKSIZ)
+#define IS_SLOT_ALIGN(__ADDR)   (((__ADDR) % (EROFS_SLOTSIZE)) ? 0 : 1)
+#define IS_BLK_ALIGN(__ADDR)    (((__ADDR) % (EROFS_BLKSIZ)) ? 0 : 1)
 
 struct erofs_buffer_head;
 
 struct erofs_sb_info {
+	u64 blocks;
+
 	erofs_blk_t meta_blkaddr;
 	erofs_blk_t xattr_blkaddr;
 
@@ -66,12 +70,25 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
+
+	unsigned char islotbits;
+
+	/* what we really care is nid, rather than ino.. */
+	erofs_nid_t root_nid;
+	/* used for statfs, f_files - f_favail */
+	u64 inos;
+
 	u8 uuid[16];
 };
 
 /* global sbi */
 extern struct erofs_sb_info sbi;
 
+static inline erofs_off_t iloc(erofs_nid_t nid)
+{
+	return blknr_to_addr(sbi.meta_blkaddr) + (nid << sbi.islotbits);
+}
+
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
 static inline bool erofs_sb_has_##name(void) \
 { \
@@ -132,11 +149,46 @@ struct erofs_inode {
 #endif
 };
 
+struct erofs_vnode {
+	uint8_t datalayout;
+
+	uint32_t i_size;
+	/* inline size in bytes */
+	uint16_t inode_isize;
+	uint16_t xattr_isize;
+
+	uint16_t xattr_shared_count;
+	char *xattr_shared_xattrs;
+
+	erofs_blk_t raw_blkaddr;
+	erofs_nid_t nid;
+	uint32_t i_ino;
+
+	uint16_t i_mode;
+	uint16_t i_uid;
+	uint16_t i_gid;
+	uint16_t i_nlink;
+
+	/* if file is inline read inline data witch inode */
+	char *idata;
+};
+
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 {
 	return erofs_inode_is_data_compressed(inode->datalayout);
 }
 
+#define __inode_advise(x, bit, bits) \
+		(((x) >> (bit)) & ((1 << (bits)) - 1))
+
+#define __inode_version(advise)	\
+		__inode_advise(advise, EROFS_I_VERSION_BIT,	\
+			EROFS_I_VERSION_BITS)
+
+#define __inode_data_mapping(advise)	\
+	__inode_advise(advise, EROFS_I_DATALAYOUT_BIT,\
+		EROFS_I_DATALAYOUT_BITS)
+
 #define IS_ROOT(x)	((x) == (x)->i_parent)
 
 struct erofs_dentry {
@@ -169,5 +221,36 @@ static inline const char *erofs_strerror(int err)
 	return msg;
 }
 
+enum {
+	BH_Meta,
+	BH_Mapped,
+	BH_Zipped,
+	BH_FullMapped,
+};
+
+/* Has a disk mapping */
+#define EROFS_MAP_MAPPED	(1 << BH_Mapped)
+/* Located in metadata (could be copied from bd_inode) */
+#define EROFS_MAP_META		(1 << BH_Meta)
+
+struct erofs_map_blocks {
+	char mpage[EROFS_BLKSIZ];
+
+	erofs_off_t m_pa, m_la;
+	u64 m_plen, m_llen;
+
+	unsigned int m_flags;
+	erofs_blk_t index;
+};
+
+/* super.c */
+int erofs_read_superblock(void);
+
+/* data.c */
+int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+			erofs_off_t offset, erofs_off_t size);
+
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
 #endif
 
diff --git a/include/erofs/io.h b/include/erofs/io.h
index a23de64541c6..557424578ece 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -17,6 +17,7 @@
 #endif
 
 int dev_open(const char *devname);
+int dev_open_ro(const char *dev);
 void dev_close(void);
 int dev_write(const void *buf, u64 offset, size_t len);
 int dev_read(void *buf, u64 offset, size_t len);
diff --git a/lib/Makefile.am b/lib/Makefile.am
index e4b51e65f053..22bd73255d04 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,8 +2,8 @@
 # Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
-liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c \
-		      compress.c compressor.c exclude.c
+liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
+		      data.c compress.c compressor.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/data.c b/lib/data.c
new file mode 100644
index 000000000000..56b208513980
--- /dev/null
+++ b/lib/data.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/data.c
+ *
+ * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#include "erofs/print.h"
+#include "erofs/internal.h"
+#include "erofs/io.h"
+#include "erofs/trace.h"
+
+static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
+				     struct erofs_map_blocks *map,
+				     int flags)
+{
+	int err = 0;
+	erofs_blk_t nblocks, lastblk;
+	u64 offset = map->m_la;
+	struct erofs_inode *vi = inode;
+	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+
+	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
+
+	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
+	lastblk = nblocks - tailendpacking;
+
+	if (offset >= inode->i_size) {
+		/* leave out-of-bound access unmapped */
+		map->m_flags = 0;
+		goto out;
+	}
+
+	/* there is no hole in flatmode */
+	map->m_flags = EROFS_MAP_MAPPED;
+
+	if (offset < blknr_to_addr(lastblk)) {
+		map->m_pa = blknr_to_addr(vi->u.i_blkaddr) + map->m_la;
+		map->m_plen = blknr_to_addr(lastblk) - offset;
+	} else if (tailendpacking) {
+		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
+		map->m_pa = iloc(vi->nid) + vi->inode_isize +
+			vi->xattr_isize + erofs_blkoff(map->m_la);
+		map->m_plen = inode->i_size - offset;
+
+		/* inline data should be located in one meta block */
+		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
+			erofs_err("inline data cross block boundary @ nid %" PRIu64,
+				  vi->nid);
+			DBG_BUGON(1);
+			err = -EFSCORRUPTED;
+			goto err_out;
+		}
+
+		map->m_flags |= EROFS_MAP_META;
+	} else {
+		erofs_err("internal error @ nid: %" PRIu64 " (size %llu), m_la 0x%" PRIx64,
+			  vi->nid, (unsigned long long)inode->i_size, map->m_la);
+		DBG_BUGON(1);
+		err = -EIO;
+		goto err_out;
+	}
+
+out:
+	map->m_llen = map->m_plen;
+
+err_out:
+	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
+	return err;
+}
+
+int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+			erofs_off_t offset, erofs_off_t size)
+{
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	int ret;
+	erofs_off_t ptr = offset;
+
+	while (ptr < offset + size) {
+		erofs_off_t eend;
+
+		map.m_la = ptr;
+		ret = erofs_map_blocks_flatmode(inode, &map, 0);
+		if (ret)
+			return ret;
+
+		DBG_BUGON(map.m_plen != map.m_llen);
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			if (!map.m_llen) {
+				ptr = offset + size;
+				continue;
+			}
+			ptr = map.m_la + map.m_llen;
+			continue;
+		}
+
+		/* trim extent */
+		eend = min(offset + size, map.m_la + map.m_llen);
+		DBG_BUGON(ptr < map.m_la);
+
+		if (ptr > map.m_la) {
+			map.m_pa += ptr - map.m_la;
+			map.m_la = ptr;
+		}
+
+		ret = dev_read(buffer + ptr - offset,
+			       map.m_pa, eend - map.m_la);
+		if (ret < 0)
+			return -EIO;
+
+		ptr = eend;
+	}
+	return 0;
+}
+
diff --git a/lib/io.c b/lib/io.c
index 4f5d9a6edaa4..d835f34da50f 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -108,6 +108,22 @@ int dev_open(const char *dev)
 	return 0;
 }
 
+/* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
+int dev_open_ro(const char *dev)
+{
+	int fd = open(dev, O_RDONLY | O_BINARY);
+
+	if (fd < 0) {
+		erofs_err("failed to open(%s).", dev);
+		return -errno;
+	}
+
+	erofs_devfd = fd;
+	erofs_devname = dev;
+	erofs_devsz = INT64_MAX;
+	return 0;
+}
+
 u64 dev_length(void)
 {
 	return erofs_devsz;
-- 
2.24.0

