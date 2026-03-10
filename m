Return-Path: <linux-erofs+bounces-2578-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHHlNCwIsGkUewIAu9opvQ
	(envelope-from <linux-erofs+bounces-2578-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:01:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 378FE24C1B2
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:01:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVXXk2pw9z3cD1;
	Tue, 10 Mar 2026 23:01:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.42.244.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773144086;
	cv=none; b=Mq8JBg2YJOyP+PqZw8xA+wt/nvV4gDXDS1pJp87/U+kryb/gWM/U9lRP4oclZed/hMiFLqBRWyefsR7xA1AtVpr6aZHIqWrBH6edZ08oP9Zwf5Wxz2mok1q4mYb7AKVQqVA/sAJtKNWIv5xLKnLKpgF3ePK89oPDNIEoeKoTYodeihPwNfs6OiBXpaarWvNQ8StHDopq9XebAIq22iUD/0ErBrQjK9YS/ANb7ch8Wj5ZbEEJrZHWFblem3DO0T9dfGUao/ep2tYBkXGFzCZISsSh5Nz4LyN/Mv0isA1NT9DIf5S4jPVYv5qOu0n5WuoTVvxr7tCmZanhTdd910xMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773144086; c=relaxed/relaxed;
	bh=JuC1mSy0wWf/HA7nrfH8vcHZny+hdINtD1gY837dpg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1MVN4FoJQx6m9I/neTa5nbFaiPzpMcfi9uMNW4tB8wYRCTqYRuxY6PN7nMSWOOisgsv+twF6dAWKwW9bVxSE3wC2ZWGizgmCrURD/R84IETowgCVLcnOGDtw+MUWPmFweZhKxp4xEn9Em9g3ZJ0qUBLmDdd+YTMAcKJjlXF6OiGdAbzGKnGVZvI7ISHXZNPl3LQTbPRGV3hUZmCCS+AkjIDBJGoPlAC0MZoMhLNhWCDksb5p5jPFgy+YGImX0GIBygfpDd6seSQW8CVuvJ69I+Xdfibqs7XoRiFavEjSDlSdtVRV4kRU5QvqwIN3900HCqIOn6wC9ogjlgIIRw0og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=rc8Hq89F; dkim-atps=neutral; spf=pass (client-ip=212.42.244.119; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org) smtp.mailfrom=avm.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=rc8Hq89F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=avm.de (client-ip=212.42.244.119; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org)
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVXXg5hn7z3cD7
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:01:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143723; bh=DGbCaZBy1FpfvXwgzKpSCwa07WA8CY/Qb4IJHso0Te4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rc8Hq89Fb5fz3t9XGAV9DEbHVf5dfp7yp00Gf9MYpCbFElXUliv8K0TJ88EegoebM
	 lMHRZL83a9AqjbASsPk3qVgNFrp4VheSaUprtXI9vxtui90WS9FjZFrbxSMEBA+AFT
	 xc3KncdB3VgIsSI2EjPb3pbBX8z4jE0V+gxrfv0k=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ab-2367-7f0000032729-7f0000019cc4-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:28 +0100
Subject: [PATCH 02/61] btrfs: Prefer IS_ERR_OR_NULL over manual NULL check
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-2-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=DGbCaZBy1FpfvXwgzKpSCwa07WA8CY/Qb4IJHso0Te4=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXVP8rQiO4oClcWoVpEQy4tTT6UufgJ8AjmW
 meFZ085mAaJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF1QAKCRA0LQZT0ays
 26ZTCACM3Mi9LEMEAWgAR6v8SxUVk3um+/46scAm+wvRfrMWEFwlnMkQBbCGIGZUNkKB1Pk7uvR
 q9d3fZ689cKMySmmjPCYjQ/WgGDVLcywEn6In35Jwnklhlj4dYJLSL6WxXsza+vlAV93TQDvaTs
 OFlLEsZ2j+XY+f2mrUOcVwOk+301k/goYUacbLoVSw0YZnroo7kAB2acRVGhOGAOOiJoiVAdHNU
 Yf8QURa2qrPqHMwGd4SQRV57t+Grw+zEItF3L0eYw7mf41TaJcLeP7Vo+0nFp2D9QdrMND4nUec
 WhX0remRDcBywCJPWh7SmqRiZyiXDaIfp9JkUkUr5yx6Wacb
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-80C85E1F-0AA4A985/0/0
X-purgate-type: clean
X-purgate-size: 3019
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 378FE24C1B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2578-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:clm@fb.com,m:dsterba@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[56];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,suse.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,fb.com:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
not like nesting it:
> WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> unlikely() internally
Remove the explicit use of likely().

Change generated with coccinelle.

To: Chris Mason <clm@fb.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/btrfs/inode.c       | 2 +-
 fs/btrfs/transaction.c | 2 +-
 fs/btrfs/tree-log.c    | 2 +-
 fs/btrfs/uuid-tree.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a11fcc9e9f502c559148cf33679014fb83b0d3b0..7c26a0bf56bf7309e2ce8256854d760b2d64b16a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4683,7 +4683,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, fs_info->tree_root, path,
 				   dir_id, &name, 0);
-	if (di && !IS_ERR(di)) {
+	if (!IS_ERR_OR_NULL(di)) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
 		if (key.objectid == btrfs_root_id(root)) {
 			ret = -EPERM;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7ef8c9b7dfc17a5133b6d2dc134e288975ed98d1..40b83037725033d3178dc3fc2c1e347ad2c597f7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1737,7 +1737,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
 					 btrfs_ino(parent_inode),
 					 &fname.disk_name, 0);
-	if (unlikely(dir_item != NULL && !IS_ERR(dir_item))) {
+	if (!IS_ERR_OR_NULL(dir_item)) {
 		pending->error = -EEXIST;
 		goto dir_item_existed;
 	} else if (IS_ERR(dir_item)) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 780a06d592409b05fb42dc8079b019d23fe0cdfa..2e07ae393cf9d16f562047dd4cbfd7b4b9f2952e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5750,7 +5750,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 		name_str.len = this_name_len;
 		di = btrfs_lookup_dir_item(NULL, inode->root, search_path,
 				parent, &name_str, 0);
-		if (di && !IS_ERR(di)) {
+		if (!IS_ERR_OR_NULL(di)) {
 			struct btrfs_key di_key;
 
 			btrfs_dir_item_key_to_cpu(search_path->nodes[0],
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index f24c14b9bb2fd7420b06263a5a0c4b889a859bc6..c497b287f3418933e532903b326b969416ae22cb 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -478,7 +478,7 @@ int btrfs_uuid_scan_kthread(void *data)
 
 out:
 	btrfs_free_path(path);
-	if (trans && !IS_ERR(trans))
+	if (!IS_ERR_OR_NULL(trans))
 		btrfs_end_transaction(trans);
 	if (ret)
 		btrfs_warn(fs_info, "btrfs_uuid_scan_kthread failed %d", ret);

-- 
2.43.0


