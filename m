Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC410350E8F
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 07:49:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9shJ6dhlz304J
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 16:49:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=fail (SPF fail - not authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=47.90.88.95;
 helo=aliyun-sdnproxy-1.icoremail.net; envelope-from=sehuww@mail.scut.edu.cn;
 receiver=<UNKNOWN>)
X-Greylist: delayed 722 seconds by postgrey-1.36 at boromir;
 Thu, 01 Apr 2021 16:49:33 AEDT
Received: from aliyun-sdnproxy-1.icoremail.net (aliyun-cloud.icoremail.net
 [47.90.88.95])
 by lists.ozlabs.org (Postfix) with SMTP id 4F9shF18S0z2ydG
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 16:49:29 +1100 (AEDT)
Received: from laptop.huww98.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowACniNQwWmVg_SkIAA--.11859S4;
 Thu, 01 Apr 2021 13:29:21 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: hsiangkao@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add command line argument to override uid/gid
Date: Thu,  1 Apr 2021 13:29:03 +0800
Message-Id: <20210401052903.18700-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowACniNQwWmVg_SkIAA--.11859S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45Gry3Ar4fZF4rGrWfKrg_yoW5KryUpF
 4qgF18GF18ta48GFWfJryvvr1FgF97CF4qkwsF9w4xAr98J342qr1UtrZIgrsxWrW8Ar4Y
 v3929a43uFsrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
 wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
 80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
 I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
 k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
 1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQASBlepTBMIEQACsv
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Also added '--all-root' option to set uid and gid to root conveniently.

This function can be useful if we want to pack some data owned by user with
large uid, but we want to use compact inode.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 include/erofs/config.h |  2 ++
 lib/config.c           |  2 ++
 lib/inode.c            |  4 ++--
 mkfs/main.c            | 23 ++++++++++++++++++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 02ddf59..e6eaef6 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -54,6 +54,8 @@ struct erofs_configure {
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
 	u64 c_unix_timestamp;
+	u32 c_uid;
+	u32 c_gid;
 #ifdef WITH_ANDROID
 	char *mount_point;
 	char *target_out_path;
diff --git a/lib/config.c b/lib/config.c
index 3ecd481..b8df239 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -24,6 +24,8 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_uid = -1;
+	cfg.c_gid = -1;
 }
 
 void erofs_show_config(void)
diff --git a/lib/inode.c b/lib/inode.c
index 40189fe..d52facf 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -752,8 +752,8 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	if (err)
 		return err;
 	inode->i_mode = st->st_mode;
-	inode->i_uid = st->st_uid;
-	inode->i_gid = st->st_gid;
+	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
+	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
 	inode->i_ctime = st->st_ctime;
 	inode->i_ctime_nsec = st->st_ctim.tv_nsec;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index d9c4c7f..49b94b4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -36,6 +36,7 @@ static struct option long_options[] = {
 #ifdef HAVE_LIBSELINUX
 	{"file-contexts", required_argument, NULL, 4},
 #endif
+	{"all-root", no_argument, NULL, 5},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 10},
 	{"product-out", required_argument, NULL, 11},
@@ -74,6 +75,9 @@ static void usage(void)
 #ifdef HAVE_LIBSELINUX
 	      " --file-contexts=X  specify a file contexts file to setup selinux labels\n"
 #endif
+	      " --all-root         make all files owned by root\n"
+	      " -u#                set all file uids to #\n"
+	      " -g#                set all file gids to #\n"
 	      " --help             display this help and exit\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
@@ -152,7 +156,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while((opt = getopt_long(argc, argv, "d:x:z:E:T:U:",
+	while ((opt = getopt_long(argc, argv, "d:x:z:E:T:U:u:g:",
 				 long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -203,6 +207,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			cfg.c_timeinherit = TIMESTAMP_FIXED;
 			break;
+		case 'u':
+			cfg.c_uid = strtoul(optarg, &endptr, 0);
+			if (cfg.c_uid == -1 || *endptr != '\0') {
+				erofs_err("invalid uid %s", optarg);
+				return -EINVAL;
+			}
+			break;
+		case 'g':
+			cfg.c_gid = strtoul(optarg, &endptr, 0);
+			if (cfg.c_gid == -1 || *endptr != '\0') {
+				erofs_err("invalid gid %s", optarg);
+				return -EINVAL;
+			}
+			break;
 #ifdef HAVE_LIBUUID
 		case 'U':
 			if (uuid_parse(optarg, sbi.uuid)) {
@@ -233,6 +251,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt && opt != -EBUSY)
 				return opt;
 			break;
+		case 5:
+			cfg.c_uid = cfg.c_gid = 0;
+			break;
 #ifdef WITH_ANDROID
 		case 10:
 			cfg.mount_point = optarg;
-- 
2.25.1

