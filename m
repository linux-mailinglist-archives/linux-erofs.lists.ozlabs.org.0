Return-Path: <linux-erofs+bounces-1282-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 246F1BFFC4C
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Oct 2025 10:04:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csdqM6TCKz3bW7;
	Thu, 23 Oct 2025 19:04:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761206687;
	cv=none; b=QZpB/mxhuGg7ejwHJ9yZ9gbdQ3M/Ww2zF5+EfEs8qxpjsUI0EehcRQj01ZNwoSTvUzjThF8q2L6VSL9FbZP0nRFexEsaHTmc4HG/R2m3uat5vFC7ardtcMdEDzklN5GHtDwPLa74gyiT1b6R8te/+ys3TDQpXHSEdzMaXdivW1szPXRt8YMuVi6dAB1yVTHf0/QV9rQ7Q7aRr6Z74Hpkzb9J0NdhXwmu4Ehjq1U1mnK2/EiWCHzT3KQ6qeAyTfmjnoHdaLdujuEcTxruDWFzeiKjHU4jigUz259fZ5imtQoBV8xdJNztTQ1EM2t2SiBe2H/k06MBBX2PChFWkYHrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761206687; c=relaxed/relaxed;
	bh=UhpAWmowZCZOa69gnF3dFpItxeRKVf6Y5hiDMqv5qAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gubQ6Zh0RvVvPwU4YZPfwuRMPLH5mM1CZUQSle71BSdod4xwBJcKmFTOdjT8au0ctTD/wRc8qn6aWScfADHhvRLULYB8cOnDZKLtpSbR5riYgn6FYBx7JiQIo8G7bgt9L7j6qd46ntDwUdvNdBJMo/rSrwTacgqdmx5pPMaA1t6ncZ6xQMAirr6nF5HnPXY+1AG0cs5xbJIhl50T5EqJPI2Cw9CxlShF2OwUg1IVYW/mlpnbGMd8OFm6qoTuk/mtg/7E5Vhv0/v4M7cWci4wPq9r/HlL2g7FoU3HZB/9ilDF/geq5ucbsji7+i0W2hYpBZ92ldinWedWW8VkqdO+yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=QMqC672c; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=QMqC672c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csdqL3Gtxz304l
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Oct 2025 19:04:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1761206686; x=1792742686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UhpAWmowZCZOa69gnF3dFpItxeRKVf6Y5hiDMqv5qAI=;
  b=QMqC672cF6t/7YgHrvJ3wuNQrF0PhQInRQNR5kEhkWn3uTZdKEF6YzEt
   pzaHiRjNIu36dSEmhX2Sx5KJ8u08WkkKvw4u85DPN5qsaw7K+qE83Jtom
   GNbLx2+zEt72RXgeMJ63VKcOiVvPeggf2fXvL/Ma9fdWoUsU889faIOXB
   52qoFah1BKB/K+265nKk+x4EYMBpCcXKKp0O700eCWfbx4Dfuyrbn+Z1O
   HOp8/ZdrUmVi11wPdBuAo8H7r9SuPDz5oxiVjYG4VkIdMRWlxGI070Z29
   VvJGhUrRp2xuhRZ1UgE5VxZvMprVzhyiXi2XGY0lbSuCnM5FRRoIpYjuG
   A==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 17:04:35 +0900
X-IronPort-AV: E=Sophos;i="6.19,227,1754924400"; 
   d="scan'208";a="49723727"
Received: from unknown (HELO cscsh-5109200313..) ([IPv6:2403:700:0:20a2::1e0f])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 23 Oct 2025 17:04:35 +0900
From: Friendy Su <friendy.su@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v1] erofs-utils: mkfs: Add 'no-deduplication' option
Date: Thu, 23 Oct 2025 16:01:42 +0800
Message-Id: <20251023080142.991914-1-friendy.su@sony.com>
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

Add an option to disable dedupliation at format.
This option is mandatory if mount erofs with DAX.

Deduplicated chunks are shared among multiple files or different parts of
one file. Kernel DAX map got wrong when map them. The following
kernel backtrace is printed.

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
 include/erofs/internal.h |  1 +
 lib/blobchunk.c          | 29 +++++++++++++++++------------
 man/mkfs.erofs.1         |  6 ++++++
 mkfs/main.c              |  8 ++++++++
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6106501..3b404af 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -156,6 +156,7 @@ struct erofs_sb_info {
 	struct erofs_buffer_head *bh_devt;
 	bool useqpl;
 	bool sb_valid;
+	bool no_deduplication;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a5945f8..c1c93ba 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -64,19 +64,24 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 
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
+	/*
+	 * if 'no-deduplication' is set, no need check hash
+	 */
+	if (!sbi->no_deduplication) {
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
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index cc5a310..59b74be 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -235,6 +235,12 @@ Specify maximum decompressed extent size in bytes.
 (used together with \fB-T\fR) the given timestamp is only applied to the build
 time.
 .TP
+.B "\-\-no-deduplication"
+Disable deduplication. Set this option if mount with \fBdax\fR.
+
+The deduplicated chunks are shared by multiple files or by different parts within one file.
+As for now, kernel can not handle DAX map well for the deduplicated chunks.
+.TP
 .B "\-\-preserve-mtime"
 Use extended inodes instead of compact inodes if the file modification time
 would overflow compact inodes. This is the default. Overrides
diff --git a/mkfs/main.c b/mkfs/main.c
index f1ea7df..d521e52 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -101,6 +101,7 @@ static struct option long_options[] = {
 	{"oci", optional_argument, NULL, 534},
 #endif
 	{"zD", optional_argument, NULL, 536},
+	{"no-deduplication", no_argument, NULL, 537},
 	{0, 0, 0, 0},
 };
 
@@ -207,6 +208,7 @@ static void usage(int argc, char **argv)
 		" --root-xattr-isize=#  ensure the inline xattr size of the root directory is # bytes at least\n"
 		" --aufs                replace aufs special files with overlayfs metadata\n"
 		" --sort=<path,none>    data sorting order for tarballs as input (default: path)\n"
+		" --no-deduplication	disable deduplication\n"
 #ifdef S3EROFS_ENABLED
 		" --s3=X                generate an image from S3-compatible object store\n"
 		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
@@ -310,6 +312,7 @@ static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
 static bool valid_fixeduuid;
 static unsigned int dsunit;
+static bool no_deduplication;
 static int tarerofs_decoder;
 static FILE *vmdk_dcf;
 static char *mkfs_aws_zinfo_file;
@@ -1412,6 +1415,9 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			else
 				params->compress_dir = false;
 			break;
+		case 537:
+			no_deduplication = true;
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1793,6 +1799,8 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
+	g_sbi.no_deduplication = no_deduplication;
+
 	/* Use the user-defined UUID or generate one for clean builds */
 	if (valid_fixeduuid)
 		memcpy(g_sbi.uuid, fixeduuid, sizeof(g_sbi.uuid));
-- 
2.34.1


