Return-Path: <linux-erofs+bounces-1088-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F1B98231
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Sep 2025 05:28:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWj490jjrz302b;
	Wed, 24 Sep 2025 13:28:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758684521;
	cv=none; b=EBvd8Xx+oYG/985VCxyz8hwYVnKUInXbJUNh9INJTVrrj86bSrU3s3Ogmem9e3gTmS0ES+QrjStLhV4QMK2h8jHp5xI1rqGQenNIjftbXfm5L1/tNIexaWNxy7IkaYBkI3jH94deOaMii6nMJvSp5Y9sFhnfIM31ekup2Blan0IYXQY3LhOGCRNzHV+6nYCTk7++3tmFVvRdnOdyFKymFBUXEdo0cXpR/thsh3Mn/QUFtjxX7SlDn92I3qnC2wToSP0AmxiXuVw3Gsxrpm1nm6kkQJv3ZhLrZFitv3tjh5LG/i0Gqqhv2Te9osoPer+ay0uwrWkzn/vGbjPfiI6A6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758684521; c=relaxed/relaxed;
	bh=XyAFB3WArWSNB/CYfgIoegXyVO5beOL4xews09LfXLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FuIGcN5ZWZeUREcXhRtpqTjIL2bsEmgDcolQlQUn64rLsfnx7N/y6KJeMIm7vyMYcr2VKgGxvG3OfbEhPB6XDdm9EIN81zIKW0ddyfpfBTBcVFwvu9QbT6Tk+jpWCtjbD0Ka4liPTwg5Bw5z6PxWRQGswSy032jKgXwGSVq9FxCsfLdki484OCjDkBXY9GIZgS38SOssNz11bjNaCLXSwtXWZurT1BqzCCx0IOnFfvYjEq+x8bus84flGi7bpp0xaETlHVX5nj6+/CSpr/EzdZRIoBxsuCByRiPcbs5vcyCfT6lii1oZxi7og/kjARc6UZKXmTThYlJTsBu1HK4Z5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GSzqBnyu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GSzqBnyu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWj471Lxsz301Y
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Sep 2025 13:28:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758684513; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XyAFB3WArWSNB/CYfgIoegXyVO5beOL4xews09LfXLg=;
	b=GSzqBnyuVvH0K/D0Sk3wS75ZLW1mU22qShbgcoXmOk0r3M1lH8dT7jRWLf7XUZPM6S9jRdHn1/MI6B38JdWJwafS1RtYNmXflBpaQeilcXLw81HZgGNxjQLFg9SKwnjte/qt++YbQWTJck3+TTy2EcABc7GhoVU/ewgSLDTLNh8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wohs6I0_1758684507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Sep 2025 11:28:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: drop redundant sanity check for ztailpacking inline
Date: Wed, 24 Sep 2025 11:28:26 +0800
Message-ID: <20250924032826.3410404-1-hsiangkao@linux.alibaba.com>
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

It is already performed in z_erofs_map_blocks_fo().

Also align the error message with that used for the uncompressed
inline layout.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 3 ---
 fs/erofs/zmap.c  | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 625b8ae8f67f..bc80cfe482f7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -823,9 +823,6 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 			}
 			rcu_read_unlock();
 		}
-	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
 	}
 
 	if (pcl) {
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 798223e6da9c..e5581dbeb4c2 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -462,8 +462,8 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
 		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
-			erofs_err(sb, "invalid tail-packing pclustersize %llu",
-				  map->m_plen);
+			erofs_err(sb, "ztailpacking inline data across blocks @ nid %llu",
+				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
 		}
-- 
2.43.5


