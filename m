Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E8BA11E96
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:51:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1Tj081cz3bq0
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:51:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934663;
	cv=none; b=jJCdRg6J1iyt9UAJFduHYnDoQvbhtyt3ZnA5c5ybuiVgIAkk8HeG0cbdiz6TEBMJ5j6I2wOFMog9AapeoUhaGC4TMi5TS/MoDBvYeRSqeAVvRJc8dfMjBP2be8CInK35g9XI3CIeF1yhuy0mxodXVlyU+H37KuEYcRcla0taHrEvnu4yKyvqU0scAUyQiyNPHcDsZTzcRlArKAbrQTYZpYJBd3GgXiHZYOY/1p3cqKRN5mRQ8zR00QZNWjrFdWLiP7bgklCJsSlLwhPZrnL0C5AAE1gDFQdURHIYFwLT9WvP1+vHMDX7vahQqpcZ6zt7SC70cIJ9VIPCiJuEld6EIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934663; c=relaxed/relaxed;
	bh=3Rjkjm8Jq5H24ooOjCp1xVDbTvFXijBEgngWFzUKsAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bABd8bd04QOwetoOhV5xcDNadZsmRoo6gfz6LO5Xb8Pe8CnFxabPFtHi46cnrW2wdUuh3Wsh8KIIJkV4yRC3+ewrEi3+zbEClvTrLf2bS5nek5H1Z0O605czdW2CvKoCkE5zOW9vqErdWGdScywhWLPKsSY6ClwdU2B94TxXE8l8pEAZNSjtSFoyn94PC4z9Ksa8eAQh/5coAhKl4kbyLfrn5FEh4H3a9sV1flMFWX0dOGX9eAODkM6RdPx2e8jW9IuaA48TuPq5ZLj7JupZ5mPDp83GGZMj3lKfHVRg0C4f7uxgruyK8X/jU3++uo/nlic3/YEgiLTXQ7UTssihDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M5Rpryfx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M5Rpryfx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1Tf1yjsz301N
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:51:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736934658; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3Rjkjm8Jq5H24ooOjCp1xVDbTvFXijBEgngWFzUKsAM=;
	b=M5RpryfxIq5nfoTY7Ar4eipS2c9tOJLx5IRHYCZeOVkSWijcxTiR135iomDH9ZP5dgIiXj2AXL8RZ5hGEjBRPsSosmXRP35Xp8goME29J8VzwIsi/02fw0upXNV8UAtZL3nYar9St+3BAIFODDAavqEfY0HNsbfe9gkEUXnyTkU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNi9tts_1736934655 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 17:50:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] erofs: handle NONHEAD !delta[1] lclusters gracefully
Date: Wed, 15 Jan 2025 17:50:48 +0800
Message-ID: <20250115095048.2845612-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250115095048.2845612-1-hsiangkao@linux.alibaba.com>
References: <20250115095048.2845612-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 0bc8061ffc733a0a246b8689b2d32a3e9204f43c upstream.

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
Tested-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Fixes: d95ae5e25326 ("erofs: add support for the full decompressed length")
Fixes: 001b8ccd0650 ("erofs: fix compact 4B support for 16k block size")
CVE: CVE-2024-53234
Link: https://lore.kernel.org/r/20241115173651.3339514-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 046eaaf16dad..2cd70cf4c8b2 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -256,7 +256,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int amortizedshift;
 	erofs_off_t pos;
 
-	if (lcn >= totalidx)
+	if (lcn >= totalidx || vi->z_logical_clusterbits > 14)
 		return -EINVAL;
 
 	m->lcn = lcn;
@@ -441,7 +441,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
 	int err;
 
-	do {
+	while (1) {
 		/* handle the last EOF pcluster (no next HEAD lcluster) */
 		if ((lcn << lclusterbits) >= inode->i_size) {
 			map->m_llen = inode->i_size - map->m_la;
@@ -453,14 +453,16 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
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
@@ -469,8 +471,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
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

