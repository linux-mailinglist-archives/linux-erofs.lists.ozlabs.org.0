Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 649C496F0B5
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 11:59:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0WsQ5BZ0z308V
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 19:59:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725616743;
	cv=none; b=T1c/57qZcMVoHbwrGaljIv7fZwgoay+ZJXMiQp09ZR/ZvikMsL/LaXNigKzPaBkTItFsmEwKB7EqSlp9cryb8zRUNB9Vx0Q8+68ePfug2BfJv8JSgsD6uKGk8HnJ1yynqByACb4qKStL1viFuMiXlJlBIfyi0jpGNDoeAKLXO/Jw6v3khYvINyX3hUldSzGsSJBZ9Y5lj9OQwH/e/HKJm0njDQ9Nm177HoWEsj3sqb/r7Xxeiu9DHjiAhCb/9tZg3WcTlU4nQOuJ3u2KaDkJhKbM45uxizRoxwdq/O50t6F52JSxu0wAJZbHt5Q6nI3n8HBKHa9dXPZK1qgN1BtPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725616743; c=relaxed/relaxed;
	bh=Q1YvaaclSesc1rFAx4gts4DpumDjli9sayZmRpipXuQ=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=g5CqdznXF4lynUEfu9wwCfFwN/tdWDsCtqpeHZQS1g/gFk91K+DmNgPXv4q6HA5UGU4NmY5/9RzLbrzWbP130qXRPhHRKWTZU99jdsjHuDDsu1Y41gmIUSMJiHYX/klM4p9L4bgJ3RHSPuP7aYLdWAe60+cPy+9GJ9jrQEbiqddY4sL8IhxdWwgMgsvr0youwRSlz8kkIs/Cu+ASFflwpnv8I2S8XV5qcyLrXdG8T/M3q2vF5iBNNeg6BJQGZ73marYY3rILYjcY8rpeeh/FNyVB6GOk/deFbay0tqRVzX1FxjoElnpPNdLxettqzoUwb3vR2mMOreYJn2IGhXjaig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fCYHDPjN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fCYHDPjN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0WsL57lyz305S
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 19:59:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725616736; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q1YvaaclSesc1rFAx4gts4DpumDjli9sayZmRpipXuQ=;
	b=fCYHDPjNTrJ8aJKEMjY4rTkxbKgkehfMRTIfsfG0E/t+DcqGsSHR599QrDJCchKgvivLrdT3QWL7H/zOdXntLtMWFXOzS2VWByQl5JD6SXyJuK9Q8LXcZXxssF/qEMuDq1vdgmV2YErlVyAf5rL2dupzuLq8eHQD6HJaKu+FdrA=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEP8hCH_1725616734)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 17:58:55 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 1/2] erofs-utils: lib: expose erofs_match_prefix()
Date: Fri,  6 Sep 2024 17:58:52 +0800
Message-ID: <20240906095853.3167228-1-hongzhen@linux.alibaba.com>
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

Prepare for the feature of exporting extended attributes for
`fsck.erofs`.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Expose erofs_match_prefix() directly instead of introducing another helper function.
v1: https://lore.kernel.org/all/20240906083849.3090392-1-hongzhen@linux.alibaba.com/
---
 include/erofs/xattr.h |  3 +++
 lib/xattr.c           | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 7643611..e89172e 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -61,6 +61,9 @@ void erofs_clear_opaque_xattr(struct erofs_inode *inode);
 int erofs_set_origin_xattr(struct erofs_inode *inode);
 int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
+bool erofs_match_prefix(const char *key, unsigned int *index,
+			unsigned int *len);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/xattr.c b/lib/xattr.c
index 9f31f2d..375a658 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -138,8 +138,8 @@ struct ea_type_node {
 static LIST_HEAD(ea_name_prefixes);
 static unsigned int ea_prefix_count;
 
-static bool match_prefix(const char *key, unsigned int *index,
-			 unsigned int *len)
+bool erofs_match_prefix(const char *key, unsigned int *index,
+			unsigned int *len)
 {
 	struct xattr_prefix *p;
 
@@ -196,7 +196,7 @@ static struct xattr_item *get_xattritem(char *kvbuf, unsigned int len[2])
 	if (!item)
 		return ERR_PTR(-ENOMEM);
 
-	if (!match_prefix(kvbuf, &item->base_index, &item->prefix_len)) {
+	if (!erofs_match_prefix(kvbuf, &item->base_index, &item->prefix_len)) {
 		free(item);
 		return ERR_PTR(-ENODATA);
 	}
@@ -1425,7 +1425,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (ret)
 		return ret;
 
-	if (!match_prefix(name, &prefix, &prefixlen))
+	if (!erofs_match_prefix(name, &prefix, &prefixlen))
 		return -ENODATA;
 
 	it.it.sbi = vi->sbi;
@@ -1600,7 +1600,8 @@ int erofs_xattr_insert_name_prefix(const char *prefix)
 	if (!tnode)
 		return -ENOMEM;
 
-	if (!match_prefix(prefix, &tnode->base_index, &tnode->base_len)) {
+	if (!erofs_match_prefix(prefix, &tnode->base_index,
+				&tnode->base_len)) {
 		free(tnode);
 		return -ENODATA;
 	}
-- 
2.43.5

