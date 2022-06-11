Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E754733D
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 11:29:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKsx32lMqz3bjX
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 19:29:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L5xirZSv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L5xirZSv;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKsx00yYhz3053
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 19:29:40 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3AB98B80E49
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 09:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE2BC34116;
	Sat, 11 Jun 2022 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654939775;
	bh=Qcs1sbVeLL1Uda50vfVxPj+Y3bcLw6pnfwaKSDjmbbo=;
	h=From:To:Cc:Subject:Date:From;
	b=L5xirZSvnumrHlkvZRa1vH+YGNdi0JBCWxB6RzwhAJCCrvvXhiMJEjtFTHkdUUHFS
	 K3t79/iSvWOGZP187BO6waP7wohhoWuc/7jm5sP2uhkVFu02m8uyqQzCP0/zzh6nV6
	 Nt7T5hHej3zeIWZ/DWaaKWaoWwEpPJ7lch8XwplYjJ3sFbJXPZHzpWS/Hu8bu57DZz
	 oTlDrDdfiRGFKt8PIuVDydBB/wuBcYymTK2mam3DmjMQ286No3qpGk6F3RMUyFtKrT
	 vXTeNFeaBzgde+SdRoa3M/VZ/GNyQ8tNq4xswuoOgpz3mFyOIlSb0+NpPclEfhDfpL
	 r6Tpb5jQAN4gQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: support extracting special files
Date: Sat, 11 Jun 2022 17:28:55 +0800
Message-Id: <20220611092855.347106-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Now device special file, named pipe and UNIX domain socket can be
extracted too.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 fsck/main.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 7fc7b6f..5a2f659 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -638,6 +638,44 @@ out:
 	return ret;
 }
 
+static int erofs_extract_special(struct erofs_inode *inode)
+{
+	bool tryagain = true;
+	int ret;
+
+	erofs_dbg("extract special to path: %s", fsckcfg.extract_path);
+
+	/* verify data chunk layout */
+	ret = erofs_verify_inode_data(inode, -1);
+	if (ret)
+		return ret;
+
+again:
+	if (mknod(fsckcfg.extract_path, inode->i_mode, inode->u.i_rdev) < 0) {
+		if (errno == EEXIST && fsckcfg.overwrite && tryagain) {
+			erofs_warn("try to forcely remove file %s",
+				   fsckcfg.extract_path);
+			if (unlink(fsckcfg.extract_path) < 0) {
+				erofs_err("failed to remove: %s",
+					  fsckcfg.extract_path);
+				return -errno;
+			}
+			tryagain = false;
+			goto again;
+		}
+		if (errno == EEXIST || fsckcfg.superuser) {
+			erofs_err("failed to create special file: %s",
+				  fsckcfg.extract_path);
+			ret = -errno;
+		} else {
+			erofs_warn("failed to create special file: %s, skipped",
+				   fsckcfg.extract_path);
+			ret = -ECANCELED;
+		}
+	}
+	return ret;
+}
+
 static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 {
 	int ret;
@@ -698,6 +736,12 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 		case S_IFLNK:
 			ret = erofs_extract_symlink(&inode);
 			break;
+		case S_IFCHR:
+		case S_IFBLK:
+		case S_IFIFO:
+		case S_IFSOCK:
+			ret = erofs_extract_special(&inode);
+			break;
 		default:
 			/* TODO */
 			goto verify;
@@ -707,7 +751,7 @@ verify:
 		/* verify data chunk layout */
 		ret = erofs_verify_inode_data(&inode, -1);
 	}
-	if (ret)
+	if (ret && ret != -ECANCELED)
 		goto out;
 
 	/* XXXX: the dir depth should be restricted in order to avoid loops */
@@ -725,6 +769,8 @@ verify:
 	if (!ret)
 		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
 
+	if (ret == -ECANCELED)
+		ret = 0;
 out:
 	if (ret && ret != -EIO)
 		fsckcfg.corrupted = true;
-- 
2.30.2

