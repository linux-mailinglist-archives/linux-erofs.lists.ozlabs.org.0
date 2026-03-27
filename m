Return-Path: <linux-erofs+bounces-3048-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CnPOW0Exmk5FQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3048-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2026 05:15:41 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F204F33F0DD
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2026 05:15:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhnPQ4GcKz2yVt;
	Fri, 27 Mar 2026 15:15:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774584938;
	cv=none; b=OR/SUtk63KythF/hIDNSHibuBlFGF/KV4FMb/vUSXrAOA2PqAdp1zJ0jTs7qko1am3U80hNoNuSNz4C7qJGjVqglXMYsgPGYwd+W9uaQdlwrWYhvN5U8J61Bo6ttFa/dEjdOu12KzYLjMjC+Z3SQ394ujE41lUy6Keqa1k0loWCPx4OoXlAJo+80keYtYvKbTl098GmIzH4xxnanrJMzOtvk0ZoHVkdZJWH/Yu2Erb34VJDRX9RfToGoNgzDvapkc6ZiQgIktg8LvG2CYFU9v3sZThL6KozUMFRvdXOGs0Qp83lXWHEs4ft8QtvWGCirLeCRQFq3o+MjKD5RA0z01g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774584938; c=relaxed/relaxed;
	bh=SaMl55v3P256PUqGIsXKeLgVv4g7GfDpRpgEKt5uNj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKJLCkkIPNu4q4LugN+n1sRVVm/BzKuY+g9pC7ZwYJxIaC903E3kV2kyV4slx6I+ndPzqbjyFx+QrZxn/Z8tDllCpC8lsgniUt+dCCmFZznekNFwv0x6e5XQjpZUaHussHvMWGpZOAWIs1s3k9K74GEijOJwJH55BlJTOJHLBhi+VbwJ8OP5YBbtkuJXhCWPhjG85xpeWTivm5mqrefBMxYFWfQzbZzy3Gn+gJ+RH/ypw7/x7IPh33JDRmImTOklSvh7PsQItkNUWuvQJJ6qfa5ZSkeOw4yMwiWR2RAR5cuf5nndtdcgJBJr6347tlm0hTAbOuzTSe6au1ZZpW3PMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Vn15nyDw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Vn15nyDw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhnPN3418z2xmX
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 15:15:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774584931; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SaMl55v3P256PUqGIsXKeLgVv4g7GfDpRpgEKt5uNj4=;
	b=Vn15nyDwW9kRAhkXBkbW2vAuqykj3aWRRfq7o7mG3WwBjqJbmzaBdc5OHwLlxXWRxD/QMH2WueLWXiyz/YSt5HZ0dEo1n06ZQxbcLuVElo2zEhj4C0kJ2KqHVSE+IXak8SnDT8W1aOOa3d+NCc4ZSedxDsFEGUbfpwyxaEz71y0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X.n37JY_1774584925;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.n37JY_1774584925 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 12:15:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com
Subject: [PATCH 6.6.y] erofs: fix "BUG: Bad page state in z_erofs_do_read_page"
Date: Fri, 27 Mar 2026 12:15:24 +0800
Message-ID: <20260327041524.1087336-1-hsiangkao@linux.alibaba.com>
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
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3048-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,b6353e35ae2bab997538];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: F204F33F0DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It's actually a stable-only issue from backporting 9e2f9d34dd12
("erofs: handle overlapped pclusters out of crafted images properly")

We missed to update `oldpage` after `pcl->compressed_bvecs[nr].page`
is updated, so that the following cmpxchg() will fail; the original
upstream commit doesn't behave like this due to new features and
refactoring.

This backport issue only impacts some specific crafted images and
normal filesystems won't be impacted at all.

Fixes: 1bf7e414cac3 ("erofs: handle overlapped pclusters out of crafted images properly") # 6.6.y
Closes: https://syzkaller.appspot.com/bug?extid=b6353e35ae2bab997538
Reported-and-tested-by: syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com [1]
[1] https://lore.kernel.org/r/69c3b299.a70a0220.234938.004b.GAE@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c1f802ecc47b..97764612fc76 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1500,6 +1500,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	lock_page(page);
 	if (likely(page->mapping == mc)) {
 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
+		oldpage = page;
 
 		/*
 		 * The cached folio is still in managed cache but without
-- 
2.43.5


