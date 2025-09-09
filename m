Return-Path: <linux-erofs+bounces-985-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A05EB4A2AA
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 08:55:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLZMd4dpjz30FR;
	Tue,  9 Sep 2025 16:55:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.67
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757400925;
	cv=none; b=c1Ena2pClA/bfgDDqISoWJnw63ahfcSWHtLzj9aDzxDFiXjanqAO3GyS/rXUDUFBjP9kVjZC9lQ6uwVAiVBiSWz59IdYQF63xxS1M6h2gbrvXGUJGCBQHhOgm6Z20zSxPkQfLsy8zd/aP+JE7CF+Cl/WVaLrrxHQScLC/+FZw3LTlZyRH8KMzCPLuWmAjyZVJQEaL36DR1X0CSX9URWBr3TWaBHsnowroQFsD/7Zto/ERwVQoJ73+5sDYQsXDrBTzY6rlL8K/uzsO3IeCII9M0YumixTxl65PGxsLxQH1/aT9bjidyShaOF6zCMnWKGY7ejv96OD6nGJofrxgu2JWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757400925; c=relaxed/relaxed;
	bh=gYWNLFbyAkah+EMARIpjltSsP+1LN77D4CgweHdpi8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J17YwhJZNYPXNllgbqtIBam5IKshk8u8ha3Kxx0QVjX/lDHwUMmYT3NgmBlvRZc4yAm0hdwbOQgHDmpVH4pGJNlwmwtAot0wA8hg5H4T99aBpgrIYcmVHmUI18KwYl8zqNVbJ5YUFSsXMOE1rQ2H7YYtip54uMSiv3bYmceynimi4cihXkoUzyWvP6zM+AyV2kmZNrqDOQkOeyW2N//blHJeVEYqKGBnTd/Oi4jymTyeQ+kB/1sFezaoo9A1o0a4nsVztrB3T01eMkKFtJUvL5wDU9V+nG6s2MbFOA008XXLHrbPjMf3KeGO+W4/c74hRyXQIECsbyixBjQxR6Peuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.67; helo=out28-67.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.67; helo=out28-67.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-67.mail.aliyun.com (out28-67.mail.aliyun.com [115.124.28.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLZMc2Kzdz2xMV
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 16:55:21 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eb-qwFy_1757400913 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 14:55:13 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils:mount: fix memory leak in erofs_nbd_get_identifier
Date: Tue,  9 Sep 2025 14:55:00 +0800
Message-ID: <20250909065500.75576-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

The erofs_nbd_get_identifier() function returns dynamically allocated
memory via getline(), but the caller in erofsmount_nbd() was not
freeing this memory, causing a 120-byte memory leak.

Add proper memory cleanup by calling free(id) when the identifier
is not an error pointer.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mount/main.c b/mount/main.c
index 0daf232..d4f1cda 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -741,6 +741,8 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 			if (err)
 				erofs_warn("failed to turn on autoclear for nbd%d: %s",
 					   num, erofs_strerror(err));
+			if (!IS_ERR(id))
+				free(id);
 		}
 	}
 	return err;
-- 
2.51.0


