Return-Path: <linux-erofs+bounces-2478-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHqwBt1JpmleNgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2478-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 03:39:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AB1E8217
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 03:39:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ0PP0nnMz2xpk;
	Tue, 03 Mar 2026 13:39:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772505561;
	cv=none; b=CEIaGK7HpeylF1dAHJcGf7OweU8OzAmboUWXMw5iXP9elTyY8k0s0cD+AEyNWeAWok7V9g3LrlEAMR1KOHO1A3mGeXaY1awC+MaCbaImBP2M/bC86b+pceGD/l80qSx9jvqC3AwcuYnT/t1CvQu8eYu1EgKivA3dYnndvaPZqDAAF0y2zuZdNsyNrzkzT5YB8TvdCZIg6iHjhvai+9XnePHr+dqOL12rchOgV7nP0VXBDXwOV7TwWlJGO/YgUJE0ip46BcmWNnjHf7v/djmLtd3Fqmjp53yarGkXLTGsTpNHGqyukVubepgOeI6IUJvyLNmLB/RAqVLj4Q0QqCMHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772505561; c=relaxed/relaxed;
	bh=5UKT+75PhxqOOVNuycccQLRXqyU2OrdjwEmJHiFXYsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKhi40QkHWSvhItZetK99uJQhUtU5NiDdc+yTTyMDGAkMi8pcBYJbWrdaiowg4QGIzjps60VuzdNAFawPv8bD1cVGUf1Z1/6xJ2lx1vRExbLKDXkRFJfDNJzexV37IBZ/z4I7jAPacEbSzaceY7ZXiHwb2WVAUbDPNg22zVQbOO4pBVzay+KyiCH8SSURHqm3wqQdQazNg2dEISNFy14JIfzwGguq9HHMsTN8XXt5ZSPFVhNW9WaEFQonrE23EWWg9lvb7UaSPLTc313ba8zlYOWNCy3/yU22EhbrIu+DQNkIfEyuS3TG9z23YW1L/S1HeK5t55LGa9O7IZAG3c+2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KaUZzJ0I; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lishixian8@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KaUZzJ0I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lishixian8@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 48912 seconds by postgrey-1.37 at boromir; Tue, 03 Mar 2026 13:39:18 AEDT
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ0PL1jxkz2xRq
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 13:39:17 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5UKT+75PhxqOOVNuycccQLRXqyU2OrdjwEmJHiFXYsQ=;
	b=KaUZzJ0IchWcup5A7tiSa5QGrXjmohSB2peLZkE8TjjG+iblZXzSSWWE3cIV0GITsj8ORJB+j
	68hAUPVsOd4zoBN3NSEdLMPqlbLZIwjUuXNW+njECqokTNW9LRtvwlLGsUCeaQhM+rRXJVT2dFW
	psG5bDIgUe17Xu0bVzoaSXg=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fQ0HS4LTnz1T4M2;
	Tue,  3 Mar 2026 10:34:12 +0800 (CST)
Received: from kwepemp100012.china.huawei.com (unknown [7.202.195.77])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B5C140561;
	Tue,  3 Mar 2026 10:39:12 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemp100012.china.huawei.com
 (7.202.195.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 3 Mar
 2026 10:39:11 +0800
From: lishixian <lishixian8@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<zhaoyifan28@huawei.com>, <lishixian8@huawei.com>
Subject: [PATCH v2] erofs-utils: lib: fix xattr crash in rebuild path when source has xattr
Date: Tue, 3 Mar 2026 10:39:11 +0800
Message-ID: <20260303023911.792454-1-lishixian8@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302130356.769479-1-lishixian8@huawei.com>
References: <20260302130356.769479-1-lishixian8@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemp100012.china.huawei.com (7.202.195.77)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 306AB1E8217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2478-lists,linux-erofs=lfdr.de];
	TO_DN_NONE(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lishixian8@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid,qq.com:email]
X-Rspamd-Action: no action

When rebuilding from source EROFS images, erofs_read_xattrs_from_disk()
is called for inodes that have xattr. At that point inode->sbi points to
the source image's sbi, which is opened read-only and never gets
erofs_xattr_init(), so sbi->xamgr is NULL. get_xattritem(sbi) then
dereferences xamgr and crashes with SIGSEGV.

Fix by using the build target's xamgr when initializing src's sbi.

Reported-by: Yixiao Chen <489679970@qq.com>
Fixes: https://github.com/erofs/erofs-utils/issues/42
Signed-off-by: lishixian <lishixian8@huawei.com>
Reviewed-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mkfs/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index b84d1b4..58c18f9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1735,7 +1735,9 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	}
 
 	list_for_each_entry(src, &rebuild_src_list, list) {
+		src->xamgr = g_sbi.xamgr;
 		ret = erofs_rebuild_load_tree(root, src, datamode);
+		src->xamgr = NULL;
 		if (ret) {
 			erofs_err("failed to load %s", src->devname);
 			return ret;
-- 
2.47.3


