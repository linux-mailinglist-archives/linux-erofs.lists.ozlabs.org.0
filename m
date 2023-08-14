Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395177B039
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 05:43:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPKwx66Z8z3bnN
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 13:42:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPKwp0QJSz2ydW
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 13:42:47 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vpelyog_1691984560;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vpelyog_1691984560)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 11:42:41 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 01/13] erofs-utils: fix overriding of i_rdev for special device
Date: Mon, 14 Aug 2023 11:42:27 +0800
Message-Id: <20230814034239.54660-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
References: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In index mode for tarerofs, tarerofs_write_chunk_indexes() is still called
even for files with 0 i_size, and inode->u.chunkformat is initialized
accordingly.  This will make the previously set inode->u.i_rdev be
overridden as u.chunkformat and u.i_rdev are reused in one union.

To tidy up the code of writing file, extract two helpers writing file in
index and non-index mode.  Also fix the missing erofs_iput() when
tarerofs_write_chunkes() fails.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/tar.c | 77 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 54ee33f..42590d2 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -359,6 +359,44 @@ void tarerofs_remove_inode(struct erofs_inode *inode)
 	--inode->i_parent->i_nlink;
 }
 
+static int tarerofs_write_file_data(struct erofs_inode *inode,
+				    struct erofs_tarfile *tar)
+{
+	unsigned int j, rem;
+	char buf[65536];
+
+	if (!inode->i_tmpfile) {
+		inode->i_tmpfile = tmpfile();
+		if (!inode->i_tmpfile)
+			return -ENOSPC;
+	}
+
+	for (j = inode->i_size; j; ) {
+		rem = min_t(unsigned int, sizeof(buf), j);
+
+		if (erofs_read_from_fd(tar->fd, buf, rem) != rem ||
+		    fwrite(buf, rem, 1, inode->i_tmpfile) != 1)
+			return -EIO;
+		j -= rem;
+	}
+	fseek(inode->i_tmpfile, 0, SEEK_SET);
+	inode->with_tmpfile = true;
+	return 0;
+}
+
+static int tarerofs_write_file_index(struct erofs_inode *inode,
+		struct erofs_tarfile *tar, erofs_off_t data_offset)
+{
+	int ret;
+
+	ret = tarerofs_write_chunkes(inode, data_offset);
+	if (ret)
+		return ret;
+	if (erofs_lskip(tar->fd, inode->i_size))
+		return -EIO;
+	return 0;
+}
+
 int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 {
 	char path[PATH_MAX];
@@ -672,41 +710,16 @@ new_inode:
 			inode->i_size = strlen(eh.link);
 			inode->i_link = malloc(inode->i_size + 1);
 			memcpy(inode->i_link, eh.link, inode->i_size + 1);
-		} else if (tar->index_mode) {
-			ret = tarerofs_write_chunkes(inode, data_offset);
-			if (ret)
-				goto out;
-			if (erofs_lskip(tar->fd, inode->i_size)) {
+		} else if (inode->i_size) {
+			if (tar->index_mode)
+				ret = tarerofs_write_file_index(inode, tar,
+								data_offset);
+			else
+				ret = tarerofs_write_file_data(inode, tar);
+			if (ret) {
 				erofs_iput(inode);
-				ret = -EIO;
 				goto out;
 			}
-		} else {
-			char buf[65536];
-
-			if (!inode->i_tmpfile) {
-				inode->i_tmpfile = tmpfile();
-
-				if (!inode->i_tmpfile) {
-					erofs_iput(inode);
-					ret = -ENOSPC;
-					goto out;
-				}
-			}
-
-			for (j = inode->i_size; j; ) {
-				rem = min_t(int, sizeof(buf), j);
-
-				if (erofs_read_from_fd(tar->fd, buf, rem) != rem ||
-				    fwrite(buf, rem, 1, inode->i_tmpfile) != 1) {
-					erofs_iput(inode);
-					ret = -EIO;
-					goto out;
-				}
-				j -= rem;
-			}
-			fseek(inode->i_tmpfile, 0, SEEK_SET);
-			inode->with_tmpfile = true;
 		}
 		inode->i_nlink++;
 		ret = 0;
-- 
2.19.1.6.gb485710b

