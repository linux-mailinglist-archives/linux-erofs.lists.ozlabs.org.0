Return-Path: <linux-erofs+bounces-2199-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAz8FszScmnKpgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2199-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 02:45:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6176F4AB
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 02:45:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy13K1CGfz2xHt;
	Fri, 23 Jan 2026 12:45:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769132733;
	cv=none; b=DVL3OPEFs1gIdnDl5jgMvUEAwwEn/0AswQE2ZeJNHbgIyFkbzLX+YLRqSky/QTGkoFz/E6SxPSv0QSs6Xf8Rcnn80AHxhaYd7E/9bDDAh3kyc3C4umGdoLvQfaC27DyYMkcIOmqWVVxUZCuX+ULAq5OVxiET3SG/koAO6pYdhqT3z+ssBxakW7jk93RvKhVtqOMFhhV2USykpLDVFbGVCe0w1EuOfBl0iZwibbXmVQ+omHTPHr3K1dAPte7/zFOYMyWIfOPgoZzdYG8VUYWQKJLnaLq5dpJGq7Hwr6ciYT9PbtvzukmMxXHI09GUbGSe6N5N6Z4WHKPGnvCaM/Xz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769132733; c=relaxed/relaxed;
	bh=MM8TsauSDpoIZ20LujoMlgVoP0k5Dxv+caeL1MPk8ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0UTTPW7l2sDmK+GdzJL30ahaatryJ4/WRiLq1/EaRt3H05GYVYt0iSzArSRv4DrzfO+R3ST4p93Im+HeLeb0z+r+Ps0JBJuv/MV9pvDwjVdFH1xDcdhQOgz8sZBzQmKO4f3+/C2KXTDdA5nixE/PA2CA5FUZGRLrKuLrkgQti7GP5xnIhGGWJKoUgzsh99yRJKftTcvyCcr+5j5ukx3yeFyZPCcUiuzWruwnjkxn6MuxfKlf2NLfrSAFTyEEuC9nuYr3sI6RBYLcLie7pQuzCbChfasjWmTk2quT3HitFcBQP5gE+1FJBbY1JQkpmB2oXOHcF2KmZhvSaHhtaKsVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rutdvmdo; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rutdvmdo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy1395RbKz2x9M
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 12:45:25 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MM8TsauSDpoIZ20LujoMlgVoP0k5Dxv+caeL1MPk8ho=;
	b=rutdvmdomAR7xcskRUZYp3W4+DpdvSHcbEvxC0n6cYxBOvYi8DdsB+Mv6VegqAuIzwUdmlfSH
	Z5lCKFfzVfvavsiloG3x2Lkhs22Gvq8CZrXXGGdKdR/gGpoE0U2liT37sPH2VopWIzpFle0IpQK
	rF5JNX/CctceFbwK/e+UpQw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dy0z716Prz1cySK;
	Fri, 23 Jan 2026 09:41:55 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AD1B40565;
	Fri, 23 Jan 2026 09:45:19 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 09:45:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v18 05/10] erofs: using domain_id in the safer way
Date: Fri, 23 Jan 2026 01:31:27 +0000
Message-ID: <20260123013132.662393-6-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260123013132.662393-1-lihongbo22@huawei.com>
References: <20260123013132.662393-1-lihongbo22@huawei.com>
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
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
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
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2199-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	RCVD_COUNT_FIVE(0.00)[5];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lihongbo22@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.931];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,huawei.com:email,huawei.com:dkim,huawei.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 6E6176F4AB
X-Rspamd-Action: no action

Either the existing fscache usecase or the upcoming page
cache sharing case, the `domain_id` should be protected as
sensitive information, so we use the safer helpers to allocate,
free and display domain_id.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst |  5 +++--
 fs/erofs/fscache.c                  |  4 ++--
 fs/erofs/super.c                    | 10 ++++------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 08194f194b94..40dbf3b6a35f 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -126,8 +126,9 @@ dax={always,never}     Use direct access (no page cache).  See
 dax                    A legacy option which is an alias for ``dax=always``.
 device=%s              Specify a path to an extra device to be used together.
 fsid=%s                Specify a filesystem image ID for Fscache back-end.
-domain_id=%s           Specify a domain ID in fscache mode so that different images
-                       with the same blobs under a given domain ID can share storage.
+domain_id=%s           Specify a trusted domain ID for fscache mode so that
+                       different images with the same blobs, identified by blob IDs,
+                       can share storage within the same trusted domain.
 fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
 ===================    =========================================================
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index f4937b025038..a2cc0f3fa9d0 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -379,7 +379,7 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 		}
 		fscache_relinquish_volume(domain->volume, NULL, false);
 		mutex_unlock(&erofs_domain_list_lock);
-		kfree(domain->domain_id);
+		kfree_sensitive(domain->domain_id);
 		kfree(domain);
 		return;
 	}
@@ -446,7 +446,7 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 	sbi->domain = domain;
 	return 0;
 out:
-	kfree(domain->domain_id);
+	kfree_sensitive(domain->domain_id);
 	kfree(domain);
 	return err;
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index dca1445f6c92..38be26ba04bb 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -525,10 +525,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			return -ENOMEM;
 		break;
 	case Opt_domain_id:
-		kfree(sbi->domain_id);
-		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
-		if (!sbi->domain_id)
-			return -ENOMEM;
+		kfree_sensitive(sbi->domain_id);
+		sbi->domain_id = no_free_ptr(param->string);
 		break;
 #else
 	case Opt_fsid:
@@ -624,7 +622,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && sbi->fsid)
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
@@ -852,7 +850,7 @@ static void erofs_sb_free(struct erofs_sb_info *sbi)
 {
 	erofs_free_dev_context(sbi->devs);
 	kfree(sbi->fsid);
-	kfree(sbi->domain_id);
+	kfree_sensitive(sbi->domain_id);
 	if (sbi->dif0.file)
 		fput(sbi->dif0.file);
 	kfree(sbi->volume_name);
-- 
2.22.0


