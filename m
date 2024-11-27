Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEA59DA6A0
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 12:14:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xyxf30nv2z2ypP
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 22:14:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732706041;
	cv=none; b=LKk+t+1zV1iC1wEGbSEsZbqxGgejoLWkX41tsjytM20ZJbTmKefm/G1p62e9PtIv1dNCscfD7kr4aJoDg/MeRyIeOWYUFiioeu5hS/8DelmC8jYi03eDCtjA6N8arSZaWfChOe6TA+FTXTjlREziR0+yLPhVbm7D3u9fYa75JEggWRfE3a7iNENMmRTVpoUhV+L0rt7mD0OpBZrwl5czRZsukuWyaQI/jreaZ2tF89G6RP7IExokSPC7u+QVlHZzksrJGnrzTHLwQj7W/tvlh0JF6Q9pcGx8L6muFpIaZP+Rs9DFJkDyB5u8fxGWoMStMHCjf+bCbR0jYxz1BQ3+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732706041; c=relaxed/relaxed;
	bh=R8/WAanuAfcAY7jjQ74nfPu+42yn1rwDrxJSGaZKu6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDfkqvfO1Rfpc5Ts/WB6L9VGnN8vOPx+4f4wXM4lmLvORmGLFUd3cEkpx+X0fTjc8xUbcQxlNvMrEmD+Q0dZz8BoowL6zJ9YVzlr2m2/JkxwmLvYkGiafcFmshDBmmlNYPQGKJvgQNClxqY9PeE1BOAEQ+lO5HUB1N887IGpOwOBjFq9wUpImYjjq40yDvsfyKtbhnpVQt+uP1AKUyyTDTUsYdTZrRt/FuefvdbaRVKJ4iRbzhU087q31CfI3DUqZQCJuddXZ7csD/6/F+z//LG/Z+tBYVKsBJAXxsnKGheFprmQVSOuOen45UEus8WyRFfQ8H54lpW5+4y0ehxxvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B8Asq6yf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B8Asq6yf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xyxdx4kKJz2xjd
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Nov 2024 22:13:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732706030; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R8/WAanuAfcAY7jjQ74nfPu+42yn1rwDrxJSGaZKu6A=;
	b=B8Asq6yfsIHYqTcKksdRYMxMn88DaAmeZQeuUW7Cudxp3F0ZaFxyeWUiPip7lG2NxbhUTAm2hZSxBY0o+jwtqSPLyc3h2f26mTIIG9f9cX0uXGtLvtffTPPxQe6JvkfmNB3scnfjZit+QTs/H54D3hC8FQYUb3DXMdKeiAiVnx8=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WKMPRcn_1732706028 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 19:13:48 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: rebuild: set the appropriate `dev` field for dirs
Date: Wed, 27 Nov 2024 19:13:46 +0800
Message-ID: <20241127111346.49290-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Currently, setting a default `dev` value (i.e., 0) for directories
during parsing tar files can lead to the following error:

<E> erofs: bogus i_mode (0) @ nid 0
<E> erofs: failed to read inode @ 0

Consider the following incremental build scenario, where the path
"dir1/dir2" is currently being parsed in tarerofs_parse_tar() and
the directory "dir1" has never appeared before. erofs_rebuild_get_dentry()
will call erofs_rebuild_mkdir() to allocate a new inode for "dir1",
with its `dev` field set to 0 by default.

During the dump tree phase, since `dir1->dev` matches `sbi->dev` (both are 0),
erofs_rebuild_load_basedir() will be called to read the contents of directory
"dir1" from the disk. However, since there is no information for the new directory
"dir1" on the disk, the above error occurs.

This patch resolves the above issue by setting the appropriate value
for the directory's `dev` field during the tar file parsing phase.

Fixes: f64d9d02576b ("erofs-utils: introduce incremental builds")
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Implement in a more concise manner.
v1: https://lore.kernel.org/all/20241127092856.4106149-2-hongzhen@linux.alibaba.com/
---
 lib/rebuild.c | 1 +
 lib/tar.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index b37823e48858..3e58f00e0b2c 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -46,6 +46,7 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	inode->i_gid = getgid();
 	inode->i_mtime = inode->sbi->build_time;
 	inode->i_mtime_nsec = inode->sbi->build_time_nsec;
+	inode->dev = dir->dev;
 	erofs_init_empty_dir(inode);
 
 	d = erofs_d_alloc(dir, s);
diff --git a/lib/tar.c b/lib/tar.c
index 990c6cb1b372..0dd990ea077d 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -667,6 +667,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 	unsigned int j, csum, cksum;
 	int ckksum, ret, rem;
 
+	root->dev = tar->dev;
 	if (eh.path)
 		eh.path = strdup(eh.path);
 	if (eh.link)
-- 
2.43.5

