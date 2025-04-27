Return-Path: <linux-erofs+bounces-236-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E6A9DEA1
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 04:16:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZlVYm14dSz2yqv;
	Sun, 27 Apr 2025 12:16:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745720172;
	cv=none; b=N186FQ9yViD5lwEi6mJKXFCZ1QyXv/liY9bF0XbfYNP63ZlCmxGor16P0nvZdfjr0g4q3oRqjyDNr5QarJi4tigCWWzwnaGTxLhy9VAoivn+9ZAZJzZqVYJZE244zbnwHpGOz0OmzMNHUdPu4bXz4M4U51vRLGkW6Dzn2czaiodzDSdMCEbngbjZGSvWjNAWgZaGZqp8GQgaEPYLuqve681cHt6it47yNjixuiXvy1v5tEXFiQ7uyoE7FljgAYkVdj/H/KIJO5o3+nMXI7o5wRCKaHrBtY7UGFn1bjaE28xp6oHn/K96NX9rBuiZxoxpwLZ6/4Yzs3CS3KbGJgT7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745720172; c=relaxed/relaxed;
	bh=OH93uyR+fALz7YLJyaNPJXN5GoFlKGn+pTz44vvExkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QccK5Ee1SDIfZmdBZmqfgKxHE3Q3hHo/FG+cWdW3frQsBfZBaYTaz7pZG3gDO9/942pRJiQCS3WEXIk/HBgOsG882PLVGxc2y2JzCoI1nrd+KUbO7TBQJQ09Z5hySskNtce0SSOnXvhX+4jfIIMGYcYFqVAfFPR9nwm814RsDcO6z2EbwGtmVOvxGKBtN52MoT05bQOilFj7YHVsSrrTJOArMFi2EeGFustCSL+P89dNjwQWRCciIo1yqpOYR3VjbefgR9Xf6k4+goqac6kS1hueTNxQ57GhmNegoNxj9aBvWs1FWTmQdFvyl98uzlDrUW+zg6q1zfHf0Ds4k4tKQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MNlam3z0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MNlam3z0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZlVYh3tG6z2ynh
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 12:16:07 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745720162; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OH93uyR+fALz7YLJyaNPJXN5GoFlKGn+pTz44vvExkY=;
	b=MNlam3z0a4Qa0SPNbwoVy5+SBrzr/EZzHkJ2GD7W/j8zSpmva8CxYQroeJbpqQWqoS8I3xXk3IF8HBg62CCCu5iMi4GUZ/H2JgW1/ZcwvZOe8INkNIDAPMqrZwt1evFiuv1vga9ArXjH2+OohjFUX0R2O0DGIqPfAiqSub/eE+U=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WY77HbA_1745720156 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 27 Apr 2025 10:16:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: fix `--blobdev=X`
Date: Sun, 27 Apr 2025 10:15:55 +0800
Message-ID: <20250427021555.99648-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Create one if the file doesn't exist.

Fixes: b6b741d8daaf ("erofs-utils: lib: get rid of tmpfile()")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index e6386d6..301f46a 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -627,7 +627,8 @@ int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
 		blobfile = erofs_tmpfile();
 		multidev = false;
 	} else {
-		blobfile = open(blobfile_path, O_WRONLY | O_BINARY);
+		blobfile = open(blobfile_path, O_WRONLY | O_CREAT |
+						O_TRUNC | O_BINARY, 0666);
 		multidev = true;
 	}
 	if (blobfile < 0)
-- 
2.43.5


