Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70239351483
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 13:37:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB1P72Zgrz30D3
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 22:36:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
X-Greylist: delayed 22028 seconds by postgrey-1.36 at boromir;
 Thu, 01 Apr 2021 22:36:55 AEDT
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FB1P36kLFz2xgH
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 22:36:54 +1100 (AEDT)
Received: from laptop.huww98.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowAAXH9c6sGVgKTsJAA--.30589S4;
 Thu, 01 Apr 2021 19:36:27 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: hsiangkao@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: add cmd argument to override uid/gid
Date: Thu,  1 Apr 2021 19:36:10 +0800
Message-Id: <20210401113610.49094-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401060132.GA3827683@xiangao.remote.csb>
References: <20210401060132.GA3827683@xiangao.remote.csb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAAXH9c6sGVgKTsJAA--.30589S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45XFWkJw4UGr4UKFWrAFb_yoWrGF1rpF
 n0qF1kCFy8tasrCFWftr929r1Fg3Z7CFZFka9ruw4Iyr98AFyvqr1jqFZxWr1kWrWkCFWY
 vrZ2vay3CrnrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
 wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
 80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
 I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
 k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
 1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQASBlepTBMIEQAHsq
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

This interface mimics that of 'mksquashfs'.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 include/erofs/config.h |  2 ++
 lib/config.c           |  2 ++
 lib/inode.c            |  4 ++--
 man/mkfs.erofs.1       |  9 +++++++++
 mkfs/main.c            | 23 +++++++++++++++++++++++
 5 files changed, 38 insertions(+), 2 deletions(-)

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
 
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index dcaf9d7..254c3ec 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -69,6 +69,15 @@ You may give multiple `--exclude-regex` options.
 .BI "\-\-file-contexts=" file
 Specify a \fIfile_contexts\fR file to setup / override selinux labels.
 .TP
+.BI "\-\-force-uid=" UID
+Set all file uids to \fIUID\fR.
+.TP
+.BI "\-\-force-gid=" GID
+Set all file gids to \fIGID\fR.
+.TP
+.B \-\-all-root
+Make all files owned by root.
+.TP
 .B \-\-help
 Display this help and exit.
 .SH AUTHOR
diff --git a/mkfs/main.c b/mkfs/main.c
index d9c4c7f..72b7f17 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -36,6 +36,9 @@ static struct option long_options[] = {
 #ifdef HAVE_LIBSELINUX
 	{"file-contexts", required_argument, NULL, 4},
 #endif
+	{"force-uid", required_argument, NULL, 5},
+	{"force-gid", required_argument, NULL, 6},
+	{"all-root", no_argument, NULL, 7},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 10},
 	{"product-out", required_argument, NULL, 11},
@@ -74,6 +77,9 @@ static void usage(void)
 #ifdef HAVE_LIBSELINUX
 	      " --file-contexts=X  specify a file contexts file to setup selinux labels\n"
 #endif
+	      " --force-uid=UID    set all file uids to UID\n"
+	      " --force-gid=GID    set all file gids to GID\n"
+	      " --all-root         make all files owned by root\n"
 	      " --help             display this help and exit\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
@@ -233,6 +239,23 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt && opt != -EBUSY)
 				return opt;
 			break;
+		case 5:
+			cfg.c_uid = strtoul(optarg, &endptr, 0);
+			if (cfg.c_uid == -1 || *endptr != '\0') {
+				erofs_err("invalid uid %s", optarg);
+				return -EINVAL;
+			}
+			break;
+		case 6:
+			cfg.c_gid = strtoul(optarg, &endptr, 0);
+			if (cfg.c_gid == -1 || *endptr != '\0') {
+				erofs_err("invalid gid %s", optarg);
+				return -EINVAL;
+			}
+			break;
+		case 7:
+			cfg.c_uid = cfg.c_gid = 0;
+			break;
 #ifdef WITH_ANDROID
 		case 10:
 			cfg.mount_point = optarg;
-- 
2.25.1

