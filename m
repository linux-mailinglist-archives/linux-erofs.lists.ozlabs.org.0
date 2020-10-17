Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF69290F03
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:17:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrql2cKKzDr1X
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:17:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911843;
	bh=UuSuDPl9YyqP78UEgV+rFbGWqSqViEXfv7Ezjdjlfo4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HNq5B+QlrdyRwRWeCVKXZaxMYcU3CRLcHrQt4sj8ss2Y/oxZ3gyd2pj22JFRnJa2S
	 +yztjLP3UQ5liAPnrB7EmOkF2Y/AVEF3s3VVKSVipfdHC0NfThSxjAOd1C93KXQNLX
	 3oEeqOmsCcM/aNTMl0cTnyt+Ym8V3LjjapaB7JZMMtHLnyoiLDfdFoQk8fQKX1ENhG
	 Uk7LftP49OOdfeLMgoigK+xp+XHPYb9WwVATln/HHdmTkO7q7jav5ediCov0ecfxr3
	 VDCjLgODT89D3k+E+DiSj0ZDA2orZs2/0zCuF9s82DUNiX7yRsFsVv7AvnKMX5TTU1
	 9uAHdChfhg1VQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=BANndSGe; dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrqN35LKzDqyd
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:17:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911821; bh=OsG9cI8KUbNJ9UBp+HPbgmezbp8GLQ5w3xq+dYErjBA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=BANndSGeJBGjGluK08oyo8lpN8B6ZrUpYt8gzgn/bHlz6UminnEWLBB4BojYcaRZYycE1f1tc9YABvJikhvAW3ZpBskE/cq9msVk5eaOhm7881rwiIgwZctBicWVNpzbW9fGRABpO8H9XEHDS72QzVz4QBUYgdg4JFmj1hH8cTnXiqjnuEo1g/ax3vVUm/5+ZneejgDcPnpunK2PZNPccuUv8yAzzyoINx0mFChfWRTBhgvJ5ut3leleKHBJqsSvbDyCPq+9ZGQTnu+pw35ooal4OTNRoyP8CtRyNC0eyMmevLSY1ck/y8RQenmxqDkP1o/AjFkEukHoSmhoL8WjGQ==
X-YMail-OSG: ZqV6BswVM1kkpMpJETPbqyphCM96lsnvYfRcPpPns8KTsNGdeklk83H3fXVA0uB
 imEX4gTHcROgE9cK344cfZQs1ZFYOV9cpGd_Mky3qh.cV51JmTrE6wDEwW_8PA6hNyKitUEJ3bLA
 j89NFA03mPyNdCuIvskJHD7tSmxlkjCbAt_i6nCbZEuKc110q9rTSD9s9dADf.lccAg9Ai2.xS2e
 dI5HHRae0jJDKenJPpQUwoPp2qLf.Us62Dl2Rbddi9EOvhasxHPWm2efc9w.ynj3ysf590GvBt7d
 SCCm0hOV4X9Rf.ZI6p1RIhLxvnmiWvGqthH.Es6LI7otyUqjquJIn47t4XOTdmZzuSNErYhv21QW
 aJmjy2u6n1Gp78jxgDkUjMZsdMI6BQSoCxK1dmfWplIdMGRjN9ntOiBfzYa1GNkPdL1NfpabEBCk
 .Ng0IMhKO.z3blAzOckGxeehD7fohKv5e8.GETWwgT1oOM_ekJYqsjS7QGZk0psj99uWuE0IAHH4
 sOest12VxZ5.cIkTVjOcwd4d7GKOFrFIz8_FB2gQaTK51HSy2ZRsTwGp6qcLgsBg2PS37dvryJG3
 DQ8vJsVzqrC1BAhluFot4FS4M0cKns1IIWmp7ugrfEW8WgRXWeiKMQk6l2OCFgkJ8Dtr9KHQzlP1
 dB9rTu4sJlGdgJR3iKIvHNMCbVzAqSZAnItVDb6gVvibaQ5w815kBBDvO1w603H42wgEL7gZJItx
 NwCzIJcoEm7m5FaTW6JaiUMKYl3iiyLZwnEzL_kHLl0kpiEMwnuHJ2BP9qzhXNV1Qu0Y5uLEqiHu
 h5oWO_AWoH1GoElaKSTLAJyv7Lg2UhA6GurBjUQuQU_w_FbD2zKlL.i00oNzzVfk10vw35p5xY5I
 BroNbmiMHwnOFlNgT8t3SPH41GGg3a9cBedwvvRsJQPnh5RIsx90y7MJOlDejtABxnfNpGe_PElc
 iC3blJb5OVPai9PKrjDoUJu2WqfFoN5oUTZvr6oOPa3Rst0.Av4hH4Hej_Ed0th6K5rExc5NivsF
 Gu2EOwCQqtBgL.pvofqOGDwH9A4x8JyST9YfRaBbK8xlI6DpM.O5UGxbCamUgmAJ9cMUajZMF.xD
 kaQJGLY7Ly5yglBRv65VZVTPgcAqM7fkC4hchMTuzzURkRG3QTN42XuDc_5jzBSj9YMt3e0DMhc.
 787vz2Pg1KyNp8_74UaBlxxY3sou1DYIW3w3_0kKlHhL59aqOJih.OTG97ERbU79cxPXxXlcTr6m
 FCP2JnkwWkUOiQ6JOQrW8.F0skQRXHp7F3qsfEIbz1zyMvkyB12yGi1vF7EKBFAqayrUDIwb5mOL
 MBeVBP20JO80EsxLDOH8DMuYqvWcUBcqXhcZophyxSX18qOs0UsdOXIV9YBQp7cii7C8G25Q1qsq
 rcNSzvX7P9uHdPM2AxbxuFa5A_OqxnxHgMqvQFNB1B6tNUM_q_obKCK.wpWEUvIuJ9eyWOz.2ELR
 KlOdju2LEfIXg5WmY31slDsH1Chg7VasI64N_DJC1cVdRnhEIWI81_nGH4rJ84FnC8i3Or9FquPr
 iINO0agdU0Q--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:17:01 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:17:00 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 02/12] erofs-utils: fuse: support read special file
Date: Sat, 17 Oct 2020 13:16:11 +0800
Message-Id: <20201017051621.7810-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/getattr.c           |  1 +
 fuse/main.c              |  1 +
 fuse/namei.c             | 14 ++++++++++----
 fuse/read.c              | 26 ++++++++++++++++++++++++++
 fuse/read.h              |  1 +
 include/erofs/internal.h |  1 +
 6 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fuse/getattr.c b/fuse/getattr.c
index 542cf35f6989..d2134f486e19 100644
--- a/fuse/getattr.c
+++ b/fuse/getattr.c
@@ -56,6 +56,7 @@ int erofs_getattr(const char *path, struct stat *stbuf)
 	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
 	stbuf->st_uid = le16_to_cpu(v.i_uid);
 	stbuf->st_gid = le16_to_cpu(v.i_gid);
+	stbuf->st_rdev = le32_to_cpu(v.i_rdev);
 	stbuf->st_atime = super.build_time;
 	stbuf->st_mtime = super.build_time;
 	stbuf->st_ctime = super.build_time;
diff --git a/fuse/main.c b/fuse/main.c
index fa9795ef1615..884101374bcf 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -113,6 +113,7 @@ static void signal_handle_sigsegv(int signal)
 }
 
 static struct fuse_operations erofs_ops = {
+	.readlink = erofs_readlink,
 	.getattr = erofs_getattr,
 	.readdir = erofs_readdir,
 	.open = erofs_open,
diff --git a/fuse/namei.c b/fuse/namei.c
index 3503a8d56e15..7ed1168fc14f 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 
 #include "erofs/defs.h"
 #include "logging.h"
@@ -39,6 +40,13 @@ static uint8_t get_path_token_len(const char *path)
 	return len;
 }
 
+static inline dev_t new_decode_dev(u32 dev)
+{
+	unsigned major = (dev & 0xfff00) >> 8;
+	unsigned minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
+	return makedev(major, minor);
+}
+
 int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
 	int ret;
@@ -65,13 +73,11 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	switch (vi->i_mode & S_IFMT) {
 	case S_IFBLK:
 	case S_IFCHR:
-		/* fixme: add special devices support
-		 * vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
-		 */
+		vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
 		break;
 	case S_IFIFO:
 	case S_IFSOCK:
-		/*fixme: vi->i_rdev = 0; */
+		vi->i_rdev = 0;
 		break;
 	case S_IFREG:
 	case S_IFLNK:
diff --git a/fuse/read.c b/fuse/read.c
index ffe976e59a11..3ce5c4f2911e 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -112,3 +112,29 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 		return -EINVAL;
 	}
 }
+
+int erofs_readlink(const char *path, char *buffer, size_t size)
+{
+	int ret;
+	erofs_nid_t nid;
+	size_t lnksz;
+	struct erofs_vnode v;
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	lnksz = min((size_t)v.i_size, size - 1);
+
+	ret = erofs_read(path, buffer, lnksz, 0, NULL);
+	buffer[lnksz] = '\0';
+	if (ret != (int)lnksz)
+		return ret;
+
+	logi("path:%s link=%s size=%llu", path, buffer, lnksz);
+	return 0;
+}
\ No newline at end of file
diff --git a/fuse/read.h b/fuse/read.h
index f2fcebec9d07..89d4b4cd600c 100644
--- a/fuse/read.h
+++ b/fuse/read.h
@@ -12,5 +12,6 @@
 
 int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	    struct fuse_file_info *fi);
+int erofs_readlink(const char *path, char *buffer, size_t size);
 
 #endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index cba3ce4695d4..47ad96d0488c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -153,6 +153,7 @@ struct erofs_vnode {
 	uint16_t i_uid;
 	uint16_t i_gid;
 	uint16_t i_nlink;
+	uint32_t i_rdev;
 
 	/* if file is inline read inline data witch inode */
 	char *idata;
-- 
2.24.0

