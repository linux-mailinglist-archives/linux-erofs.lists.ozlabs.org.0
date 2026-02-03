Return-Path: <linux-erofs+bounces-2251-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMWCDROvgWn+IgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2251-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Feb 2026 09:17:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA04D6202
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Feb 2026 09:17:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4xDG6TRBz2xdL;
	Tue, 03 Feb 2026 19:17:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770106638;
	cv=none; b=DEl3ee+0f2pIsgPdbE1RjFb7aauQdO4EAzctMhPnmetwAtPAflkxKhhWSR2rnMkBXImIXmY2E7CoiwZXgYp4RTAECb2BcRhOkUSiI9vq+sLP5CTtJ/+dnNF6HKQfhMALKomj5J69BsNxH7HR9YxtgCcM1uBVRub4RXCdmPMclg94gxxli/EZK888TTJI0kweRfUUlKWMgSrSkNPQGtN5Jh44TdqwFa2B4KaV7y+RTZdoAGJcM44IhIoklBVQ4Qzk9pOyCc4O5s4Ru8eJxGk/hjWgNuxuFTcjvVbftby4I313P+lHy1EYpIQC1SBQo5hAIgUmPqp54u63yj10M2SY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770106638; c=relaxed/relaxed;
	bh=ZYEgjxmJ3iIFuceax46uWWA5yrD+Novk/fxD9M513G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l06SwEge4EL/wnar16F9g8hmUZyqytJlcIkocqMRrK105IcxY2X1/UaaG9C+Zq8MmqBKjwOobDSbVRAtBNg0pbp/TZTodxwyKiGqjV7Xz0mYZfj/VA5VmVZvjz/ZKk0M9DY/1HrKUDSQDQsApAesH1h9y1HAcvRWM/z2mrVmwne+mfzYJ6CdV3mhAAgd4F3rzE5qWEt9If+rWB7lQl3v3GAGjJlLcrY703MkLC1JZMYSsrWgnOse9p1YKinqAjlbugLLh3UZKYvakG2Jp2k0unNmYEJVsaigkfZ79thNkGkzCVgGcKV4a12Nd6HxeVc0O6m+zOuOlc2Ao3UcrrfO2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J2dDuv8B; dkim-atps=neutral; spf=pass (client-ip=47.90.199.7; helo=out199-7.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J2dDuv8B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.7; helo=out199-7.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4xDB56Yhz2xQD
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Feb 2026 19:17:13 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770106616; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZYEgjxmJ3iIFuceax46uWWA5yrD+Novk/fxD9M513G4=;
	b=J2dDuv8BlgSzBNag4BNb47KOheFBmDY/VNlOpWacyDBaI1BOikm83/bLtzllW1hwm+Szz/p2ds4kZiVFuvfDQgOvmiHtVEPyLgveA7dm7ivpqa0auSmgga51vftSArjLpQNlSoLKNKtNfhBduGEgg64qUMInMUvUSnHE5KSLKZo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WySLkKC_1770106604 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Feb 2026 16:16:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH] erofs: fix inline data read failure for ztailpacking pclusters
Date: Tue,  3 Feb 2026 16:16:43 +0800
Message-ID: <20260203081643.954474-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2251-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 8AA04D6202
X-Rspamd-Action: no action

Compressed folios for ztailpacking pclusters must be valid before adding
these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
may assume they are already valid and then trigger a NULL pointer
dereference.

It is somewhat hard to reproduce because the inline data is in the same
block as the tail of the compressed indexes, which are usually read just
before. However, it may still happen if a fatal signal arrives while
read_mapping_folio() is running, as shown below:

 erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline data -4
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008

 ...

 pc : z_erofs_decompress_queue+0x4c8/0xa14
 lr : z_erofs_decompress_queue+0x160/0xa14
 sp : ffffffc08b3eb3a0
 x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
 x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
 x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
 x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
 x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
 x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
 x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
 x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
 x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
 x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  z_erofs_decompress_queue+0x4c8/0xa14
  z_erofs_runqueue+0x908/0x97c
  z_erofs_read_folio+0x128/0x228
  filemap_read_folio+0x68/0x128
  filemap_get_pages+0x44c/0x8b4
  filemap_read+0x12c/0x5b8
  generic_file_read_iter+0x4c/0x15c
  do_iter_readv_writev+0x188/0x1e0
  vfs_iter_read+0xac/0x1a4
  backing_file_read_iter+0x170/0x34c
  ovl_read_iter+0xf0/0x140
  vfs_read+0x28c/0x344
  ksys_read+0x80/0xf0
  __arm64_sys_read+0x24/0x34
  invoke_syscall+0x60/0x114
  el0_svc_common+0x88/0xe4
  do_el0_svc+0x24/0x30
  el0_svc+0x40/0xa8
  el0t_64_sync_handler+0x70/0xbc
  el0t_64_sync+0x1bc/0x1c0

Fix this by reading the inline data before allocating and adding
the pclusters to the I/O chains.

Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 20d7df31a51f..3b6d078c5ba3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -806,14 +806,27 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
 	struct z_erofs_pcluster *pcl = NULL;
-	void *ptr;
+	void *ptr = NULL;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
 	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
 	DBG_BUGON(!fe->head);
 
-	if (!(map->m_flags & EROFS_MAP_META)) {
+	if (map->m_flags & EROFS_MAP_META) {
+		ret = erofs_init_metabuf(&map->buf, sb,
+					 erofs_inode_in_metabox(fe->inode));
+		if (ret)
+			return ret;
+		ptr = erofs_bread(&map->buf, map->m_pa, false);
+		if (IS_ERR(ptr)) {
+			erofs_err(sb, "failed to read inline data %pe @ pa %llu of nid %llu",
+				  ptr, map->m_pa, EROFS_I(fe->inode)->nid);
+			return PTR_ERR(ptr);
+		}
+		folio_get(page_folio(map->buf.page));
+		ptr = map->buf.page;
+	} else {
 		while (1) {
 			rcu_read_lock();
 			pcl = xa_load(&EROFS_SB(sb)->managed_pslots, map->m_pa);
@@ -853,18 +866,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		ret = erofs_init_metabuf(&map->buf, sb,
-					 erofs_inode_in_metabox(fe->inode));
-		if (ret)
-			return ret;
-		ptr = erofs_bread(&map->buf, map->m_pa, false);
-		if (IS_ERR(ptr)) {
-			ret = PTR_ERR(ptr);
-			erofs_err(sb, "failed to get inline folio %d", ret);
-			return ret;
-		}
-		folio_get(page_folio(map->buf.page));
-		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
+		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, ptr);
 		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}
-- 
2.43.5


