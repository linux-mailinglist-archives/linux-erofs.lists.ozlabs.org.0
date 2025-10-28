Return-Path: <linux-erofs+bounces-1296-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A769FC12C34
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Oct 2025 04:30:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwbVq10GZz3fmr;
	Tue, 28 Oct 2025 14:30:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761622243;
	cv=none; b=FknslKUHhPWC/gfIY14ClfuiSgZAafAdzINJg8GOIExDdRSD+wfTQBfZS87bGws9FZu5YMPIGBvuX/b4sUmBXdlY8NT9imjiRdeDJH4yscvOz0XJjLJEXIXbC1ZLqnrXBohHjlsrfaitMFVhFPtIUEXUOuz2THH4lfe444OsTXhK2CAbLntu300ioQZYz+d6UMvG+UjdPb2GkbHpZRcFdXKSWpRQyCu1IZbdz1Ck10j/Dyn0y1B00cCb4s/s/p9qRVByObshLEqwGb6QAwuKHciUGmzkJxCLmuVbStlWdQOIi2wg79rRTQMBRqpp7UbVl0r0u4ilJsGE1olSGJZFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761622243; c=relaxed/relaxed;
	bh=EfgsabB9z+Tb3AzGGZTPZN3SQmcHzPuAxAbGbkTgQ8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PwzfRY9bjPip3snOXyRgpiHgMgVdZeK9KtSrQAQCyrsoDRge1yDfMIhG2mr40uj26Dj1QHwxcxY+EJFcftmmh9/YWPjwR/zKH6IECmAYUGeti7kX/T1RQbKq5DZ4bRDd5AuDfA8fiAIL/UMZq6yOAHEOgHuapAEFGBebiFLL8vEM5SKxRwpWd7n4xUbrFEVqGgdmYo9+pY0Ed23LwbAPNSBPNbexiTpToByU5CEsO8i4flPLmCqKFvqF1mnlr5G/1nh4owPM4gfwrko5QGDHsBtLCiOSkoe3ovgx94+jrv2LpTs1pt7JCUOcqY81f0PoRxufVUBfV0YR7p9uPGbAXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=eUKfZUjt; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=eUKfZUjt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwbVn5L3jz3btw
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Oct 2025 14:30:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1761622242; x=1793158242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EfgsabB9z+Tb3AzGGZTPZN3SQmcHzPuAxAbGbkTgQ8A=;
  b=eUKfZUjtgYwcm9dHa1LTYt2FxztQpUO5LZz+1wV87aP5QJOUCbyvxk5a
   I+GPO5qaF2xwxNMFfKZZP0BiWyr0ZKBMbY8TwnVJV+/eMGszpaxRJ8Unq
   QYvTKAxN3KH4kof4Ca0pCrDvnYDY9LQNC3YsrTCVLboGmOM8ss19aE/Ao
   VffPolO9fgp/reYrHOrCUfj4oTZB6tGGNp3Yh6l8bW7Q8tTnh0gcblRD4
   iwBNVhi+F/EXlt8hfcCYCcctsH6NLeX0cIGHy/MXo6f2WenLefIDguphk
   GrSCtL6+CM3mIIWyGVJubB4xYBFind4RiIoHG4u4XUz4q0G0998RqE9O5
   g==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 12:30:34 +0900
X-IronPort-AV: E=Sophos;i="6.19,227,1754924400"; 
   d="scan'208";a="51956776"
Received: from unknown (HELO cscsh-5109200313..) ([IPv6:2403:700:0:20a2::1e0f])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 28 Oct 2025 12:30:34 +0900
From: Friendy Su <friendy.su@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v2] erofs-utils: mkfs: Turn off deduplication under chunk mode with '-E^dedupe'
Date: Tue, 28 Oct 2025 11:28:09 +0800
Message-Id: <20251028032809.1371395-1-friendy.su@sony.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

With '-E^dedupe', even under chunk mode, deduplication will be disabled.
This is mandatory if mount erofs with DAX.

Deduplicated chunks are shared among multiple files or different parts of one file.
Kernel DAX map got wrong when map them.

[    2.031496] WARNING: CPU: 0 PID: 1 at fs/dax.c:460 dax_insert_entry+0x36e/0x380
[    2.031978] Modules linked in:
[    2.032173] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2+ #111 PREEMPT(voluntary)
[    2.032688] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.033291] RIP: 0010:dax_insert_entry+0x36e/0x380
[    2.033591] Code: 59 fe ff ff 48 8b 30 b9 09 00 00 00 83 e6 40 0f 85 70 ff ff ff e9 77 ff ff ff 31 f6 90 0f 0b 90 85 f6 75 ae e9 34 fe ff
ff 90 <0f> 0b 90 e9 02 fe ff ff be 09 00 00 00 eb e3 0f 1f 00 90 90 90 90
[    2.034654] RSP: 0000:ffffb93fc0013b88 EFLAGS: 00010086
[    2.034948] RAX: ffffe124441dc140 RBX: ffffb93fc0013c78 RCX: 0000000000000000
[    2.035339] RDX: 00007f310337c000 RSI: 0000000000000000 RDI: ffffe124441dc140
[    2.035730] RBP: 00000000020ee0a1 R08: 0000000001077050 R09: 0000000000000000
[    2.036120] R10: ffffb93fc0013cd8 R11: 0000000000001000 R12: 0000000000000011
[    2.036513] R13: 0000000000000000 R14: fffffffffffff000 R15: 00000000020ee0a1
[    2.036912] FS:  00007f31026ad940(0000) GS:ffff90436812c000(0000) knlGS:0000000000000000
[    2.037352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.037669] CR2: 00007f31033c2216 CR3: 0000000001d17006 CR4: 0000000000770ef0
[    2.038062] PKRU: 55555554
[    2.038216] Call Trace:
[    2.038363]  <TASK>
[    2.038486]  dax_fault_iter+0x286/0x6a0
[    2.038704]  dax_iomap_pte_fault+0x17f/0x370
[    2.038950]  __do_fault+0x30/0xc0
[    2.039153]  __handle_mm_fault+0x90a/0x15a0
[    2.039391]  handle_mm_fault+0xde/0x240
[    2.039607]  do_user_addr_fault+0x166/0x640
[    2.039853]  exc_page_fault+0x74/0x170
[    2.040087]  asm_exc_page_fault+0x26/0x30
[    2.040319] RIP: 0033:0x7f31039389bd
[    2.040519] Code: 08 48 8b 85 68 ff ff ff 48 8b bd 60 ff ff ff 48 8b b5 58 ff ff ff 4c 89 f2 48 03 33 45 89 f7 48 c1 ea 20 48 89 b5 70 ff
ff ff <0f> b7 04 50 48 8d 14 52 4c 8d 24 d7 25 ff 7f 00 00 4c 89 65 80 48

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---
 include/erofs/config.h |  7 +++++++
 lib/blobchunk.c        | 26 ++++++++++++++------------
 mkfs/main.c            | 19 ++++++++++++++++++-
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 1685adf..92f040d 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -27,6 +27,12 @@ enum {
 	TIMESTAMP_CLAMPING,
 };
 
+enum {
+	DEDUPE_UNSPECIFIED,	/* no -Ededupe or -E^dedupe */
+	DEDUPE_ON,		/* -Ededupe */
+	DEDUPE_OFF,		/* -E^dedupe */
+};
+
 #define EROFS_MAX_COMPR_CFGS		64
 
 struct erofs_compr_opts {
@@ -41,6 +47,7 @@ struct erofs_configure {
 	bool c_dry_run;
 	char c_timeinherit;
 	char c_chunkbits;
+	char c_dedupe;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a5945f8..7d5d606 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -64,19 +64,21 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 
 	erofs_sha256(buf, chunksize, sha256);
 	hash = memhash(sha256, sizeof(sha256));
-	chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
-	if (chunk) {
-		DBG_BUGON(chunksize != chunk->chunksize);
-
-		sbi->saved_by_deduplication += chunksize;
-		if (chunk->blkaddr == erofs_holechunk.blkaddr) {
-			chunk = &erofs_holechunk;
-			erofs_dbg("Found duplicated hole chunk");
-		} else {
-			erofs_dbg("Found duplicated chunk at %llu",
-				  chunk->blkaddr | 0ULL);
+	if (cfg.c_dedupe == DEDUPE_ON) {
+		chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
+		if (chunk) {
+			DBG_BUGON(chunksize != chunk->chunksize);
+
+			sbi->saved_by_deduplication += chunksize;
+			if (chunk->blkaddr == erofs_holechunk.blkaddr) {
+				chunk = &erofs_holechunk;
+				erofs_dbg("Found duplicated hole chunk");
+			} else {
+				erofs_dbg("Found duplicated chunk at %llu",
+					  chunk->blkaddr | 0ULL);
+			}
+			return chunk;
 		}
-		return chunk;
 	}
 
 	chunk = malloc(sizeof(struct erofs_blobchunk));
diff --git a/mkfs/main.c b/mkfs/main.c
index 5657b1d..223c77c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -522,6 +522,11 @@ static int parse_extended_opts(struct erofs_importer_params *params,
 			if (vallen)
 				return -EINVAL;
 			mkfs_plain_xattr_pfx = true;
+		} else if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			erofs_mkfs_feat_set_dedupe(params, !clear, value, vallen);
+			cfg.c_dedupe = clear ? DEDUPE_OFF : DEDUPE_ON;
 		} else {
 			int i, err;
 
@@ -1532,6 +1537,7 @@ static void erofs_mkfs_default_options(struct erofs_importer_params *params)
 	cfg.c_mt_workers = erofs_get_available_processors();
 	cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
 #endif
+	cfg.c_dedupe = DEDUPE_UNSPECIFIED;
 	mkfs_blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
 	params->pclusterblks_max = 1U;
 	params->pclusterblks_def = 1U;
@@ -1837,7 +1843,18 @@ int main(int argc, char **argv)
 		err = erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chunkbits);
 		if (err)
 			goto exit;
-	}
+
+		/*
+		 * turn on deduplication for chunk mode if -Ededupe or -E^dedupe
+		 * not specified
+		 */
+		if (cfg.c_dedupe == DEDUPE_UNSPECIFIED)
+			cfg.c_dedupe = DEDUPE_ON;
+	} else
+		/*
+		 * turn off deduplication if not chunk mode
+		 */
+		cfg.c_dedupe = DEDUPE_OFF;
 
 	if (tar_index_512b || cfg.c_blobdev_path) {
 		err = erofs_mkfs_init_devices(&g_sbi, 1);
-- 
2.34.1


