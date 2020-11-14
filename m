Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 103C22B2FB1
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:28:21 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP3Q3f75zDq9y
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:28:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378498;
	bh=3bPoUORyFD8wsqY+M5rdg1f/4ryekKTnzFrto8fo5KY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=oJg1oQvoN9bQJKmZxz7sXnRBQrhoA9Xp98v+acj1ziFe266SOvZFMK8wC2VPuQrAg
	 P8rNyMECxRViey+ZIHkT4jSwI62NUzbdMgJmOi1meGyL6dj6JiAcXijOAh18umFfcW
	 mog0cNvjfAMSa3iVB3kUe6MuNddeWi81regR7PcUocF9ijAhEOuADMWpQKVVi/vcpV
	 0DJmtYZILbswQR35OWSp6tejthG3/lVVcydnUAqSkEUHzlcwNw7FfT4iDC07TZtd1d
	 OVbMX1XwOxoxth2wglZitqeJnmpdoXsC+q04khSfk8t6aLe9VB/9xuLyl8iHMNSYYF
	 z1m6sFLKY2PIA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.148; helo=sonic301-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=GhddejY/; dkim-atps=neutral
Received: from sonic301-22.consmr.mail.gq1.yahoo.com
 (sonic301-22.consmr.mail.gq1.yahoo.com [98.137.64.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP3K4zvHzDqGN
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:28:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378490; bh=kSnu21twuO3GHT4WGNG3cEwYgrwVXa+KmNvfl48bPrU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=GhddejY/KvUl8Ms0mGE8a0ppcAlf13EwUrHFg+F9S1qPyGt5sQ+qzdRk6CwVXOgEwq6Ypq/HsobnOIJ1koCiIQGL3RKhnEm+WW9QL1vt9xeqjd+mUevK7M/qnSL/cFvMMR8kAtOSzAVXfCVoCpap7DJUgXSZ4kgurkGz0tErQI7WXB2VHZ+BkcfmXoHYZ4MyJFA+dtTupyUQbQNpeYtefZlvQss8xcigvrkr4dsxjWCzD1COs4m3X9k0E40plEWLn3eH5KYsAvmo0Gd0gfkt7cDPvcew5yi6aBT7bmzs5Wskv/er0+d6FMAIfZsDt2AE/7WGPCC7+yI/AV9IpXudKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378490; bh=0VKKntGg28GUzdBztGCxdJ0viUxtg5FrDj3DfqEUZ72=;
 h=From:To:Subject:Date:From:Subject;
 b=Admn5Y9mQrT2S0fXJkJXMpTMDXRCSpvnPyXuseLun56x3F0wurGOQuKoR3Hv97QL2acJKxWqWIeWLNKm4kTlWm6BYQ///83QPlqgShNK5sB6rBDX8L7bkp0u/c9BvQXNd02wF4DraqFJ5qt8Ty0KcXo+yVtA6yxGJXZeiVVOPzoSDq2vXM8bLz63NrLOCFYLRiRCVdu9vXmiBYK7HshuUoSxyGUFE+tBDVpE6Cnk3W9N1J1J+Vge2Ou0sVVhIcEE10yfpt4R54uAGzyS4nM5XJJXXh+dmRALb54lj6czuMDOrcPnKKuQoS1FgkXnIOsEOB3qPp30+IF0VxHW0ghpJA==
X-YMail-OSG: lcNpYBIVM1mbtDMeUUMkYbRWh7yT7Ls0xt2qvMx7FJljMJW66IBfGONPVvKwuv6
 PMb5y5IBl5h0C2zctjbR_culNdPBtKVoyQ2gbef7bSvcz4kVIN_m_rZ757glNyAcSTlGopGDDPYd
 f4RY1x5Cb0vCK5N4qvD5ypUDdTrWT6ygZJybaIpc1CdMOcxshxgaf45fmk62nJIS1byvR8RHevxP
 3Fd6qLq9bvk3bXFGgisGldwP4R8ulFfu2zISfqoCS4OgZ5ASTE5kgyT3sUNqgbRmXbyU7kcOoI6V
 gX_tlqkhRwSTZTgqdljYwkd2ckMVLTl5zYBXxCjpcAfurav1gX38PO9_WcFnFdlVtKkxxGuRPL3y
 DjVa5mYso9bUVsGMFvCFPRAu_.19IH7F8BhLgKEABi9IOqRKeQ9vce0rDxe5hJQ2K1RtMN6AHyWj
 FSVDU1rt8zHD2K9ZPcO34T_gqFB6skfMAoz6nzxTym8Aw5NwEbFfdU_qsQebhlrbhYZkwmj5knh6
 eUn_F1CJFqn86lm95kMvu3bAJ57itgRiOwLYr5ghLP61Ux2VNKMvdy7K32P.fQSblLGw2AFbdKZR
 NVh_kz9I0DnVDubfRxf1GJKwFbikqGV9PwdcYXa4sDzNQ1zynR1k23qAhWeLHUJn_D2ss1eoUOwI
 vwC_1rjz42l5.iUKcOjBUHHJ_dD5K32shPPW_3D_pt.mDiG2pBRsZxHtJtGNdz_XdRZalKIxiHhg
 IOZBpfRiWFiV4TyRxQBcH0yPIzT3ZIh8Qi5wO9aIWdxmRyUpcRMCIPQpiGBeD293tZaHIOpPZPSX
 lW4qlPoWIziCsHukS2BRzEKxmgiS5Hy_gWgOfpF5eXecGVu_j0ADbeXWAn2GMO5kp6P46S6Shgvm
 jBjcH1mNpyStA5IGgSfqMZwyS10SOJoK3z7nXS7Twl7iOwbTK99tSgRhPyK1y4WqAyTzGuAqFnCB
 11p7xBeqeRZMlXnEJHa5WJ_HOMymwLa8N1BAVBN2ehQxyXGBTbZ.p0gcHulaUBs4NmI6MwZ0vHhP
 6zClYtmWtFKdUfdqpeIvd46Q27UI8n8BvhQGRvmWCcpw_DifbpRMU5rv.FyVlK591GxyVl2nhI35
 eOEHegIe4qHbu8.XGtqs3szDyUv.DaSh.QUAT0gPdsah57WB44RjqRl5urIT86ad8WJtws12A4Mr
 L2jUBcR2fRHlcVkTexJWtZTiqHcL8FCG3cuDW8Yzs0eGiYSaoQDPp.Q94mfOkuuO58hE_PVUPuhQ
 iCyVRktD3PYaw2ioaFOUIraZbSn2Csz3soFy60LnavvZyp8ZDhha5MRSWXw8nNIMZNExbb7GcKj6
 f7460BAK9hj6Vie6I6wW5dbMst.DiSyihyam55hlK8rb61fOmv2vlThaDYW7bx1aM_61Wf79tpNK
 khqICOAuj9wdCq0rKNZJ2oCrrV4Ih1do5pSIAv60n26Arg.p8kFTSl7eRDG8y02OpHJ2vFeksD4m
 JX6M5DB5luFNhaT8NsSimRnb6WnGyS22fvIuZZAvPu8IrN2tE8XE1DRFoN.iCCYWAZ85BkbVJcfE
 bCRTxaqm.Rk8UGtJhcTRSa3iQVjz3fRhH0buBfPzvOYjLv.DK427h.Bvw.zeDMR8w2LmNAu6DeqH
 ZMjsVRQdwKxBM4VQ6wtwIvy.EF.fLyM8UydCcjdJSopKPMDwjdkknw4Vjo7LFDcLYVdz2CLt1Iif
 wXUFRMxC0AxwTRlPAV6Brn2YqPHv6qOhg48wpQsXrFaK1fHDJ91Js3Rraaapw5YoF3BmOPYPCPNz
 9H.TfiCBl1hqVVicgKcq92fJmK44tiqF.zRCHoHie72wDBDGwHXTW3plAIpDCcEsZ__lE9.KjcGv
 uvCF8dF2WY_h1mxih9HCIrdq19TRF1yaCC0FTW48tjjiV7gysGSLUvu.Nc8CrWs.QTb.s4eUKuIE
 4ZZkLwyt1gx1oxdVFmXva8Yp_71O.AJehj.hi8JRiOmf3LlYo6UKv5OW4JPULU1N881vgV.hA7ll
 0ZSR9wRG2EmTua9yyeyYzV_WXhzCRzNN_XPzMK.tFNuuPV35DaYhi4DI4fwW4bJkpfdRq.cnMEFG
 omU1G5ZQaS3preSPtN89oSQa4i2TtaeUZje__HEdZs980zZPSrOf21jbAHBqMoLPz3Z70i6heq6u
 cAs5ANqS5PpftIyNWlY_WN3R.FNlSyLDUikBo1fDKTqvD3szcqLTz.Bn6uHszN1mgltv472f2TP8
 94KG11pI4k0J8ndg7z97tC5I1GCq0zeqBnlWd67bldIYDKFbC2wtRsePDdw44_c1r9zl3d7yHb0K
 r970A6mHbRnJSBi6zgTdZYqSZYHCUKR5QPQsjnDvsf1z2KGFfH6txGzgI1sumE3VYGZ3fyBsv_9h
 ze.Znf8F.qoSgHY1c_BfgtS0yMY9BeszkNohFg_2UczKvAiF8CgmiWbU0ONYgL0r69BWm7VlIodX
 WD64GA8iM5Pi4B7T17t0vkSHA0DDR0LKVQ.O5vPn5ruZPdZ_72IJVl6vrAIPES1pyB8vxHw8Dj6E
 vkbwT99juMhwNW43aKI9t3ZL7ZaPp7R.Zk9IuWg4b6fDw4CauFXsTbBMANCw7A6ZzWgSQJxIzR20
 hkCa.q5TLsXpYzhPTjLzjIhmJmoyS74osSCSNZqyjb48MhvEKg30geewfQaoRNiZrOIqI6w2nuNO
 OYs0ikBzpzZ0-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:28:10 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 1d0fcb25c7973fe782c79ebccd4a2e5a; 
 Sat, 14 Nov 2020 18:28:09 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 11/12] erofs-utils: fuse: cleanup main.c
Date: Sun, 15 Nov 2020 02:27:49 +0800
Message-Id: <20201114182750.10089-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201114182750.10089-1-hsiangkao@aol.com>
References: <20201114182517.9738-1-hsiangkao@aol.com>
 <20201114182750.10089-1-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/main.c | 240 +++++++++++++++++++++++++---------------------------
 1 file changed, 113 insertions(+), 127 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index 236d54635acb..7beaba8a9bc2 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -4,125 +4,28 @@
  *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <execinfo.h>
 #include <signal.h>
-#include <stddef.h>
-
+#include <libgen.h>
 #include <fuse.h>
 #include <fuse_opt.h>
 
+#include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/io.h"
 
 int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
 		      off_t offset, struct fuse_file_info *fi);
 
-/* XXX: after liberofs is linked in, it should be removed */
-struct erofs_configure cfg;
-
-enum {
-	EROFS_OPT_HELP,
-	EROFS_OPT_VER,
-};
-
-struct options {
-	const char *disk;
-	const char *mount;
-	const char *logfile;
-	unsigned int debug_lvl;
-};
-static struct options fusecfg;
-
-#define OPTION(t, p)    { t, offsetof(struct options, p), 1 }
-
-static const struct fuse_opt option_spec[] = {
-	OPTION("--log=%s", logfile),
-	OPTION("--dbg=%u", debug_lvl),
-	FUSE_OPT_KEY("-h", EROFS_OPT_HELP),
-	FUSE_OPT_KEY("-v", EROFS_OPT_VER),
-	FUSE_OPT_END
-};
-
-static void usage(void)
-{
-	fprintf(stderr, "\terofsfuse [options] <image> <mountpoint>\n");
-	fprintf(stderr, "\t    --log=<file>    output log file\n");
-	fprintf(stderr, "\t    --dbg=<level>   log debug level 0 ~ 7\n");
-	fprintf(stderr, "\t    -h   show help\n");
-	fprintf(stderr, "\t    -v   show version\n");
-	exit(1);
-}
-
-static void dump_cfg(void)
-{
-	fprintf(stderr, "\tdisk :%s\n", fusecfg.disk);
-	fprintf(stderr, "\tmount:%s\n", fusecfg.mount);
-	fprintf(stderr, "\tdebug_lvl:%u\n", fusecfg.debug_lvl);
-	fprintf(stderr, "\tlogfile  :%s\n", fusecfg.logfile);
-}
-
-static int optional_opt_func(void *data, const char *arg, int key,
-			     struct fuse_args *outargs)
-{
-	UNUSED(data);
-	UNUSED(outargs);
-
-	switch (key) {
-	case FUSE_OPT_KEY_OPT:
-		return 1;
-
-	case FUSE_OPT_KEY_NONOPT:
-		if (!fusecfg.disk) {
-			fusecfg.disk = strdup(arg);
-			return 0;
-		} else if (!fusecfg.mount)
-			fusecfg.mount = strdup(arg);
-
-		return 1;
-	case EROFS_OPT_HELP:
-		usage();
-		break;
-
-	case EROFS_OPT_VER:
-		fprintf(stderr, "EROFS FUSE VERSION v 1.0.0\n");
-		exit(0);
-	}
-
-	return 1;
-}
-
-static void signal_handle_sigsegv(int signal)
-{
-	void *array[10];
-	size_t nptrs;
-	char **strings;
-	size_t i;
-
-	UNUSED(signal);
-	erofs_dbg("========================================");
-	erofs_dbg("Segmentation Fault.  Starting backtrace:");
-	nptrs = backtrace(array, 10);
-	strings = backtrace_symbols(array, nptrs);
-	if (strings) {
-		for (i = 0; i < nptrs; i++)
-			erofs_dbg("%s", strings[i]);
-		free(strings);
-	}
-	erofs_dbg("========================================");
-
-	abort();
-}
-
-void *erofs_init(struct fuse_conn_info *info)
+static void *erofsfuse_init(struct fuse_conn_info *info)
 {
 	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
 	return NULL;
 }
 
-int erofs_open(const char *path, struct fuse_file_info *fi)
+static int erofsfuse_open(const char *path, struct fuse_file_info *fi)
 {
 	erofs_info("open path=%s", path);
 
@@ -132,7 +35,7 @@ int erofs_open(const char *path, struct fuse_file_info *fi)
 	return 0;
 }
 
-int erofs_getattr(const char *path, struct stat *stbuf)
+static int erofsfuse_getattr(const char *path, struct stat *stbuf)
 {
 	struct erofs_inode v = { 0 };
 	int ret;
@@ -186,51 +89,134 @@ static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
 
 static struct fuse_operations erofs_ops = {
 	.readlink = erofsfuse_readlink,
-	.getattr = erofs_getattr,
+	.getattr = erofsfuse_getattr,
 	.readdir = erofsfuse_readdir,
-	.open = erofs_open,
+	.open = erofsfuse_open,
 	.read = erofsfuse_read,
-	.init = erofs_init,
+	.init = erofsfuse_init,
 };
 
+static struct options {
+	const char *disk;
+	const char *mount;
+	unsigned int debug_lvl;
+	bool show_help;
+} fusecfg;
+
+#define OPTION(t, p)                           \
+    { t, offsetof(struct options, p), 1 }
+static const struct fuse_opt option_spec[] = {
+	OPTION("-d %u", debug_lvl),
+	OPTION("-h", show_help),
+	OPTION("--help", show_help),
+	FUSE_OPT_END
+};
+
+#define OPTION(t, p)    { t, offsetof(struct options, p), 1 }
+
+static void usage(void)
+{
+	fprintf(stderr, "\terofsfuse [options] <image> <mountpoint>\n");
+	fprintf(stderr, "\t    --log=<file>    output log file\n");
+	fprintf(stderr, "\t    --dbg=<level>   log debug level 0 ~ 7\n");
+	fprintf(stderr, "\t    -h   show help\n");
+	fprintf(stderr, "\t    -v   show version\n");
+	exit(EXIT_FAILURE);
+}
+
+static void erofsfuse_dumpcfg(void)
+{
+	erofs_info("disk: %s", fusecfg.disk);
+	erofs_info("mountpoint: %s", fusecfg.mount);
+	erofs_info("debug level: %u", cfg.c_dbg_lvl);
+}
+
+static int optional_opt_func(void *data, const char *arg, int key,
+			     struct fuse_args *outargs)
+{
+	switch (key) {
+	case FUSE_OPT_KEY_NONOPT:
+		if (!fusecfg.disk) {
+			fusecfg.disk = strdup(arg);
+			return 0;
+		}
+		if (!fusecfg.mount)
+			fusecfg.mount = strdup(arg);
+	case FUSE_OPT_KEY_OPT:
+		break;
+	default:
+		DBG_BUGON(1);
+		break;
+	}
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
+
 int main(int argc, char *argv[])
 {
-	int ret = EXIT_FAILURE;
+	int ret;
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
 
+	erofs_init_configure();
+	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
+
 	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
-		fprintf(stderr, "Failed to initialize signals\n");
-		return EXIT_FAILURE;
+		fprintf(stderr, "failed to initialize signals\n");
+		ret = -errno;
+		goto err;
 	}
 
-	/* Parse options */
-	if (fuse_opt_parse(&args, &fusecfg, option_spec, optional_opt_func) < 0)
-		return 1;
-
-	dump_cfg();
+	/* parse options */
+	ret = fuse_opt_parse(&args, &fusecfg, option_spec, optional_opt_func);
+	if (ret)
+		goto err;
 
+	if (fusecfg.show_help)
+		usage();
 	cfg.c_dbg_lvl = fusecfg.debug_lvl;
 
-	if (dev_open_ro(fusecfg.disk) < 0) {
-		fprintf(stderr, "Failed to open disk:%s\n", fusecfg.disk);
-		goto exit;
+	erofsfuse_dumpcfg();
+	ret = dev_open_ro(fusecfg.disk);
+	if (ret) {
+		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
+		goto err_fuse_free_args;
 	}
 
-	if (erofs_read_superblock()) {
-		fprintf(stderr, "Failed to read erofs super block\n");
-		goto exit_dev;
+	ret = erofs_read_superblock();
+	if (ret) {
+		fprintf(stderr, "failed to read erofs super block\n");
+		goto err_dev_close;
 	}
 
-	erofs_info("fuse start");
-
 	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
-
-	erofs_info("fuse done ret=%d", ret);
-
-exit_dev:
+err_dev_close:
 	dev_close();
-exit:
+err_fuse_free_args:
 	fuse_opt_free_args(&args);
-	return ret;
+err:
+	erofs_exit_configure();
+	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
 }
 
-- 
2.24.0

