Return-Path: <linux-erofs+bounces-2845-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFUxJOfSu2k4owIAu9opvQ
	(envelope-from <linux-erofs+bounces-2845-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 11:41:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD32C9A3F
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 11:41:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc2LV3wspz2ykV;
	Thu, 19 Mar 2026 21:41:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773916898;
	cv=none; b=LMMBOigXjLoRz5iNIrqMCQcQqATN1puAMYGVgb1s0ZctR9Fqdib/XHSKUiJrpRjdcGBYLi7b/C5lNRfLbBgWbPTAVjTM6ZoUuduWb8NsrljIGUolV59YdbLIpi5QhRgXxOEDUeyYT9vOyaZyUu14Qq2xZ8nhbR+w38QnUxEPw70ggm97meXeLMvnNHF0PWIl8gqSnSMyFpPgS2oeJFjv0vPykIa19FECxYQprSk556wW20giQgH+GpjYJfdPEfuWSt62uofaBSSivPJzYBicaL5/0SDL+JwAPYxah0MYMmQVB2S5A32wlxGOgfRbseDvaxPNZgTyqjuu8FrzBo4iQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773916898; c=relaxed/relaxed;
	bh=r0AyTBeGWm6dnBfLL+n/RLoZEYxAVSCEkReQ0WAxwm0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DcJF8o1IhWoxmF9YNJvFw40/gcW8bLq35vjmzPkCJGdOAS+sVXHYKfDbQaRAhwkErjFbEjtwgIL8HjMBDhTAMf5mE64PdSXweoj4sOSr/wADew9O3iCLNvY2kMv7RN41eZHrygybcpD+h9vZCI3z5wUL+XxQ71JngkSPUiErOPmHsP+duhsxzIQNuLxvy2vR6jPBUKDbOsVfS7ltqUaP7ZNHg0Fj4FRuyeGRar0UBLOvxy9N0eorLXpcmcuhBj06hb5KGPcjcxlnVOqzAx04ixAiylFEJuMs1dCpFe5CDv2B5W6Pi0O5TtavAmT2Si7v8fnXhvbGs4plkl4i6C2gkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=g3EQzgXC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=g3EQzgXC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc2LT1KhFz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 21:41:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EC13D43946;
	Thu, 19 Mar 2026 10:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FF1C19424;
	Thu, 19 Mar 2026 10:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773916893;
	bh=Crk/U+b27IGWj9k0ye8hbfMINeHbBOIaqKk8W0gOgfM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=g3EQzgXC5gDCQyoSEXrCsIo1TKv0qoMBYW501esXni33PMAvmkT7tS0yMXK0ilPJo
	 7Jt4rxV2BBDOh9a4AO8PqIdcGm8vdYRC+EPyjXgrjs0ZhqtQufffgoJgHFD3LgTPDa
	 uXVvPX1xexrEAe5VRD0C8R7bUkCX+MQS/A15/r/k=
Subject: Patch "erofs: fix inline data read failure for ztailpacking pclusters" has been added to the 6.12-stable tree
To: Hao_hao.Wang@unisoc.com,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,ke.wang@unisoc.com,linux-erofs@lists.ozlabs.org,niuzhiguo84@gmail.com,zhiguo.niu@unisoc.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 19 Mar 2026 11:41:17 +0100
In-Reply-To: <1773216869-2760-1-git-send-email-zhiguo.niu@unisoc.com>
Message-ID: <2026031917-drizzle-excursion-983f@gregkh>
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
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [2.30 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2845-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:Hao_hao.Wang@unisoc.com,m:gregkh@linuxfoundation.org,m:hsiangkao@linux.alibaba.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,m:niuzhiguo84@gmail.com,m:zhiguo.niu@unisoc.com,m:stable-commits@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[unisoc.com,linuxfoundation.org,linux.alibaba.com,lists.ozlabs.org,gmail.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,alibaba.com:email,unisoc.com:email,ozlabs.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 40CD32C9A3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    erofs: fix inline data read failure for ztailpacking pclusters

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-fix-inline-data-read-failure-for-ztailpacking-pclusters.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-224650-greg=kroah.com@vger.kernel.org Wed Mar 11 09:17:27 2026
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
Date: Wed, 11 Mar 2026 16:14:29 +0800
Subject: erofs: fix inline data read failure for ztailpacking pclusters
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
Cc: <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>, <Hao_hao.Wang@unisoc.com>, <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
Message-ID: <1773216869-2760-1-git-send-email-zhiguo.niu@unisoc.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit c134a40f86efb8d6b5a949ef70e06d5752209be5 ]

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
Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -787,6 +787,7 @@ static int z_erofs_pcluster_begin(struct
 	struct super_block *sb = fe->inode->i_sb;
 	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
 	struct z_erofs_pcluster *pcl = NULL;
+	void *ptr = NULL;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -807,6 +808,14 @@ static int z_erofs_pcluster_begin(struct
 	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
+	} else {
+		ptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
+		if (IS_ERR(ptr)) {
+			erofs_err(sb, "failed to read inline data %pe @ pa %llu of nid %llu",
+				  ptr, map->m_pa, EROFS_I(fe->inode)->nid);
+			return PTR_ERR(ptr);
+		}
+		ptr = map->buf.page;
 	}
 
 	if (pcl) {
@@ -836,16 +845,8 @@ static int z_erofs_pcluster_begin(struct
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		void *mptr;
-
-		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
-		if (IS_ERR(mptr)) {
-			ret = PTR_ERR(mptr);
-			erofs_err(sb, "failed to get inline data %d", ret);
-			return ret;
-		}
-		get_page(map->buf.page);
-		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
+		get_page((struct page *)ptr);
+		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, ptr);
 		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}


Patches currently in stable-queue which might be from zhiguo.niu@unisoc.com are

queue-6.12/erofs-fix-inline-data-read-failure-for-ztailpacking-pclusters.patch
queue-6.12/f2fs-compress-fix-uaf-of-f2fs_inode_info-in-f2fs_free_dic.patch
queue-6.12/f2fs-compress-change-the-first-parameter-of-page_array_-alloc-free-to-sbi.patch

