Return-Path: <linux-erofs+bounces-3402-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K+RHRHUAmpEyAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3402-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 09:17:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E731D51BA6D
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 09:17:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF7G23kfZz2xnQ;
	Tue, 12 May 2026 17:17:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778570250;
	cv=none; b=IjDurwxn4h/EWczS6EZz+p0qgllOK/D1U84CUsOwkTgsMNyk9L1z5OaD5TG4vxLcXGVIt+zj6k1cPr+A8lrV0dy6eRlwi5ak1SpPFQsAqd2Gq33ytSmnVJ0On5Gbod/uQ5Z8eORKBucEANK1BmQ8HesqRl5U7xF3qngwC+eKSc03BUvfiICtqwZYXm25+quskeb81Dtu7Z9QmNfl+PxLRWXXHR96iKN3LAS7n7l0Uv6yaqU9dwAQ2mRjDoMwP9/DFWWcvDg8MKQags43YhVI+h5Ym6lVNzCA6AAmyTZvnyyZAUP46wbA5vYgmiGWXHREqnWfWpDXeC9ZMoAXQz++og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778570250; c=relaxed/relaxed;
	bh=N1pOkCyK/Bf9ocm3852WO3t5D6/UVqxmGoQOYD35xSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fW7oCcOHRNUWD8jgbjR2Ker0UXMs4lAsxhTz6l4J1v7L3owLg5HxgfRKtjhwbHXkTkE6IL73ftzFZb9x/UHEVz5bI7sCvizSNqMgBIXZzys6wrrI1mSVdAKUYph76F2d5KGOUg3WRWb5730zQou1eHLOaUFvRRGvSWYQT9y9KNw7GT5K9QyS+tmxVKzG2XpThUYbE5LUFCmlXE68RwGYSybUD7gxENkU7tIs9dP91UtEK6gkZ+yOIfz2eteYxxpSFIEodMx1nWsoXWcFrTipH38pOfhbP/tjAgwyPswzEq9hGh+UcJRNddbYI/ZWCkfZ6uG4wdL802YDdGBU50aeMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=uyFlOfpI; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=uyFlOfpI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF7G06SLHz2yb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 May 2026 17:17:28 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=N1pOkCyK/Bf9ocm3852WO3t5D6/UVqxmGoQOYD35xSQ=;
	b=uyFlOfpIa6/zG//JNGMylpz70xqqZUhR1MLXhHzytBRQaubs3X7dznLFDDbXs69lTPIWWjFgv
	KNCKHEshm4jxAVWJez8JkPSsvz5ykSNQVyDxEUIeGg1RotEhBb3Qi+7hElEolnMTMRyfpKI8AbI
	IiRoZORAR3VvhDZWtMM2SvA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gF7522wKzzKm52
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 May 2026 15:09:42 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B42A4056F
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 May 2026 15:17:21 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 12 May
 2026 15:17:20 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 3/3] erofs-utils: fsck: report error reasons on failures
Date: Tue, 12 May 2026 15:16:31 +0800
Message-ID: <20260512071631.969752-3-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512071631.969752-1-zhaoyifan28@huawei.com>
References: <20260512071631.969752-1-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: E731D51BA6D
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
	TAGGED_FROM(0.00)[bounces-3402-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action

Several top-level failure paths only printed the failed operation,
which made corrupted images hard to diagnose from fsck output.

Include the errno string for these paths so users can distinguish
I/O errors from corrupted metadata and invalid arguments.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 fsck/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 21ada19..0c628eb 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -1079,13 +1079,15 @@ int main(int argc, char *argv[])
 
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDONLY);
 	if (err) {
-		erofs_err("failed to open image file");
+		erofs_err("failed to open image file: %s",
+			  erofs_strerror(err));
 		goto exit;
 	}
 
 	err = erofs_read_superblock(&g_sbi);
 	if (err) {
-		erofs_err("failed to read superblock");
+		erofs_err("failed to read superblock: %s",
+			  erofs_strerror(err));
 		goto exit_dev_close;
 	}
 
@@ -1104,7 +1106,8 @@ int main(int argc, char *argv[])
 
 		err = erofs_ilookup(fsckcfg.inode_path, &inode);
 		if (err) {
-			erofs_err("failed to lookup %s", fsckcfg.inode_path);
+			erofs_err("failed to lookup %s: %s",
+				  fsckcfg.inode_path, erofs_strerror(err));
 			goto exit_hardlink;
 		}
 		fsckcfg.nid = inode.nid;
@@ -1123,7 +1126,8 @@ int main(int argc, char *argv[])
 
 			err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
 			if (err) {
-				erofs_err("failed to verify packed file");
+				erofs_err("failed to verify packed file: %s",
+					  erofs_strerror(err));
 				goto exit_packedinode;
 			}
 		}
-- 
2.47.3


