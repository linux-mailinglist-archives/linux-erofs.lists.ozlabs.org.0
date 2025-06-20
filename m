Return-Path: <linux-erofs+bounces-477-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A15DEAE1EA8
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Jun 2025 17:31:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bP1fM4qDVz2yFK;
	Sat, 21 Jun 2025 01:31:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750433483;
	cv=none; b=n6r6PBjLjBsAwt/crFDK742SEmK6MQ4yZ/kIIMLIVgmmf645KLshGMGpFsfHVYFgRu6u9/XGWUqoeTYmcdZzIlZ6pMa6Z2lKkaCmwWrgQRMwGAC4XLErZboZjInIH/3k3/2swwO8YFLPVnhAzX02xJgvVpO1BptQENODY8wcV0ETjJcEKoZ2ipLeQ8kzeAIDbrJGMbQE/AqmPW2YA7Nj/7mmqwOqONcmf1e6aVb9Pw2mpIVtHrBRYF3NxtYwStGQmaFNrBFsVw3SnQLf18kBPdVPWel0Q6rTkDLChh93MgSB6DxAA/RVq2eApPxToaIDmagfLwY83I4XNXh4CNnTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750433483; c=relaxed/relaxed;
	bh=4b3junzA/3eGGOZfK804nE/zow3RypRUFyM0P4FTq5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zjw7sWpDI33PpxhYxyK9wEKitNRekwwl1xchOnGk9QVX9c5fvpwlkIdWGKljVMOL6aUyL1Y+1HRahACDZrzvYPNGCEhFwVOrzFY8uj798CBDFp3Tbk1ryJ+LDewI46uWV8D6jfy4fz4XTHe9YHPXG5lBoJx3520fgv7HfeyH8siH6GutrL6kwObtAvLFo5ZluQvERkSuiDIrW6qiOIBC51iObGpqVoYB4vuwszLEa8LKQXT4JgRJWK5OgpMjh+L+ZN/65axE1wwkGHK7k8e519TWADoWOtZCSKFTIKiYzAFjy70f+lU6Tpe1s+aD6AflFzccgdlc2/raQRFZg5gTDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eLr8JIbt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eLr8JIbt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bP1fK0wVdz2y2B
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Jun 2025 01:31:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750433475; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4b3junzA/3eGGOZfK804nE/zow3RypRUFyM0P4FTq5g=;
	b=eLr8JIbtLVZCiTo1W5BG17L1coI4Q7EsQPzCp1xXXxB12mz6toLjKoptSIzysiaDZDds2bU3IzY9XWjK0MFWrjVN67igCU659cBoEZTmJqOCmgM9A1TGxbtTtfSH3xlrl4W7cz53M0SWYigzW4AVUKU3Rp6SALH7GjnCQV0E590=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeLDrbC_1750433469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Jun 2025 23:31:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: remove a superfluous check for encoded extents
Date: Fri, 20 Jun 2025 23:31:08 +0800
Message-ID: <20250620153108.1368029-1-hsiangkao@linux.alibaba.com>
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

It is possible when an inode is split into segments for multi-threaded
compression, and the tail extent of a segment could also be small.

Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 6afcb054780d..0bebc6e3a4d7 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -639,12 +639,6 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		}
 	}
 	map->m_llen = lend - map->m_la;
-	if (!last && map->m_llen < sb->s_blocksize) {
-		erofs_err(sb, "extent too small %llu @ offset %llu of nid %llu",
-			  map->m_llen, map->m_la, vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
 	return 0;
 }
 
-- 
2.43.5


