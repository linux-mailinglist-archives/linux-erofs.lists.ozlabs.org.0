Return-Path: <linux-erofs+bounces-1504-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A75CC67C7
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Dec 2025 09:07:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWRH41TlTz2yjx;
	Wed, 17 Dec 2025 19:07:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765958848;
	cv=none; b=ifAPfSYiSp9wM/MfLn7LN5NPvoh7tFw5NE0VqLQe4BgRB4ne56KTbaWEdBvuoGwkS2KqIJX4K3nzfp08jd8bMhgfjDuZnMLtN7rJG3m9Pfm/hykJ8nLNz7iN19A97J8sX/U3YNo5Sv+PY18CQ1525EHZv87n2Y9EPwpTVzf3PgsIEqcKaFmBdY/gs25hVzPzU5XdhG8qI6onlSD1FfCnFR9StIH46Tdt7Lsub2oU2X84bligPyIsDvOt06+dt41vHJyQXRBlUP/CsCaMXw2upvwpiPG0wx7tzyOTEmeVHlQKGaEnl9l1CZRdCQZJ+YoPD5M5fAEWJJ1NT0xqLkxuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765958848; c=relaxed/relaxed;
	bh=Ati3t8fOsKCPy3csG1hviicKqv5Gxc32BD+bgo6eNxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=icazDkQpcU/xqHKl4plEB7Ghf3rgcbqc+3GMjxQVJC5o10HcwozI/EFp1v9LzhgJNNPXJV8fUOgQDBSgclSkaWs3X9DppVZJihHP/6RCrFtqUUF8vJYvagW+csf9L1lPMvFJVJNOAf9N1/GVFjAcwmkBXz5siypex7uQa7JYsGiAWMcPLuJcg5LVLilxdPkdYeL5OSwcsclRwdx3D/ExTXl0/fmZitpvH5e3WORTAqTTxjGI73Pj8Y0mFP//ideZp/yw3Lb/NORt3W8hqznYeSCI995W1EEW8bZYjGO74g89jBvpzgmY2JERC28zd8CBvpyzKdcqQj3xAPqkyykqfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QUFqY8Zw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QUFqY8Zw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWRH14RFhz2yjw
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Dec 2025 19:07:23 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765958837; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=Ati3t8fOsKCPy3csG1hviicKqv5Gxc32BD+bgo6eNxg=;
	b=QUFqY8Zw2Y5Be/TSXsWLMux91kREv1A/HnO6NQV+3mfjgpDGwfaS+zq1bl9pWtjLi9S9qeD6e6zDsXc+Gjvyat03V2kB/xU7vFtPK6W5mofwfxrNFxzLk7n92aDflh/mIadiya1VDTxH+4yxxyJ7+VIeYbi5VUdFe2pY16rGAyk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wv2ekyQ_1765958832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 16:07:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mount: fix type mismatches causing compilation errors
Date: Wed, 17 Dec 2025 16:07:11 +0800
Message-ID: <20251217080711.1304576-1-hsiangkao@linux.alibaba.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In file included from ../include/erofs/config.h:15,
                 from main.c:14:
main.c: In function ‘erofsmount_tarindex_pread’:
../include/erofs/defs.h:148:24: error: comparison of distinct pointer types lacks a cast [-Werror]
  148 |         (void) (&_min1 == &_min2);              \
      |                        ^~
main.c:380:30: note: in expansion of macro ‘min’
  380 |                 index_part = min(count, tp->tarindex_size - offset);
      |                              ^~~

Fixes: da1fb2864fbb ("erofs-utils: mount: add support for standard OCI targz blob access")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mount/main.c b/mount/main.c
index e25134caf10a..de39727d6eed 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -376,7 +376,7 @@ static ssize_t erofsmount_tarindex_pread(struct erofs_vfile *vf, void *buf,
 		remote_offset = offset - tp->tarindex_size;
 		index_part = 0;
 	} else {
-		index_part = min(count, tp->tarindex_size - offset);
+		index_part = min_t(u64, count, tp->tarindex_size - offset);
 		remote_offset = 0;
 	}
 	tardata_part = count - index_part;
-- 
2.43.5


