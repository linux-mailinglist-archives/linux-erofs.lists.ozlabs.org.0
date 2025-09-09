Return-Path: <linux-erofs+bounces-990-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB33B4A3EF
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 09:40:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLbMN6pxWz30Ng;
	Tue,  9 Sep 2025 17:40:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.59
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757403616;
	cv=none; b=C2tQfFMsfY0TrwzrEa85gY16rFcb+y53pKfK2Mwh/OWKGeBAOj2lLns1BIs501KNIh5cy6Gxz4OVkp4i4qELUCKn9fnJDIILZbLLMLLVDv1n/UdBtKO09EY9g/rMNOFpXrSgcG5vYV7kmFKLYcAnQbJeop4Bl7BPurpsBzZcS8I0u0mvai3ed4WWEqgAkr+6+Cb4tIA7ObZ2H5nqnbyMJ1+s+TuFRURAmrmDTrmObkdXTb/5nqWPq5yC5GoQO2lF3KnwJJCw8I6xVbQwbuV+85AnvmuTCUXQGAR2Opi1InMmGaQIU9ZOXgrFrYJTkbiiD+1STA1hmp8TxLTtvQBUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757403616; c=relaxed/relaxed;
	bh=9xvNfBqQOqUWKpBE4u/xP5LmFCfQGdpy0370+qpMcYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YypQJOZYRXWvKVgpUu4NKm7dcHANYX+FyPMbgihGvnBef4AkFNn8H+PVCKdHIXV+2JtjRjKkxjCtjuBRPL7Kl7J+dCd4hcal8pNWd0zakiXQ0vuspD+FP8/8RRlwhFt+iIZbuWo+nlP44ckqoVHKVYckkssin5DkobYni9X8MyKZ6wHCe4lIGVnJDIZ8aFH8ExheZXJ7Np18i9bLKXHu0VGxwLIcPJ5US61HlXDBvXP2Vf8BAstCXd3WnUTIC5rQaRf7nFnkTq6IX8KPsHjSmLI8dsbuwnlE/+H9qJ/qdsHUkvZ+FdQIpBfQZV6bpKlthUelw9bNStvhU5NAMHdt3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.59; helo=out28-59.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.59; helo=out28-59.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-59.mail.aliyun.com (out28-59.mail.aliyun.com [115.124.28.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLbMM6nGXz2yqh
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 17:40:15 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eb0EXKc_1757403608 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 15:40:09 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v2-changed] erofs-utils: mount: fix memory leak in erofs_nbd_get_identifier
Date: Tue,  9 Sep 2025 15:40:08 +0800
Message-ID: <20250909074008.1051-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909065500.75576-1-hudson@cyzhu.com>
References: <20250909065500.75576-1-hudson@cyzhu.com>
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
index b22a729..c52ac3b 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -691,6 +691,8 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
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


