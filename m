Return-Path: <linux-erofs+bounces-2587-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ87FUAIsGkUewIAu9opvQ
	(envelope-from <linux-erofs+bounces-2587-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:02:08 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B884024C218
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:02:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVXXm2gKWz3cFN;
	Tue, 10 Mar 2026 23:01:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:bf0:244:244::119"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773144088;
	cv=none; b=O6FMd0uC226eF6ln+Mi3mTqRhej9QFo/OTGgtOEBwNjaKNA2+3XoO4qRalqSsn8lvoqk6kpmWwJ3KK+8hc+nEEDQ8vnet7aA5lhoPjI0XLktPb7pAnzRIHVBml+z/LImU5djZ0eDtMygNvxt2ADOAHzgBfOWfZ7jU4p69xyixIg8ivQ8geSn1n2Jl8oE+bjnmFXNngP+hJ7VYeuztIkJTctaS4J71UsNaTphnnzM8lz9DFTHPHuJHcU55/c6987uMOopIamxiA/z9vdBl6CN20UB1BJzUvYgxNWDyj+pY5wCYYcdbkRkKlgQtHNhZaF32VaTTU3TGZLQzF0qb300RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773144088; c=relaxed/relaxed;
	bh=0/roifme+WLdPTziKMwbNdr5N/yzFbOWcvPcd+8xFnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWj+CNNU+JGZP2o4VblJlZ8hK5SYoELHd4YSy6TciYSo+OSXx2XyW9oh2+/C9XtYVni013oIMnZQ6Oyf1yX/NroyuNac/Zhh2nCNjdYisqWmaGdClp9w9pHpX5XOILe7aBJ/N00wL+u1S0lmazD/Zp7UdmOvcqlK8xj3I0Fz8ozJ9okM3uaWtemnJF3cd5Uoty20nsOomA92iHWlcO+DN7A2rAb0I5O3dG4Gcs0rL9EewatrNz4x6G8Mzp5zvGhTARg2SNF2Xho5W4NJVDuF/FL8X02gLpqDlkfi/4ALCHjaExqmkjDISuNQVQIEr7Q+f3IMVbYrnS7ZVjwCUvUSFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=lEAp/s1F; dkim-atps=neutral; spf=pass (client-ip=2001:bf0:244:244::119; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org) smtp.mailfrom=avm.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=lEAp/s1F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=avm.de (client-ip=2001:bf0:244:244::119; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org)
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVXXj13Hlz3cBW
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:01:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143723; bh=wq/KSwJcA3hqLetMFo3dTHFYxjONcw4I7Ih9VV1gllk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lEAp/s1FGs3gh/G3BwLm92E1HCxjGWlqxsQSbz/j1CB+Vlb/y59DpH7suq9qWHqSS
	 sYNh9xzFzAwYyP3SKrKt2sCrYh94W00YkOJHULlnCDrzYXE+bJd6oNQ88ujEwWl/IW
	 WDyVvJrtHTQ4L2Ennx46mVzCXGqAvMhY+uWIILEA=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ab-2367-7f0000032729-7f0000019cd2-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:30 +0100
Subject: [PATCH 04/61] ext4: Prefer IS_ERR_OR_NULL over manual NULL check
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
Message-Id: <20260310-b4-is_err_or_null-v1-4-bd63b656022d@avm.de>
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
Cc: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2748; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=wq/KSwJcA3hqLetMFo3dTHFYxjONcw4I7Ih9VV1gllk=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXjBVZQh0oHFoS6hdf46zx6cg9yKqCoM11bV
 3iWUec0h4iJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF4wAKCRA0LQZT0ays
 29vPB/9f5lFIt+0FtFBJpiKbUGS7UgY9T4E/E6CJ5zu/RqCe6vd531NLZdsmBEosrdFBBXDX57H
 sd8LCXF/sp89Zga6l1XIWkSIeHW4dDtT/UJNpkUGlvpmR4wd6cIocUQ2SKJZm2I5Ny799jzRqsU
 77XwGSzBy8rHgewt3q+d77K7620aLC+ceQfquSvw5IkT7R5aPt+VaJGvb/4d0wK060SD2e3AbrD
 KG5aPg5rty9abqBDIFiMe9sH7jc7Ssmy8RQOhQUuB/vX9zXXRZULMf0v4sI8el0Gl3lDI9uBnpn
 7EXyqizDRxBWqqlsbAFrtlRuPcNXRB2sNpMKxVhp0my3RZH1
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-7D482E1F-03DD7EA2/0/0
X-purgate-type: clean
X-purgate-size: 2750
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: B884024C218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2587-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[tytso.mit.edu:query timed out];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[56];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,dilger.ca:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/ext4/fast_commit.c | 2 +-
 fs/ext4/mballoc.c     | 2 +-
 fs/ext4/namei.c       | 2 +-
 fs/ext4/symlink.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f575751f1cae430eead31afa4f7d03ade1099d4a..bc69ac1195acb823465e735572b8a21255d485f5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -320,7 +320,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 	if (ext4_fc_disabled(sb))
 		return;
 
-	if (handle && !IS_ERR(handle))
+	if (!IS_ERR_OR_NULL(handle))
 		tid = handle->h_transaction->t_tid;
 	else {
 		read_lock(&sbi->s_journal->j_state_lock);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20e9fdaf4301b61c9d54401ed95067db6b6b8173..d7f004817c1ff758e4e25f84b2c27238b7420f84 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2870,7 +2870,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 		    EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 ) {
 			bh = ext4_read_block_bitmap_nowait(sb, group, true);
-			if (bh && !IS_ERR(bh)) {
+			if (!IS_ERR_OR_NULL(bh)) {
 				if (!buffer_uptodate(bh) && cnt)
 					(*cnt)++;
 				brelse(bh);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c4b5e252af0efbfcbaf83688a32d445327a74a02..4fdfc81f79028a588b3c1f912bff5e8a52cd9f13 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -723,7 +723,7 @@ struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 		struct stats stats;
 		printk("%s%3u:%03u hash %8x/%8x ",levels?"":"   ", i, block, hash, range);
 		bh = ext4_bread(NULL,dir, block, 0);
-		if (!bh || IS_ERR(bh))
+		if (IS_ERR_OR_NULL(bh))
 			continue;
 		stats = levels?
 		   dx_show_entries(hinfo, dir, ((struct dx_node *) bh->b_data)->entries, levels - 1):
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 645240cc0229fe4a2eda4499ae4a834fe3bd3a66..b612262719ede35d2612c5834d2bef7f18215516 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -92,7 +92,7 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
 
 	if (!dentry) {
 		bh = ext4_getblk(NULL, inode, 0, EXT4_GET_BLOCKS_CACHED_NOWAIT);
-		if (IS_ERR(bh) || !bh)
+		if (IS_ERR_OR_NULL(bh))
 			return ERR_PTR(-ECHILD);
 		if (!ext4_buffer_uptodate(bh)) {
 			brelse(bh);

-- 
2.43.0


