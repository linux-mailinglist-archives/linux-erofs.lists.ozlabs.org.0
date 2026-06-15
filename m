Return-Path: <linux-erofs+bounces-3594-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8UmnEIS6L2rtFAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3594-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2026 10:40:36 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F214684A40
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2026 10:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=HvJg78FD;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3594-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3594-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf3V20VqKz2xnK;
	Mon, 15 Jun 2026 18:40:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781512826;
	cv=none; b=e39npI5Br1sOgB9N9XrEGKFr0MTt9w9FaD5G1myJHIUAVdQtxQZay++1epGHEmDZnfgRmvpe/z4vMWXHZoJr58JdS1zC+Puv9OFczo787MHUmP4hFhj9N4mS0QpwUMOu6aGpqG4dHjamVXfhwSA/eppflZtqSRhuosgM49kKn+zCyujbgtz9vQxQAulvDlj49SF+6Q6vXWX6eRKjzmY4w5YeqF7xZ90DT6suG6H2bfSoJlZ0kjoQfSEdxTSqCKcKg1C0wKH7gz7SEwn442kJ+TUoeMFYgLlHi1+vjDFS7L2cVAnkNB/6Cm8TUrlUz/EzDEslH7I1Pyyxd2r3ZEaq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781512826; c=relaxed/relaxed;
	bh=+VEDbZcJY3LGjzJwYn5HFIkHP4CJ3ClwbwiAr04okjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEOyGVZskoGGr6ue/pKbDPI2sToyERAWO56ZkqB0L9FwngwJzwbRoXLMqDOxDCPNKeAAI4cbgsGlzKHtdxOCh6KG7vHgMngE3rgdjK3gVzXjUVKeHYyf3ecvSamegRpaZkUsTaprqoHmN52JBsLMbm36UKU0bAgRDr/uqVvdWmFoLi4iCMLKU2G1dJBPlL0H4k+NLIKG31F7bV+YSP/vm0K3PDsftULeuyVHJ/UnBjAdkVc70gDxlMUE6cXJJZdYwk581oQ/eMjSiy7cqOSi5aVVPdbPbIcs7vqb1PBvq3VAzbBupdfQ6NDk9GXsSFP8PVFD5a1dnh4EkSSYRsQ1rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HvJg78FD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf3Tz505Pz3bqD
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2026 18:40:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781512819; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+VEDbZcJY3LGjzJwYn5HFIkHP4CJ3ClwbwiAr04okjY=;
	b=HvJg78FDmnjxCF8kaWibppR5q43SaBUZLnY60Ol3QFM3lazTE/BG966V9aWay9GRg8wZ6oxMDUJrLUUpiiUf73TQq55+5Jg+G04ywMd1q2neX04NtfPLGDYHt2JAsTIIkw9lKbEs6acQTtO6wIQ/J4goKXsylVBp2gYwDeYvImQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X4s4J.m_1781512817;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4s4J.m_1781512817 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Jun 2026 16:40:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Tristan <TristanInSec@gmail.com>
Subject: [PATCH 3/3] erofs-utils: fsck: fix potential overflow due to u64-to-u32 truncation
Date: Mon, 15 Jun 2026 16:40:11 +0800
Message-ID: <20260615084011.325686-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260615084011.325686-1-hsiangkao@linux.alibaba.com>
References: <20260615084011.325686-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3594-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F214684A40

It seems possible but no reproducible way made into public.

Reported-by: Tristan <TristanInSec@gmail.com>
Closes: https://lore.kernel.org/r/CAA1XrhPMekMqAnRkC-jV9rTsO4LHjzh=kxn6zQKMgBrqfrnp8A@mail.gmail.com/2-u64-to-u32-truncation-overflow.txt
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 87eeb81136ff..fc64e6e263d8 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -513,7 +513,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	bool compressed;
 	erofs_off_t pos = 0;
 	u64 pchunk_len = 0;
-	unsigned int raw_size = 0, buffer_size = 0;
+	u64 raw_size = 0, buffer_size = 0;
 	char *raw = NULL, *buffer = NULL;
 
 	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
-- 
2.43.5


