Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD2A2A8D0
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 13:51:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpcR63Ttbz3cXf
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 23:50:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738846254;
	cv=none; b=PsP3hMOOOD2ghA+pQQuMwVOxh/hjVVeT8dKVL5sWjHwd9ZNLYsNxsEIBeVmHTwNwRPlmr7CpgsWfOMEo4+KV/rUdVVB2al3oqWNnP923sTFOukatWb2qKR9PS1evoP61SQixt9yBR5BbMwB7Spi8SRpdKgkDII80UVhJujhMf+FtpQEryrN+koGElKJbS7qrkLyApRItXcEYHzDHqvCLxTN0UnbdD6RtpqY6/bWz+IiSqT3WtNwGxmvJWmGO6a1+58f4VUF+rpcbQP/QpMh4aft3UNmShHuicu7XLS8DzzxWBgt4x0CClPf30WjeKnPBYelHkPMzJTo+Xwu8FAR80w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738846254; c=relaxed/relaxed;
	bh=Srb9gXJ2K5BqkNlcwBekX7Euw3UBA8gwKrssbcC0T7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxjaOItlwi8wDwMKPA0f7Cl5jfS6eyL8cmTIza9o6pjXOTVH7yYUnZD+LfWle9Ra+dWiVWPBw00Yn9AWRtlcbxflRo5pq6RVZfCiugrrWHMMYY9X+dU6RCvh0N89CWDst0H9UcjCkJkWn8BLK+QaPy3JcIlfZj28fljeeuqhXnldifk5md6125AqFGQLMsiLwQHHCddw/mCCsHexIRwQ16jFuawGuWlVS8kH9lHUH5XrFdGcL8vvMt+/8kcZCmnZHYSVu7ZcCk3PQbCmxOxyZZVYDqUJQdE3K6h+siRtzS8x/Za46gV/5leg3TCUzv6AiHz8osAjlyi7ej89sxAeag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SGgzMn8t; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SGgzMn8t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpcR1210Pz30Gf
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Feb 2025 23:50:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738846249; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Srb9gXJ2K5BqkNlcwBekX7Euw3UBA8gwKrssbcC0T7w=;
	b=SGgzMn8tuPAkqZ09EyjxZKwWOl4GHJbXenk4vfFa/y5cW6y+ErXo5HNCYN4wmXQ0bRktbNA6lfRPYrcp4YKuWRIfYN3lGN8+Pb4GHkHjjW125gHiyV3cBbtqL+0OVAAmVQQK0kfYlxVJ3Sdf7Zhd0fFo95HXqvBlTH5vj/204Hs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOwMl6K_1738846247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 20:50:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 6/9] erofs-utils: lib: handle NONHEAD !delta[1] lclusters gracefully
Date: Thu,  6 Feb 2025 20:50:31 +0800
Message-ID: <20250206125034.1462966-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
References: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Source kernel commit: 0bc8061ffc733a0a246b8689b2d32a3e9204f43c
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index c79424b..c48eba4 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -232,7 +232,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	erofs_blk_t eblk;
 	int err;
 
-	if (lcn >= totalidx)
+	if (lcn >= totalidx || vi->z_logical_clusterbits > 14)
 		return -EINVAL;
 
 	m->lcn = lcn;
@@ -416,7 +416,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
 	int err;
 
-	do {
+	while (1) {
 		/* handle the last EOF pcluster (no next HEAD lcluster) */
 		if ((lcn << lclusterbits) >= vi->i_size) {
 			map->m_llen = vi->i_size - map->m_la;
@@ -428,14 +428,16 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return err;
 
 		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-			DBG_BUGON(!m->delta[1] &&
-				  m->clusterofs != 1 << lclusterbits);
+			/* work around invalid d1 generated by pre-1.0 mkfs */
+			if (__erofs_unlikely(!m->delta[1])) {
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
 			erofs_err("unknown type %u @ lcn %llu of nid %llu",
@@ -445,8 +447,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
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

