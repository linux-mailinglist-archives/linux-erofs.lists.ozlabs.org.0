Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1361094E06E
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Aug 2024 10:10:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uo+AOaD6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WhVh934CHz2yGh
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Aug 2024 18:10:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uo+AOaD6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WhVh02W6Gz2xXL
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Aug 2024 18:10:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723363817; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mPkHNjRyg+HGiitC/TNRieKRUbeYbLh7yHbQOFSZU9Y=;
	b=uo+AOaD6d+M7slmMEz8Zf4CpgIF7NDR7u5F4ClmF9X87ZhXO/DPV8oU5myXrOF5y/5rgnMA9NBjfKwqpxAY38tDtq20ZrAMMFUwHo4Ds5iMZHTg1ZE3X1Fmq3Zt0W+Xo6iGGdV9ZokmQGLgyCsigd9PQd702GtCH7tQ3d1DoVO4=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCUexhS_1723363815)
          by smtp.aliyun-inc.com;
          Sun, 11 Aug 2024 16:10:16 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: add support for symlink file in erofs_ilookup()
Date: Sun, 11 Aug 2024 16:09:57 +0800
Message-ID: <20240811080957.2179279-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

When the `path` contains symbolic links, erofs_ilookup() does not
function properly. This adds support for symlink files.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/namei.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/namei.c b/lib/namei.c
index 6f35ee6..dce2991 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -195,6 +195,22 @@ struct nameidata {
 	unsigned int	ftype;
 };
 
+static int link_path_walk(const char *name, struct nameidata *nd);
+
+static int step_into_link(struct nameidata *nd, struct erofs_inode *vi)
+{
+	char buf[EROFS_MAX_BLOCK_SIZE];
+	int err;
+
+	if (vi->i_size > EROFS_MAX_BLOCK_SIZE)
+		return -EINVAL;
+	memset(buf, 0, sizeof(buf));
+	err = erofs_pread(vi, buf, vi->i_size, 0);
+	if (err)
+		return err;
+	return link_path_walk(buf, nd);
+}
+
 int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 {
 	erofs_nid_t nid = nd->nid;
@@ -233,6 +249,11 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 			return PTR_ERR(de);
 
 		if (de) {
+			vi.nid = de->nid;
+			ret = erofs_read_inode_from_disk(&vi);
+			if (S_ISLNK(vi.i_mode)) {
+				return step_into_link(nd, &vi);
+			}
 			nd->nid = le64_to_cpu(de->nid);
 			return 0;
 		}
@@ -243,7 +264,8 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 
 static int link_path_walk(const char *name, struct nameidata *nd)
 {
-	nd->nid = nd->sbi->root_nid;
+	if (*name == '/')
+		nd->nid = nd->sbi->root_nid;
 
 	while (*name == '/')
 		name++;
@@ -274,6 +296,7 @@ int erofs_ilookup(const char *path, struct erofs_inode *vi)
 	int ret;
 	struct nameidata nd = { .sbi = vi->sbi };
 
+	nd.nid = nd.sbi->root_nid;
 	ret = link_path_walk(path, &nd);
 	if (ret)
 		return ret;
-- 
2.43.5

