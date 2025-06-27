Return-Path: <linux-erofs+bounces-498-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A528AEB22A
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Jun 2025 11:09:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bT8rx6zSkz3069;
	Fri, 27 Jun 2025 19:09:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751015393;
	cv=none; b=Co7OqewnBjQdwfNSc4c4aWRbiK0MNBv/h7Cm7348xtOMcHWeHbryEVkCSSGJGT9ubheE7RvK4vQQBTjcoZYZgCF7CPwdy34TglLpUvy4s3K3qZWcJmWMi5s2eRQb2Xptm4Ep/9c5xwEBMZWPQPjOk4/Pi3kOcpuHohkg+Ywdfj5ueKvRQnUn3hpltlqPxOitsRR5xQxhzdgxBE5YODEfiSls+ou0P1xNkKG8ArV2cc62VTKimvg3eHDvz3+4jnsUYZm+QwoB/vhGzrTAxsgv2rEMD7f8ETdH3ZlFkEESR86iH+v/MHbVNy/EK04+D90m42nHOQku6FqWqMLNFOfnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751015393; c=relaxed/relaxed;
	bh=3heKpN/dGzd+W4LMmiLBrLk5rjyCGIbGvoSJYjR4SVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpxYJ0zcd16qVr0OXjC4JGiRj278bLuNUEyM9CZu36yM17LyE4kUvRH6dwE02Ilx0JO+aJ3Nyt1oIg4GCt/M4Tw2HQxFii13BHfCJgH+q1AYlwIwLVolr5Hih5isNSKz2A1UZ7LSbE+w/bGd5gQxn6kwUWpP1tYLlBXX4LZR7AbvcNoiJleAD0pr2FCnCff3WxUHuvP00UdMAy1gLXZEmn+4qhyTVgo8kliUtRPgKPc+Jb/+vpgLl0MgPhf4j0glqSi1AKOAAQmYbEh5RYexB16gFiw4IUMOCUhxQelEEb8wKH2f3MDF8Is9EJvjObtCAmqCSqtrdBgBIIurTLsEiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dyzzPvvX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dyzzPvvX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bT8rv6GBMz2xsW
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Jun 2025 19:09:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751015386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3heKpN/dGzd+W4LMmiLBrLk5rjyCGIbGvoSJYjR4SVg=;
	b=dyzzPvvXQBRsU8ZNv2v4veTjpPo/4f74r6WgEYw3ePBn/2ClkDROIq/SY3M6V91IUTVciQ7Rfs9ZopfYxpnGvnCW3d0cPNkj3zoAToFhA8PqjxqTn3wQ9IEWZKEljz5WUJPmPKV6P02iLGyvlYxaPJAWppP/e6oL8ZKIIbmRY7Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WfRQe2F_1751015379 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Jun 2025 17:09:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: don't force extended inodes for $SOURCE_DATE_EPOCH
Date: Fri, 27 Jun 2025 17:09:38 +0800
Message-ID: <20250627090938.1965634-1-hsiangkao@linux.alibaba.com>
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

After commit 59f826ca013f ("erofs-utils: mkfs: use extended inodes when
ctime is set"), there is no longer a need to set FORCE_INODE_EXTENDED.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 14ea6ff2..c266f617 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1124,11 +1124,6 @@ int parse_source_date_epoch(void)
 			  source_date_epoch);
 		return -EINVAL;
 	}
-
-	if (cfg.c_force_inodeversion != FORCE_INODE_EXTENDED)
-		erofs_info("SOURCE_DATE_EPOCH is set, forcely generate extended inodes instead");
-
-	cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
 	cfg.c_unix_timestamp = epoch;
 	cfg.c_timeinherit = TIMESTAMP_CLAMPING;
 	return 0;
-- 
2.43.5


