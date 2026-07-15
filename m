Return-Path: <linux-erofs+bounces-3898-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uH24HxYAV2qhEAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3898-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jul 2026 05:35:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35EA75A503
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jul 2026 05:35:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mfYqIBuU;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3898-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3898-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0MJY3Lpmz2xd2;
	Wed, 15 Jul 2026 13:35:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784086541;
	cv=none; b=lRPPjhbcmsjRjagrXL7V0duj9rHid0K9I/1mjQgzY9Bjq2LlPBcSl60Prg6IuDeI+7DF2NHKuviNb3DbJkYLhUVkmxAZMTYMpf/AczDclYRMjTXRsBVgHtXQ6LVjX/yRA/CoRTcH1QqDzGStzbg8i9l8AklSA8PIBUNp0bt0rXzE5CIkTxpPCsKTQ8EW193fUQJj6bByN2NX/qoi4lIsdck9kQ4PAVqyQvy7SZWopSUWlDvrtOE7LHEoqHz9BXuV0uyEhpoJEOPxg/Xunuqesmj/IbloqmiwhtwQ5gs2kWbKdr46pRL+9abG2R2k4g1QHtNR24OdEoWXM17Soh9ScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784086541; c=relaxed/relaxed;
	bh=MooPe2m60nY/UfQ0cAm3E3HG16yigXKlWgLFH1SifDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNumJmU2k0hwKNOwgJ8A6gTvAIRd2v94dCf6KXFh0leyER/uhQ8laa4MNoZ2e6AX8U6ahQt7/je7LEGiumg0q28fhbv7jR2ey/cEfxliTp5I4ntSL/xhOLicoImvOFQOZ1ybfQu/aqLOUA5+l4Bpi+jcrP9Iw2M1d5U8sg2Zx+fvaixuuds9Z4C1Hija+z2G8I7ILmCggRrOUwGUem7xybnkKXKyai4GJdsXHVQzAyWHJyogVeGKDNzOzW0yrdFXtO/ihK/ulyD57oANAHHbI8AujQakgbAXM4yPGb377yQ3gbebpI84FbTwXbEzQMhnxj6imIA/sapEvRf8t2vL5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mfYqIBuU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=aditya.ansh182@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0MJW6m9bz2xLk
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jul 2026 13:35:38 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4333701a91.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2026 20:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784086536; x=1784691336; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MooPe2m60nY/UfQ0cAm3E3HG16yigXKlWgLFH1SifDA=;
        b=mfYqIBuU/9PSFN+0Z9B4C63Tgd2pxWIaURmVksHF4SNRwnYJUzWDNBU8E4mq+ENOMy
         Zv6hLbB1FdqQTO5PlwYnLJkvISqVlU85LdHJowVLq+WWuzDBGDXvGhxYKPbbtOrlSRE7
         InJLDNOMzoSpxWyEBF7JHzXHRbTp+wGBJ4l0/bEQhUgTzsr+FGE89HL9aoWBiliIHKZq
         jn489CLaofbajhWZU3nUcY0hHC5TVdavJ+YvbMEVZ5OHytOfFdDDyG0lrxuFHh2x6Bai
         vLWshDZxXMxBQM5MBFL3l0Xm6nuM/elvoANZqafpz5HYfTpLtQmvZElAfCZ+IeCT017h
         MAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784086536; x=1784691336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MooPe2m60nY/UfQ0cAm3E3HG16yigXKlWgLFH1SifDA=;
        b=AaIywYvsQ78yfdkFCEc5/GEyr3PfOBH7M40QG4hqKFIChk7HSmZzds/xY/uj4u1fb9
         aoETQ/NIFLt0z+gJDdhGYvcUqmJMX4sUyfreItDBb5A6YjymdgXupSKWVowq7iIkCTK/
         d085FhctgeWuucMQUtrG1TLXMkxmnNuL1Dwuz3KYR0D3ev54XZxZ9zeko14AqWu3mncC
         yZCPBK9GG2MxeUYd1o5S+2EmSn9kOVqsux+6e3FLWpSfszWiszzTOOtp3VsZoKC4+c3t
         2wSIRtOjzOHTXMd3g7Yw3/STOlGppslQ6m/jWFblnNICeuL2pwmyTKgXdYLoNpMJeXIN
         3t5A==
X-Forwarded-Encrypted: i=1; AHgh+RrffrZo3xCK+GnUFD+bvH2BlowNTxrmmUu7h3ZcAp1PRcJHM8OF2YdNt1ohQdNzo4RmdOgEmY1W9GKIlA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx73XPlRPMkSeidZMDG8gW8WT6ityLYhGszHqLJWiw/e2eJUNSx
	itXlwx2es2+rfLKahgY8N1t1wvS6f5OYseooBNjA2Q7jRWHQoPcckvsb
X-Gm-Gg: AfdE7ckZijv62BqR8I8/xv++2RSaNwMfFqxdKTrc/hp5K7GkFDlmVX5nIglZxKG7hvn
	Wlb4PeN++TaeIrmkByC2JQ41eaanqXsalj4VCISGc3QEFn0S2mnK1UkQGV8e/REfJDT/ubNwhqa
	0CrFODeIAZPm4mNsRSqzqjJnrT126pfZ07S7qE28tR0t41HYUvDc4SI93WIUCEPY2s+l/Juyv7Q
	lCw5e10qPYOBpOdjuY1mygdm/SOsARhaJW23cPXtfqEho22OQd/cr40z0yGW++C41vtqiWnOJOy
	8FgdAzmq7sz2oq8PWQlXbPNeO4oF8Go7AOJFkCGiOsXhNynW6C5OXA79P/Ox9XEmeKHnsH3wgrE
	TnGCpdnoJyJ1HFwqSC5RomjgTPaY7wITSw+KsGu/JSC8W37fsp9mNJDkhdtPLX8/GgJkVJJhfR2
	e84KnahkOVNYai+swRgznxmwPPPPOkwKlFMXVfs6BXYAH4hEVpt9+2FGPJA7FTQ23S8c0nSM0qj
	17ssGNgmuE8q7BibO7T6aoGJEXvKXy5JKiq53qKfKXGwY/QDuw0R2F+uFPQ6ZSllcO8jvXnjs6e
	PGIaqhsOUoko7t3gPiZXwotfWQ==
X-Received: by 2002:a17:90b:55cc:b0:381:22d6:f7a3 with SMTP id 98e67ed59e1d1-38e2a030362mr1122604a91.18.1784086535924;
        Tue, 14 Jul 2026 20:35:35 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.z168d0f9edf9bc766-tp.internal (19.141.142.34.bc.googleusercontent.com. [34.142.141.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cba1fsm2303382a91.5.2026.07.14.20.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 20:35:35 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH] erofs: modernize device IDR to XArray
Date: Wed, 15 Jul 2026 03:35:07 +0000
Message-ID: <20260715033507.1666-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3898-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[adityaansh182@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:aditya.ansh182@gmail.com,m:adityaansh182@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adityaansh182@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E35EA75A503

Currently, EROFS maintains a list of extra devices using a legacy IDR
structure (`sbi->devs->tree`). Modernize this to use a standard, more
efficient XArray instead.

This migration simplifies device management, removes legacy boilerplate,
and aligns EROFS device tracking with modern Linux kernel storage subsystem
conventions:
1. Convert `sbi->devs->tree` from a legacy IDR to an XArray initialized
   with `XA_FLAGS_ALLOC` flags.
2. Use `xa_alloc()` to safely register devices under `xa_limit_32b` limits.
3. Use `xa_load()` for direct, fast lookups.
4. Replace custom IDR traversal wrappers with modern `xa_for_each()`
   iterators.
5. Replace custom IDR releasing callback helpers with a clean
   `xa_for_each()` loop and clean up the tree with `xa_destroy()`.

Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/erofs/data.c     |  6 +++---
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 43 +++++++++++++++++++++++--------------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 9aa48c8d67d1..34a1a7d71559 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -211,13 +211,13 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
 	struct erofs_device_info *dif;
 	erofs_off_t startoff;
-	int id;
+	unsigned long id;
 
 	erofs_fill_from_devinfo(map, sb, &EROFS_SB(sb)->dif0);
 	map->m_bdev = sb->s_bdev;	/* use s_bdev for the primary device */
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
-		dif = idr_find(&devs->tree, map->m_deviceid - 1);
+		dif = xa_load(&devs->tree, map->m_deviceid - 1);
 		if (!dif) {
 			up_read(&devs->rwsem);
 			return -ENODEV;
@@ -231,7 +231,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
-		idr_for_each_entry(&devs->tree, dif, id) {
+		xa_for_each(&devs->tree, id, dif) {
 			if (!dif->uniaddr)
 				continue;
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 580f8d9f14e7..f6126a7bfbc7 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -64,7 +64,7 @@ struct erofs_mount_opts {
 };
 
 struct erofs_dev_context {
-	struct idr tree;
+	struct xarray tree;
 	struct rw_semaphore rwsem;
 
 	unsigned int extra_devices;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..08e6a9c57d59 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -188,7 +188,8 @@ static int erofs_scan_devices(struct super_block *sb,
 	erofs_off_t pos;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_device_info *dif;
-	int id, err = 0;
+	int err = 0;
+	unsigned long id;
 
 	sbi->total_blocks = sbi->dif0.blocks;
 	if (!erofs_sb_has_device_table(sbi))
@@ -217,20 +218,22 @@ static int erofs_scan_devices(struct super_block *sb,
 	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
 	down_read(&sbi->devs->rwsem);
 	if (sbi->devs->extra_devices) {
-		idr_for_each_entry(&sbi->devs->tree, dif, id) {
+		xa_for_each(&sbi->devs->tree, id, dif) {
 			err = erofs_init_device(&buf, sb, dif, &pos);
 			if (err)
 				break;
 		}
 	} else {
 		for (id = 0; id < ondisk_extradevs; id++) {
+			u32 id_val;
+
 			dif = kzalloc_obj(*dif);
 			if (!dif) {
 				err = -ENOMEM;
 				break;
 			}
 
-			err = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
+			err = xa_alloc(&sbi->devs->tree, &id_val, dif, xa_limit_32b, GFP_KERNEL);
 			if (err < 0) {
 				kfree(dif);
 				break;
@@ -480,7 +483,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!erofs_fc_set_dax_mode(fc, result.uint_32))
 			return -EINVAL;
 		break;
-	case Opt_device:
+	case Opt_device: {
+		u32 id;
+
 		dif = kzalloc_obj(*dif);
 		if (!dif)
 			return -ENOMEM;
@@ -490,7 +495,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			return -ENOMEM;
 		}
 		down_write(&sbi->devs->rwsem);
-		ret = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
+		ret = xa_alloc(&sbi->devs->tree, &id, dif, xa_limit_32b, GFP_KERNEL);
 		up_write(&sbi->devs->rwsem);
 		if (ret < 0) {
 			kfree(dif->path);
@@ -499,6 +504,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		}
 		++sbi->devs->extra_devices;
 		break;
+	}
 	case Opt_domain_id:
 		if (!IS_ENABLED(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)) {
 			errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
@@ -797,24 +803,21 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 	return 0;
 }
 
-static int erofs_release_device_info(int id, void *ptr, void *data)
-{
-	struct erofs_device_info *dif = ptr;
-
-	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->file)
-		fput(dif->file);
-	kfree(dif->path);
-	kfree(dif);
-	return 0;
-}
-
 static void erofs_free_dev_context(struct erofs_dev_context *devs)
 {
+	struct erofs_device_info *dif;
+	unsigned long index;
+
 	if (!devs)
 		return;
-	idr_for_each(&devs->tree, &erofs_release_device_info, NULL);
-	idr_destroy(&devs->tree);
+	xa_for_each(&devs->tree, index, dif) {
+		fs_put_dax(dif->dax_dev, NULL);
+		if (dif->file)
+			fput(dif->file);
+		kfree(dif->path);
+		kfree(dif);
+	}
+	xa_destroy(&devs->tree);
 	kfree(devs);
 }
 
@@ -858,7 +861,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	}
 	fc->s_fs_info = sbi;
 
-	idr_init(&sbi->devs->tree);
+	xa_init_flags(&sbi->devs->tree, XA_FLAGS_ALLOC);
 	init_rwsem(&sbi->devs->rwsem);
 	erofs_default_options(sbi);
 	fc->ops = &erofs_context_ops;
-- 
2.47.3


