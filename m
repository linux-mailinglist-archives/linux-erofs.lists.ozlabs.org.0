Return-Path: <linux-erofs+bounces-2411-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP1FD73Jnmm0XQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2411-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 11:06:53 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B76A1957E1
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 11:06:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLVcS4t9cz3dk2;
	Wed, 25 Feb 2026 21:06:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772014008;
	cv=none; b=J3CAjTB950QCaupwYwbCqjkc8hQXwhGzr6O//lQLcK9Hea9M7WxHAm9C2qFHqkyGkgkjS89IAilUUfnc7lpvacGrfW55YrZMw+TL8doFA7g5oZanTxTef45gxPpVC5p5QZVR4jbdfJcuVIcLQXAgCxDv5gNggY4REwHvrQkGISl57ZFoHGnyv+FQWGwAVcWM5w5a5Gk6ZaXJB8pCsWHcpM1F6jsrh0ux9LgV6F9yC1zZkG6UxUJebmA82EGwO9jD/XHO8r4OOkKS8Bq+9gv6NTlwnl7pcX6Zf3L80vjrNvCiHY3/vrvL0ANdwZhPBZd+fzfIaNXxQLP9LW8nwisTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772014008; c=relaxed/relaxed;
	bh=XryvnHDe8B1zOm9fGK5eUflsFAlPMEDinHKug7U5FOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8L9h9QcTlpAt7M7W4k4qB/3qqM7dzNQqElWqjSiUjKnmlaIOdZhlphOcVlgxdOVicpGCgB/Tl83o7C5dILYLo2P++Z2m7akv8mj5R/Qtiy/2Lte10hPouSws0K+VkIwP7fdd9e+UNGl5ig++e15nODBvOSJKtvanS8naSIhP/+biQ7pD3taqqCwHfU7R3JUCQqxDNo3/QlD7AARFIWALTjw4WH7tR+9uakwXwlvEUa9vRikE9czez6nf4anwD9fnTCV6KfgZGAIibeC6abBOLsV4cs3Y0adJmUrDZHrnqN4yx0GRmDMtq8+VamRvdp9cjMXQMJIicwhweGO4w+ztw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=og1giBsq; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=og1giBsq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLVcP272sz3dhk
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 21:06:42 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XryvnHDe8B1zOm9fGK5eUflsFAlPMEDinHKug7U5FOM=;
	b=og1giBsqlxPXz601GNiDt5b12pza+ef6h9ROdayvRapNayVtfGdpapgixcIfDuLTYy/Uvjun9
	cqnb4GUFAQuXiAEdihGoSTNOXL6GoDjrAU5+nmurSLxcbRrcF5vbthkCrZvaylHyWSAG1Yzm47R
	ABXpoJhCauf3JsxtdE23bGQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fLVVk5wwGzRhTm;
	Wed, 25 Feb 2026 18:01:50 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 06F6B40567;
	Wed, 25 Feb 2026 18:06:37 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 25 Feb
 2026 18:06:36 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhukeqian1@huawei.com>,
	<zhaoyifan28@huawei.com>
Subject: [PATCH v2] erofs-utils: dump: add missing compat features and separate feature display
Date: Wed, 25 Feb 2026 18:06:40 +0800
Message-ID: <20260225100640.554705-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9acfc376-f200-40a0-ab21-87b6221b3b31@linux.alibaba.com>
References: <9acfc376-f200-40a0-ab21-87b6221b3b31@linux.alibaba.com>
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
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-2411-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:wayne.ma@huawei.com,m:zhukeqian1@huawei.com,m:zhaoyifan28@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 3B76A1957E1
X-Rspamd-Action: no action

Add three missing EROFS_FEATURE_COMPAT_* entries to feature_lists:
- EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX
- EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX
- EROFS_FEATURE_COMPAT_ISHARE_XATTRS

Also separate the feature output into two lines:
'Filesystem features(compatible)' and
'Filesystem features(incompatible)' for better readability.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 dump/main.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 8422bb9..9879b6c 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -96,6 +96,9 @@ static struct erofsdump_feature feature_lists[] = {
 	{  true,    0, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
 	{  true,    0, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
 	{  true,    0, EROFS_FEATURE_COMPAT_XATTR_FILTER, "xattr_filter" },
+	{  true,    0, EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX, "shared_ea_in_metabox" },
+	{  true,    0, EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX, "plain_xattr_pfx" },
+	{  true,    0, EROFS_FEATURE_COMPAT_ISHARE_XATTRS, "ishare_xattrs" },
 	{ false, 504U, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "lz4_0padding" },
 	{ false, 513U, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
 	{ false, 513U, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
@@ -675,12 +678,21 @@ static void erofsdump_show_superblock(void)
 			g_sbi.inos | 0ULL);
 	fprintf(stdout, "Filesystem created:                           %s",
 			ctime(&time));
-	fprintf(stdout, "Filesystem features:                          ");
+	fprintf(stdout, "Filesystem features(compatible):                  ");
 	for (i = 0; i < ARRAY_SIZE(feature_lists); i++) {
-		u32 feat = le32_to_cpu(feature_lists[i].compat ?
-				       g_sbi.feature_compat :
-				       g_sbi.feature_incompat);
-		if (feat & feature_lists[i].flag) {
+		if (!feature_lists[i].compat)
+			continue;
+		if (le32_to_cpu(g_sbi.feature_compat) & feature_lists[i].flag) {
+			fprintf(stdout, "%s ", feature_lists[i].name);
+			if (feature_lists[i].lkver > minkver)
+				minkver = feature_lists[i].lkver;
+		}
+	}
+	fprintf(stdout, "\nFilesystem features(incompatible):                ");
+	for (i = 0; i < ARRAY_SIZE(feature_lists); i++) {
+		if (feature_lists[i].compat)
+			continue;
+		if (le32_to_cpu(g_sbi.feature_incompat) & feature_lists[i].flag) {
 			fprintf(stdout, "%s ", feature_lists[i].name);
 			if (feature_lists[i].lkver > minkver)
 				minkver = feature_lists[i].lkver;
-- 
2.47.3


