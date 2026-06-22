Return-Path: <linux-erofs+bounces-3697-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aEiKJySvOGq3fwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3697-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 05:42:28 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F96AC511
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 05:42:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="q/UpHLIl";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3697-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3697-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkDXs4JdZz2yVZ;
	Mon, 22 Jun 2026 13:42:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782099741;
	cv=none; b=GcPNuhZY1+kQEue979/VEuqyBWaWqn1FtLaKbsVikvV6d/zy5frM7tGwN390Xz+TgHljHkVsaCO5sysBpxN8JQgy0tBQBin1i6h+0REmd9alxLHo6zHI/iGR1z3derhWrWNrDNkFGKHwRoGTEprdRpPo8Igi01IcGjUdbUyiQZ19igGgrKp6lN+dE4TsW+7JmZQmD+lE4NLzCrDSQUKlNoy+wJGPRiVBmAhASdTikCHKOTz3JiF+p+i1UYIE3/aLb6igipo2Kdf5iBh44gDWHA9B43xL5df4A5WuoVz7Cum4AdJrpehlskn99EB99x91HfhEgx4BZ/hp19Yt56nN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782099741; c=relaxed/relaxed;
	bh=84uoVePJdRamBj+BE+XwaFAV2iuGe/ezkbCVLB53sb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgePVp7UJ51K2fgyjDt7s6Me3GFjBCh8yWDpZnr3nxhH56ISxvPq3M4R6gRNwqn59EUvN4KlJWImtSmzg8aoSi2ruOLy0BpDyY+4yM3NgPiglm9zgXuwS5UTSLstrnWEHuyyWWzdi3Zax+j4PRXvxcBB6xjc/3dtKHzGYzthMqNGhKLLga7Dcb+ZQQqzbQQDFDV79kbOvjKGGR9Iu4jUPEJRFdboCuMPuxdcNRPQ9ctFdLsewd/t8zv4nlQ5Rg9VQd4WmgZVfSttkR/woqbccNv/FOEb3VMcn7qUx51KcY9HpnKhrrsp20GmcakO10fA/sYVepmGMajr01GLD7iNDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=q/UpHLIl; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkDXq1w2mz2xyh
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 13:42:16 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=84uoVePJdRamBj+BE+XwaFAV2iuGe/ezkbCVLB53sb0=;
	b=q/UpHLIlPFwKcN/x0WMJK8AwM3x67UveNzlbg+ZpSQ7x+5ad29tvXk71mxqhSSHAt8i9Bor97
	tlMHeOdHY1/z0TpIeAzAz4fQI2KKeiUUo/G7c7uGAbHFctGSCUVSWNbWoMm6ci3AfmMKL31av1t
	/WaPNXz4FLz/2Qx9E5ZxUqA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gkDMC5mZbzpSxC;
	Mon, 22 Jun 2026 11:33:59 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 54D574048F;
	Mon, 22 Jun 2026 11:42:11 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Jun
 2026 11:42:10 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 2/2] erofs-utils: lib: honor rebuild whiteouts for recreated dirs
Date: Mon, 22 Jun 2026 11:40:52 +0800
Message-ID: <20260622034052.1047677-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622034052.1047677-1-zhaoyifan28@huawei.com>
References: <20260622034052.1047677-1-zhaoyifan28@huawei.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3697-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 404F96AC511

From: Yifan Zhao <yifan.yfzhao@foxmail.com>

When rebuilding from upper to lower, a whiteout below an already
recreated directory should keep that directory but stop older lower
entries from being merged into it.

Mark the existing directory opaque before applying the generic
non-directory bailout.

Reported-by: cayoub-oai <276123840+cayoub-oai@users.noreply.github.com>
Closes: https://github.com/erofs/erofs-utils/issues/49
Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/rebuild.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 51dfe18..108a464 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -401,7 +401,13 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 			.nid = ctx->de_nid
 		};
 		ret = erofs_read_inode_from_disk(&src);
-		if (ret || !S_ISDIR(src.i_mode))
+		if (ret)
+			goto out;
+		if (erofs_inode_is_whiteout(&src)) {
+			d->inode->opaque = true;
+			goto out;
+		}
+		if (!S_ISDIR(src.i_mode))
 			goto out;
 		mergedir = d->inode;
 		inode = dir = &src;
-- 
2.47.3


