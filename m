Return-Path: <linux-erofs+bounces-464-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4FADE72C
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Jun 2025 11:39:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMdwq2mxNz2xRt;
	Wed, 18 Jun 2025 19:39:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750239547;
	cv=none; b=dEViFstYZDzPkN3odSWedPTD1V6aa77ZKdY+7UIPxw44jyXxSnHs588Tog5xWhuz/Z/I8+m9EwIKsE2furQSSIMHqp6qil0p++iH+vis8NhVBP3vOV0WS3cd0XlnkzW6Ua4SBs0XK61Tz0SNlY1YAn8C7OwDXA4/oNhKUHC494L2SbXu9SCkitAM0rq6soRoEE5WHiddsdrqtg7cAXGtYtswQAahaDvnPmU2vJJMEeBwsnp6Zq218kdDMleGzLbJfjUxIC5VJ1JUCZwIiB/jirmd0TkCBZffhUU1Mo53If0pk4I3xw2G1doUJyDo9X3zDVzbjH6kB71pSYMoSigWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750239547; c=relaxed/relaxed;
	bh=GmNh8hSu/VmA74JbYevTN3tz/CEXCjXGffronY/7hsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FF7WZiDf3qPszj21XEa8r75zVJKLbe2zB7ItFdAJOXvbSuJMDL9XOoYcRZdzEYMc7lEbQZGrLLgnwNaeN2apEXYj5c5YTSzjwmcgAIE0viWabqNUqYT4IeFRxdwsEWt/IbAIU57oP38GZfo2dn2Mu3PPF5MUg0dSr06QzQbAByWTpJ5hCZ0+MVCR13WS+aKsNKEbHrzlR4rl+D1M9zH8AEW1lfa1dSyloN2O0iplm/94hy4E1v4qFceBw+sxPTxMFpUwf7bb3el/Cpj1O3HN0X2I8WJfYZWzEMGnlO4OjjvJtzK2upYBcAjh8z+admJAbXVr8byRtLXTKyxWM6Pt6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KLSdO95x; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KLSdO95x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMdwm5gzyz2xKN
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Jun 2025 19:39:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750239538; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GmNh8hSu/VmA74JbYevTN3tz/CEXCjXGffronY/7hsA=;
	b=KLSdO95xM0zDWCsxDTU7qsjnlIXGuRRikprU/ca42ftzvmtD2bz0t5MZeW5OXRRASGyheHE/Sv9xpeKtgonES0dkI+h+8FEIvXJBwBK86SXs0QEBMrQcMSapsd9JDumZ1BSEg7MwvvESYwlXm6EjW0DmMxTGgSvLSGkKH8oQh1g=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeDDsIj_1750239533 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Jun 2025 17:38:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix NULL dereference
Date: Wed, 18 Jun 2025 17:38:52 +0800
Message-ID: <20250618093852.1251605-1-hsiangkao@linux.alibaba.com>
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

Coverity-id: 555136
Fixes: 84bae6acdbee ("erofs-utils: lib: keep full data until the fragment is committed")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fragments.c b/lib/fragments.c
index d63995e..0784a82 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -311,7 +311,7 @@ int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
 out:
 	if (onheap)
 		free(memblock);
-	else
+	else if (memblock)
 		munmap(memblock, inode->i_size);
 	return rc;
 }
-- 
2.43.5


