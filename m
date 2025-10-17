Return-Path: <linux-erofs+bounces-1197-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3406BE6DFF
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 09:05:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnwpC6lLWz2yqh;
	Fri, 17 Oct 2025 18:05:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760684755;
	cv=none; b=lijKo8Ylj1F65t4CrFmDpNGgY8+LB5lcX0LZEsq4SFCvBZKEML4egdmAGRKJHe9l6R4rUjKqXaAISQp8ZwXNMfrcfxzlZDD+We7QaxK89LAGr7I/Hs3k0ho4TrATzpKL+mZQT+Sq2e+e+9Kl4tBQGIZ4oC0nobKpsTINV98Eb7UWq9numvuOiKoGXegA28XwkNrp+RF0Svcn5dYx0M1GYhqlfHSzWNcluP1qXgsNv2fCaDVnJlWQoSpowKi+FPw3dF1yshXtXjQ/c/Fr2/m0UCYMpJQMcxipvT4wfJCvTWVcYe6BCLKKd9cl6aI1zAu14Xob63q7Dt/rfaLcjszqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760684755; c=relaxed/relaxed;
	bh=M7lDlpIyKY1H3VYmkPTYXMTYJIOdRidmY94vSP/ywNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Or80mhOu+PyzzSabHiVG7QtS474sgKqUqWA4GPhFZwE2mAZpRFAn4BL6pm41neNhwQUTxHV81YUcbw2g+hJwgYCOyi0Rfhdpigv5AIwDqtJk76Jt0kzKkf1343KeqtZYQCOC8Jxb+3hwzxoCybjZHU4pspqUU7npvteyza5tMhKgH3xipxyc+EINLiXLr9XGw7ZhUqD4o1+j03Q1q2u0lr5F0E4TZE8Zcr+NkqSsyoLlaiNFJCQMPwFXW3YC31c+mPMUWuLwF5G2KwmGa8oXLFDXO6PfJxyYvMPk9uAoufMuLTDEyx1c+LiS+vG6mFfWCXoSs2C73imiQeUX/HJr5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w2MXtr7L; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w2MXtr7L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnwp955zsz2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 18:05:51 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760684747; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M7lDlpIyKY1H3VYmkPTYXMTYJIOdRidmY94vSP/ywNA=;
	b=w2MXtr7LmtOqci2ONxEVB/Nu773IYz7FAjV64Pu6d5BfQ5c4ejycXkCGqaGRRkOJBZkj6oCkjUe8zSx8Y64WPGpRe410EnCC9SKFWeYhx16+KjxC7/JQbsH2hP9gBYE3NyEMAg6UkqzhpU24bK6y1JqNG/ZSQ60fjGG+cBwDYy4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqOynU3_1760684745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 15:05:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: consolidate z_erofs_extent_lookback()
Date: Fri, 17 Oct 2025 15:05:39 +0800
Message-ID: <20251017070539.901367-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251017070539.901367-1-hsiangkao@linux.alibaba.com>
References: <20251017070539.901367-1-hsiangkao@linux.alibaba.com>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The initial m.delta[0] also needs to be checked against zero.

In addition, also drop the redundant logic that errors out for
lcn == 0 / m.delta[0] == 1 case.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 6aca228cd2a5..a8ce531f4f19 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -272,20 +272,19 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		unsigned long lcn = m->lcn - lookback_distance;
 		int err;
 
+		if (!lookback_distance)
+			break;
+
 		err = z_erofs_load_lcluster_from_disk(m, lcn, false);
 		if (err)
 			return err;
-
 		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
-			if (!lookback_distance)
-				break;
 			continue;
-		} else {
-			m->headtype = m->type;
-			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
-			return 0;
 		}
+		m->headtype = m->type;
+		m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
+		return 0;
 	}
 	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
 		  lookback_distance, m->lcn, vi->nid);
@@ -435,13 +434,6 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			end = inode->i_size;
 	} else {
 		if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-			/* m.lcn should be >= 1 if endoff < m.clusterofs */
-			if (!m.lcn) {
-				erofs_err(sb, "invalid logical cluster 0 at nid %llu",
-					  vi->nid);
-				err = -EFSCORRUPTED;
-				goto unmap_out;
-			}
 			end = (m.lcn << lclusterbits) | m.clusterofs;
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
 			m.delta[0] = 1;
-- 
2.43.5


