Return-Path: <linux-erofs+bounces-1459-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EBC95991
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 03:40:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKSmr5Cdsz2ypW;
	Mon, 01 Dec 2025 13:40:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764556812;
	cv=none; b=BGKultUesAqBtminiKrXDtIrrajr6ckuiL0XrpHYT+s2AeTFsYENQsZf95KNZlDDKJUNhvFWGZguKDX09TC6P5nd4o/kjpIvi4nPu7g3XpGCC2L7ElFdNE0mS1WNkfDNx2Oh0hl/tPRx/2VLjA7FD1t923sT4dU9uX2c2ocX4tzcaWf6r5Iz9tx83regwn2X0GTcb2SSzNVpppQl07EXWZaaJYm5WEZDzE2pYqNzJseICLcz90HJsXRPnp3T+Tj2G3St791J1m3lLZWyjcIZbjrCODF6dZrSvJ84WwnTlcp5/eixckh8oEVgGF6mkDiRsyLLj3YUiQNQczL/dLppxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764556812; c=relaxed/relaxed;
	bh=FO8baG8KV35M7Grbg9BLFDK8Hig/pNt0Z2EMffgBSwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ezZ35WamUhJKQUQg1tKlgUgvGq+ekm07NC8A6tAu8Wu7dlK9PllXxH/vlxcMamJpACpWRfpIGThgsw0RNsduKFawrc4MAcd60fSoXALQhHXSJJjPPih9+YfduDxmhJcO29UkdDuiE8d2QJ93kFkH3e7vcll7Qg0SnkBBH6LeDEwWZe4ERuRbyMa/nDpw6RnlMZD3EO6N5AzypPC1U2FovyncN01bwdhCCwNC3X5zgBSXzlW3/QPU1ZGYzdyCze/JO5GJ1CeOde0Vq1RHlt335CqoBKQJwY8yemxkqznv5SC113VV5R28q/sO1xhakUG7QunZG1+mW9kf98nZcH9tnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.57; helo=out28-57.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.57; helo=out28-57.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-57.mail.aliyun.com (out28-57.mail.aliyun.com [115.124.28.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKSmp6R1Lz2yG3
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 13:40:09 +1100 (AEDT)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.fZwP0eH_1764556802 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 10:40:03 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils: add myself to AUTHORS
Date: Mon,  1 Dec 2025 10:39:59 +0800
Message-ID: <20251201023959.6767-1-hudson@cyzhu.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

Since this year, I have been working on erofs-utils mainly on OCI support,
including OCI registry and tarindex+zinfo support, NBD-backed OCI mounting
and recovery, as well as on-demand blob cache and direct-to-fd download.

I’d like to continue contributing to erofs-utils in general, including
new features, bug fixes and reviews.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 AUTHORS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/AUTHORS b/AUTHORS
index bc67a65..c04d068 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -2,6 +2,7 @@ EROFS USERSPACE UTILITIES
 M: Li Guifu <bluce.lee@aliyun.com>
 M: Gao Xiang <xiang@kernel.org>
 M: Huang Jianan <jnhuang95@gmail.com>
+M: Chengyu Zhu <hudsonzhu@tencent.com>
 R: Chao Yu <chao@kernel.org>
 R: Miao Xie <miaoxie@huawei.com>
 R: Fang Wei <fangwei1@huawei.com>
-- 
2.51.0


