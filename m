Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2067E56F95F
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 10:55:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LhHlp6KwQz3by9
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 18:55:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.92.39.34; helo=smtpbgjp3.qq.com; envelope-from=lihe@uniontech.com; receiver=<UNKNOWN>)
X-Greylist: delayed 22049 seconds by postgrey-1.36 at boromir; Mon, 11 Jul 2022 18:55:26 AEST
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LhHlf5H8yz3btW
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 18:55:10 +1000 (AEST)
X-QQ-mid: bizesmtp89t1657529700tg6rrjsa
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Jul 2022 16:54:59 +0800 (CST)
X-QQ-SSF: 01400000002000P0W000000A0000000
X-QQ-FEAT: WBSeGZ0pNqgivPkuyp7eKK+k0GtARSH1Z5en7Ht8y9L1dM/7/d6QftjVRaq/M
	1KXuZotDiEMfVHSKAWTQag3T7QZiI3gKo49oi+V6NPMDKJQ6Tuxh5APXjIpDh8w1pOPzcnO
	OPIfkpH9dw2C1MUAmxmy2pNZZYtlUy1OyD5VS2yBMYdQl0XGbri+uNptNN68225hv0U1Dxl
	YCOZKzbODrzZQm2szDoyg6Uk1deq+iO6GYVanNqBQlm0avQd3tjcPrzSkN//GOaN+w1Z7Jg
	PiuDWFxqOH9zAgwosIU8NjtjwnQvaBb3eBN+r3VUdiiYSpMnWYWXYhNYB1z/Ex7d2qrv3hy
	i0UTVTrsWcGcn97Us2QdBTdujWhbt1crPM9EbL5kdImkBd0JbBuzsGmEyiuKWyk5R3I04w8
	CeY0l3R/pTA=
X-QQ-GoodBg: 2
From: Li He <lihe@uniontech.com>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: fuse: support offset when read image
Date: Mon, 11 Jul 2022 16:54:59 +0800
Message-Id: <20220711085459.19730-1-lihe@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YsuejqlGUUp3cC4S@B-P7TQMD6M-0146.local>
References: <YsuejqlGUUp3cC4S@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add --offset to erofsfuse to skip bytes at the start of the image file.

Signed-off-by: Li He <lihe@uniontech.com>
---
We should add offset to fuse_operations so erofsfuse can parse it from
command line. fuse_opt_parse can not parse cfg directly.

Changes since v0
+ Add manpage for erofsfuse offset option

 fuse/main.c            | 6 ++++++
 include/erofs/config.h | 3 +++
 lib/io.c               | 2 ++
 man/erofsfuse.1        | 3 +++
 4 files changed, 14 insertions(+)

diff --git a/fuse/main.c b/fuse/main.c
index f4c2476..a2a6449 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -151,6 +151,7 @@ static struct fuse_operations erofs_ops = {
 static struct options {
 	const char *disk;
 	const char *mountpoint;
+	u64 offset;
 	unsigned int debug_lvl;
 	bool show_help;
 	bool odebug;
@@ -158,6 +159,7 @@ static struct options {
 
 #define OPTION(t, p) { t, offsetof(struct options, p), 1 }
 static const struct fuse_opt option_spec[] = {
+	OPTION("--offset=%lu", offset),
 	OPTION("--dbglevel=%u", debug_lvl),
 	OPTION("--help", show_help),
 	FUSE_OPT_KEY("--device=", 1),
@@ -170,6 +172,7 @@ static void usage(void)
 
 	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
 	      "Options:\n"
+	      "    --offset=#             # bytes to skip when read IMAGE\n"
 	      "    --dbglevel=#           set output message level to # (maximum 9)\n"
 	      "    --device=#             specify an extra device to be used together\n"
 #if FUSE_MAJOR_VERSION < 3
@@ -190,6 +193,7 @@ static void usage(void)
 static void erofsfuse_dumpcfg(void)
 {
 	erofs_dump("disk: %s\n", fusecfg.disk);
+	erofs_dump("offset: %lu\n", fusecfg.offset);
 	erofs_dump("mountpoint: %s\n", fusecfg.mountpoint);
 	erofs_dump("dbglevel: %u\n", cfg.c_dbg_lvl);
 }
@@ -279,6 +283,8 @@ int main(int argc, char *argv[])
 	if (fusecfg.odebug && cfg.c_dbg_lvl < EROFS_DBG)
 		cfg.c_dbg_lvl = EROFS_DBG;
 
+	cfg.c_offset = fusecfg.offset;
+
 	erofsfuse_dumpcfg();
 	ret = dev_open_ro(fusecfg.disk);
 	if (ret) {
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 0d0916c..8b6f7db 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -73,6 +73,9 @@ struct erofs_configure {
 	char *fs_config_file;
 	char *block_list_file;
 #endif
+
+	/* offset when read mutli partiton image */
+	u64 c_offset;
 };
 
 extern struct erofs_configure cfg;
diff --git a/lib/io.c b/lib/io.c
index 9c663c5..524cfb4 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -261,6 +261,8 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
 	if (cfg.c_dry_run)
 		return 0;
 
+	offset += cfg.c_offset;
+
 	if (!buf) {
 		erofs_err("buf is NULL");
 		return -EINVAL;
diff --git a/man/erofsfuse.1 b/man/erofsfuse.1
index 9db6827..1d47163 100644
--- a/man/erofsfuse.1
+++ b/man/erofsfuse.1
@@ -26,6 +26,9 @@ warning messages.
 .BI "\-\-device=" path
 Specify an extra device to be used together.
 You may give multiple `--device' options in the correct order.
+.TP
+.BI "\-\-offset=" #
+Specify offset bytes to skip when read image file. The default is 0.
 .SS "FUSE options:"
 .TP
 \fB-d -o\fR debug
-- 
2.20.1



