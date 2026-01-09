Return-Path: <linux-erofs+bounces-1773-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF08D0717A
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 05:14:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnT2406Crz2xFn;
	Fri, 09 Jan 2026 15:14:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767932091;
	cv=none; b=KMgQdovgE9p+TjhAWjaOxjxStE/csQBhsclgn5IIi5gEyu9OKbdF/2K8SfFY2kRI/Syme4FTK5Cu08a2Z02teGe77EnPtDWc1Gktf7680+zltI8g+GY/VrSzCyLjzawdtHlVqPnb56XsfbG55FoFR0eZ9fBaTYIdO+ySsjqjYq8LFr/mRZCfB6gmyX9GT0DiCqbihBtkZ/a/T2xPq3ou9Ga8UDDiBt+Q41nW82dIam48ycMUuYg+sBAtAvWUq9+kvqScH4K9ySP5H2x+/YhBVRpukjvDugjUZmAKItxoYaxADXGmo8J6jITy75IHS8/WyCqCad5tGAZ2ROrPd11v2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767932091; c=relaxed/relaxed;
	bh=iM1EQOWk10tfOtHbs5XgPo/8c8dlckisHXqmtFdCBtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYIqOtZwFFbtlBfdlI30/F2z8WhllqdxNIpUp6NZC1py1VHDbvWuc1Wtgmoyx5dqjS9DOI3xVSIZgL+p0ot63fW3VB8arm1fhxwMJUrx8/OmgVvzSrTIWGx9Drau6ws28hR02KnsLNK6AQ3Bez49GTfIs5PZZuHGaWAy4sWyfgU+r5H9PuKlGMUqazZh16qZIEWAbGJHv+e5NCb813mS9LzsDHZ91naiSwzH5HNegj9Ev1XfF2+oInTwppyv+CRf5SIweAj10oHAJukl07dj8uzwSZ5PQmTOnLtATmYrwRgejF80iaZBrHbvdeJIOqbMU7ORyhz14bEOlJN+EL2OKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mXUR8rqA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mXUR8rqA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnT1v0Npwz2x9M
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 15:14:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767932064; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iM1EQOWk10tfOtHbs5XgPo/8c8dlckisHXqmtFdCBtc=;
	b=mXUR8rqAOhyMmfCOpgU2HMOII9ytYrxJuYULSPsnyH2fPqk9XLjSGOhbmdky55F6QGcBrJYAVvZfNE/0nBJWzezmvrh27pvsHiTAmndwTTv3JGT1SWUyJMtvW2QBP3cGw7lnIqSZPf6SHbznZZhzC2hePbZABjdTZWKOdpWXBJ8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwer5y3_1767932058 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 12:14:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: tar: fix self-hardlink handling
Date: Fri,  9 Jan 2026 12:14:18 +0800
Message-ID: <20260109041418.1047770-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The following tar can contain two header blocks, and the second
header block describes the same file `foo` as a hardlink:

 $ touch foo
 $ tar cf foo.tar foo foo
 $ mkfs.erofs --tar=f foo.erofs foo.tar
 mkfs.erofs 1.8.10
 Segmentation fault (core dumped)

Closes: https://github.com/erofs/erofs-utils/issues/32
Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 8aa90c7dc0d4..d5095169f9ba 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -995,12 +995,6 @@ out_eot:
 			goto out;
 		}
 
-		if (d->type != EROFS_FT_UNKNOWN) {
-			tarerofs_remove_inode(d->inode);
-			erofs_iput(d->inode);
-		}
-		d->inode = NULL;
-
 		d2 = erofs_rebuild_get_dentry(root, eh.link, tar->aufs,
 					      &dumb, &dumb, false);
 		if (IS_ERR(d2)) {
@@ -1011,14 +1005,23 @@ out_eot:
 			ret = -ENOENT;
 			goto out;
 		}
+		if (d == d2) {
+			ret = 0;
+			goto out;
+		}
 		if (S_ISDIR(d2->inode->i_mode)) {
 			ret = -EISDIR;
 			goto out;
 		}
+
 		inode = erofs_igrab(d2->inode);
+		++inode->i_nlink;
+		if (d->type != EROFS_FT_UNKNOWN) {
+			tarerofs_remove_inode(d->inode);
+			erofs_iput(d->inode);
+		}
 		d->inode = inode;
 		d->type = d2->type;
-		++inode->i_nlink;
 		ret = 0;
 		goto out;
 	} else if (d->type != EROFS_FT_UNKNOWN) {
-- 
2.43.5


