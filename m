Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F8F458738
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Nov 2021 00:49:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hy6Ys0shPz2yV7
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Nov 2021 10:49:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OCLNfkaK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OCLNfkaK; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hy6Ym4vlgz2x9j
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Nov 2021 10:49:00 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76E0160D42;
 Sun, 21 Nov 2021 23:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637538535;
 bh=sfTrremcQB46WwKnDkXfy9oZyLl835U4GU8V0z/kCL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OCLNfkaKMA1g8nHgP6eEc3QQSNepzE63kKw2rMsREoy+DnaQS8h+U/lW3XZh5GEg+
 +igRyWJgP0SSD6DUbDsGA/z9yTUyQtrENIiqSrHsH2Z8KpBkzoZ5XDCwo+YKiF3044
 rWDtcMJVGiG79AyU/NDq+G8BF7X5kOg9xDNiRJuLpVVVYiwfS60SG8HGEWTlHcMVbl
 sNYVhY9L0Cy4WR2XUYLqBUyO4zUcVTGCXNV4wCJnbyJ72OY8b8ILyiq5qna9YDD/Lr
 gFp5wKH/X4pmtAQSXF9zg0sPhB28qr2j+piJFBZRk4sHCmzcTVUVDiw1yAmtoo0OIO
 h8KnODWEp4XPQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, David Michael <fedora.dm0@gmail.com>,
 Guo Xuenan <guoxuenan@huawei.com>
Subject: [PATCH] erofs-utils: dump: fix de->nid issues
Date: Mon, 22 Nov 2021 07:48:48 +0800
Message-Id: <20211121234848.12663-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87tug5jggx.fsf@gmail.com>
References: <87tug5jggx.fsf@gmail.com>
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
Cc: Wang Qi <mpiglet@outlook.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As David Michael reported, "
    In file included from main.c:11:
    main.c: In function 'erofs_checkdirent':
    ../include/erofs/print.h:68:25: error: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__le64' {aka 'long unsigned int'} [-Werror=format=]
       68 |                         "<E> " PR_FMT_FUNC_LINE(fmt),   \
          |                         ^~~~~~
    main.c:264:17: note: in expansion of macro 'erofs_err'
      264 |                 erofs_err("invalid file type %llu", de->nid);
          |                 ^~~~~~~~~
    main.c: In function 'erofs_read_dirent':
    ../include/erofs/print.h:68:25: error: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__le64' {aka 'long unsigned int'} [-Werror=format=]
       68 |                         "<E> " PR_FMT_FUNC_LINE(fmt),   \
          |                         ^~~~~~
    main.c:303:25: note: in expansion of macro 'erofs_err'
      303 |                         erofs_err("parse dir nid %llu error occurred\n",
          |                         ^~~~~~~~~
    cc1: all warnings being treated as errors
"

Also there are many de->nid lacking of endianness handling.
Should fix them together.

Reported-by: David Michael <fedora.dm0@gmail.com>
Fixes: cf8be8a4352a ("erofs-utils: dump: add feature for collecting filesystem statistics")
Cc: Wang Qi <mpiglet@outlook.com>
Cc: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
Hi David,
Thanks for your report! Please help apply this patch instead.

Hi Xuenan,
Do you have some time cleaning up this part of code? that seems
quite messy to me..

Thanks,
Gao Xiang

 dump/main.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index b7560eca1080..f85903b059d2 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -242,11 +242,12 @@ static inline int erofs_checkdirent(struct erofs_dirent *de,
 {
 	int dname_len;
 	unsigned int nameoff = le16_to_cpu(de->nameoff);
+	erofs_nid_t nid = le64_to_cpu(de->nid);
 
 	if (nameoff < sizeof(struct erofs_dirent) ||
 			nameoff >= PAGE_SIZE) {
 		erofs_err("invalid de[0].nameoff %u @ nid %llu",
-				nameoff, de->nid | 0ULL);
+				nameoff, nid | 0ULL);
 		return -EFSCORRUPTED;
 	}
 
@@ -255,13 +256,12 @@ static inline int erofs_checkdirent(struct erofs_dirent *de,
 	/* a corrupted entry is found */
 	if (nameoff + dname_len > maxsize ||
 			dname_len > EROFS_NAME_LEN) {
-		erofs_err("bogus dirent @ nid %llu",
-				le64_to_cpu(de->nid) | 0ULL);
+		erofs_err("bogus dirent @ nid %llu", nid | 0ULL);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
 	if (de->file_type >= EROFS_FT_MAX) {
-		erofs_err("invalid file type %llu", de->nid);
+		erofs_err("invalid file type %llu", nid | 0ULL);
 		return -EFSCORRUPTED;
 	}
 	return dname_len;
@@ -273,7 +273,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 {
 	int err;
 	erofs_off_t occupied_size = 0;
-	struct erofs_inode inode = { .nid = de->nid };
+	struct erofs_inode inode = { .nid = le64_to_cpu(de->nid) };
 
 	stats.files++;
 	stats.file_category_stat[de->file_type]++;
@@ -296,12 +296,12 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 		update_file_size_statatics(occupied_size, inode.i_size);
 	}
 
-	if ((de->file_type == EROFS_FT_DIR)
-			&& de->nid != nid && de->nid != parent_nid) {
-		err = erofs_read_dir(de->nid, nid);
+	if (de->file_type == EROFS_FT_DIR && inode.nid != nid &&
+	    inode.nid != parent_nid) {
+		err = erofs_read_dir(inode.nid, nid);
 		if (err) {
 			erofs_err("parse dir nid %llu error occurred\n",
-					de->nid);
+				  inode.nid | 0ULL);
 			return err;
 		}
 	}
@@ -338,7 +338,8 @@ static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
 			int ret;
 
 			/* skip "." and ".." dentry */
-			if (de->nid == nid || de->nid == parent_nid) {
+			if (le64_to_cpu(de->nid) == nid ||
+			    le64_to_cpu(de->nid) == parent_nid) {
 				de++;
 				continue;
 			}
@@ -399,18 +400,18 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
 			if (len < 0)
 				return len;
 
-			if (de->nid == target) {
+			if (le64_to_cpu(de->nid) == target) {
 				memcpy(path + pos, dname, len);
 				path[pos + len] = '\0';
 				return 0;
 			}
 
 			if (de->file_type == EROFS_FT_DIR &&
-					de->nid != parent_nid &&
-					de->nid != nid) {
+			    le64_to_cpu(de->nid) != parent_nid &&
+			    le64_to_cpu(de->nid) != nid) {
 				memcpy(path + pos, dname, len);
-				err = erofs_get_pathname(de->nid, nid,
-						target, path, pos + len);
+				err = erofs_get_pathname(le64_to_cpu(de->nid),
+						nid, target, path, pos + len);
 				if (!err)
 					return 0;
 				memset(path + pos, 0, len);
-- 
2.20.1

