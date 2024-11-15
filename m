Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E89CF316
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 18:37:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xqkjx0STnz3bW0
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Nov 2024 04:37:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731692243;
	cv=none; b=Wvv+CCw/IlvexHMDk+JswN+6BShAEhMeHFO55F1KsX7mlc5astyBFPrQWRY3gxwG9qEZa9O0e2Hsd/Vf0kcNjZlGtS7SFf3ukXV889wD++IGpDenJcjU6/DJnOs2IUNTHH/2utX0eC58lBzV2Oit5f9LpiCX64DBUmJIacItOjjjKE+PEKpVH30fXeCmRRmMvXnZw8RzzBtErnvY3aYJtbSShgbiZx5OKKBhAUUaYsAIN06CQHtDhSREN783goSXU47wFKckvtq5aw7RntYK2EW7IHGyqIU+T2mrGVaJzorV4VUZ3IHnSZJH31y1XmKwyE0AGuC5RE++ggvouUfJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731692243; c=relaxed/relaxed;
	bh=0C4zvkjgOBhm5nZYv4qVK0pKEHqWTMIfQl4q5rV5u+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWPM3FFMQKEULnhGuXNEntFTWvQcKWytw50Ccfvet+yRS+G8NGtXx5iqbGCFHbkbMHEW6/6rr7tQxDGtfTo0fFz5K6z5wDk4mV1F1H67dU5bLjOzypVeCsFYDll7lPyOxCdnhclfRKDO4yB/HanTHzhALNd/4lHkfzRsNs7ZDpBy5R/9Dh9XoBj6d5PMCa0gFABCKCBL98Q//UxwqVwlQ47zyPyDe7CRR4Lg1Iejv4GqE7Cu/4GLtUJzmf9iYtsKcIUEwvsfvi5u7JN/4Yyjo9ze3aLjJ9c0Xgvqn4qTrReD1z4T1Mag3Ltrue1IAIVIL5JAwNDiOps9KfoQIoaGJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y9FL03uf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y9FL03uf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xqkjq45l8z2yGY
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Nov 2024 04:37:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731692231; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0C4zvkjgOBhm5nZYv4qVK0pKEHqWTMIfQl4q5rV5u+o=;
	b=Y9FL03uf5p2gy4KYuU/xlHFm2ofclQh5eIy92udWTDnPcEFpWDm4mDfxd1i1fOPPPx8TFearCCuZBHDD28GxOOFYWKpAOY3caamLzMyu32eoXV7W/a2XWBIubRTqkMfGJn9bTKAwdGROrRhe7kzR359m2POGGygdC9EXmETxG6A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJUJogH_1731692222 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 16 Nov 2024 01:37:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: handle NONHEAD !delta[1] lclusters gracefully
Date: Sat, 16 Nov 2024 01:36:51 +0800
Message-ID: <20241115173651.3339514-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

syzbot reported a WARNING in iomap_iter_done:
 iomap_fiemap+0x73b/0x9b0 fs/iomap/fiemap.c:80
 ioctl_fiemap fs/ioctl.c:220 [inline]

Generally, NONHEAD lclusters won't have delta[1]==0, except for crafted
images and filesystems created by pre-1.0 mkfs versions.

Previously, it would immediately bail out if delta[1]==0, which led to
inadequate decompressed lengths (thus FIEMAP is impacted).  Treat it as
delta[1]=1 to work around these legacy mkfs versions.

`lclusterbits > 14` is illegal for compact indexes, error out too.

Reported-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/67373c0c.050a0220.2a2fcc.0079.GAE@google.com
Fixes: d95ae5e25326 ("erofs: add support for the full decompressed length")
Fixes: 001b8ccd0650 ("erofs: fix compact 4B support for 16k block size")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a076cca1f547..4535f2f0a014 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -219,7 +219,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	unsigned int amortizedshift;
 	erofs_off_t pos;
 
-	if (lcn >= totalidx)
+	if (lcn >= totalidx || vi->z_logical_clusterbits > 14)
 		return -EINVAL;
 
 	m->lcn = lcn;
@@ -390,7 +390,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
 	int err;
 
-	do {
+	while (1) {
 		/* handle the last EOF pcluster (no next HEAD lcluster) */
 		if ((lcn << lclusterbits) >= inode->i_size) {
 			map->m_llen = inode->i_size - map->m_la;
@@ -402,14 +402,16 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return err;
 
 		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-			DBG_BUGON(!m->delta[1] &&
-				  m->clusterofs != 1 << lclusterbits);
+			/* work around invalid d1 generated by pre-1.0 mkfs */
+			if (unlikely(!m->delta[1])) {
+				m->delta[1] = 1;
+				DBG_BUGON(1);
+			}
 		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
 			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
 			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
-			/* go on until the next HEAD lcluster */
 			if (lcn != headlcn)
-				break;
+				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
 		} else {
 			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
@@ -418,8 +420,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return -EOPNOTSUPP;
 		}
 		lcn += m->delta[1];
-	} while (m->delta[1]);
-
+	}
 	map->m_llen = (lcn << lclusterbits) + m->clusterofs - map->m_la;
 	return 0;
 }
-- 
2.43.5

