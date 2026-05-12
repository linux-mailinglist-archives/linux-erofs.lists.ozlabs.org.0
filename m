Return-Path: <linux-erofs+bounces-3406-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAwLKaFkA2oq5gEAu9opvQ
	(envelope-from <linux-erofs+bounces-3406-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 19:34:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F609525E26
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 19:34:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFNxh6QvLz2xb3;
	Wed, 13 May 2026 03:34:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778607256;
	cv=none; b=SheUlmXAMmC434MoFfD7X1t/Dq2c3lqSqGczW3CHKM4U/irvm+dG5XXS/KPc1RN2UmKebB9FSSl1bWXcE2h4fwiTHzZcvNOMsfLmPiRAmQL0ZR4WZFmLDAycpptBvhei6TyxwX3AQ87Yuvti/JU/kl5tb48Qowh7G7rHFC7QeO/gwRU5ZvuEBvv6Ve5qgiAZWXeX5b0VZ6AINbWrYiBh3S6BuxHhxYAUvTLfwcr5OKGLxr1/DBlk7aqo3LAJHrcnYQz4wmW00r+lhdNvxlZp+aOvkpR13+7aIzFk17pWTk/PNhkGVdHFWbavyFFVF4XT7PsPP5SDblRvD2YZMpPMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778607256; c=relaxed/relaxed;
	bh=K4+/wSEKUqAD/W+/ff+9cKWqjXae45pN4NiFhl3U5Ms=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=OlqIuUgeDy2iBg9q1zO0SOnQ0W2W3oTwSW/VwC/thErNN6C89NycR7PzPU1A7k3aXxK5QPahZQSuynftLxKOj8f0jNlqbpJDZl43M8fZPnxMEBK3y1TuCnYl5K4gi1f+B/T8RTZdw13SJJrFozuxMk75ONja5B04iellEESjRw56Mt5MJH4G8X9vP9sJ/ofdXRD+2tL01w1elLt9pu+qSMkyO7c/iVFD42gtCJuA1x9pLgEFnFKZhkDG+8wLCNLJPkcAXz4EXqxH7pQRVdy8Gbu537/4jbqxftCo0Snp5dU2JbZ6xAr5vYkPTMl3OZkJTrsrMND7OAVva1JfKk8eUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TcLmvQxv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TcLmvQxv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFNxg2fYXz2xH9
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 May 2026 03:34:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D7CB343EF4;
	Tue, 12 May 2026 17:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A863C2BCB0;
	Tue, 12 May 2026 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607251;
	bh=y3wzO/A6RnjXu38ree/8JUlQqCjaIfDvgzE4Ar9RKyU=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=TcLmvQxvzwJqeHRTfPQ/igcqGie6bt6vh+JloYMmjnRMZn6Eldzu9hUsmcpxV+B7p
	 iw0IDOYIpaaqIYhXnDerLSk2pNlaIr9Mbw1YzJyS+O+cc7xKTvRL0BbP5Et8ETSBJZ
	 6jyQBH8wQXXSbf1l0O9Yf51bitvjsLG57UGGec5g=
Subject: Patch "fs: prepare for adding LSM blob to backing_file" has been added to the 6.12-stable tree
To: amir73il@gmail.com,gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org,paul@paul-moore.com,sashal@kernel.org,serge@hallyn.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 19:33:42 +0200
In-Reply-To: <20260505001614.127730-1-sashal@kernel.org>
Message-ID: <2026051242-unless-neatly-8b00@gregkh>
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
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 6F609525E26
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-3406-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:gregkh@linuxfoundation.org,m:linux-erofs@lists.ozlabs.org,m:paul@paul-moore.com,m:sashal@kernel.org,m:serge@hallyn.com,m:stable-commits@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,lists.ozlabs.org,paul-moore.com,kernel.org,hallyn.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,ozlabs.org:email,hallyn.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    fs: prepare for adding LSM blob to backing_file

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fs-prepare-for-adding-lsm-blob-to-backing_file.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-243940-greg=kroah.com@vger.kernel.org Tue May  5 02:16:25 2026
From: Sasha Levin <sashal@kernel.org>
Date: Mon,  4 May 2026 20:16:14 -0400
Subject: fs: prepare for adding LSM blob to backing_file
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20260505001614.127730-1-sashal@kernel.org>

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 880bd496ec72a6dcb00cb70c430ef752ba242ae7 ]

In preparation to adding LSM blob to backing_file struct, factor out
helpers init_backing_file() and backing_file_free().

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
[PM: use the term "LSM blob", fix comment style to match file]
Signed-off-by: Paul Moore <paul@paul-moore.com>
[ Used kfree() instead of kmem_cache_free(bfilp_cachep, ff) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/file_table.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -60,6 +60,12 @@ struct path *backing_file_user_path(stru
 }
 EXPORT_SYMBOL_GPL(backing_file_user_path);
 
+static inline void backing_file_free(struct backing_file *ff)
+{
+	path_put(&ff->user_path);
+	kfree(ff);
+}
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
@@ -67,8 +73,7 @@ static inline void file_free(struct file
 		percpu_counter_dec(&nr_files);
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_user_path(f));
-		kfree(backing_file(f));
+		backing_file_free(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -255,6 +260,12 @@ struct file *alloc_empty_file_noaccount(
 	return f;
 }
 
+static int init_backing_file(struct backing_file *ff)
+{
+	memset(&ff->user_path, 0, sizeof(ff->user_path));
+	return 0;
+}
+
 /*
  * Variant of alloc_empty_file() that allocates a backing_file container
  * and doesn't check and modify nr_files.
@@ -277,7 +288,14 @@ struct file *alloc_empty_backing_file(in
 		return ERR_PTR(error);
 	}
 
+	/* The f_mode flags must be set before fput(). */
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
+	error = init_backing_file(ff);
+	if (unlikely(error)) {
+		fput(&ff->file);
+		return ERR_PTR(error);
+	}
+
 	return &ff->file;
 }
 


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-6.12/rxrpc-also-unshare-data-response-packets-when-paged-.patch
queue-6.12/mm-convert-mm_lock_seq-to-a-proper-seqcount.patch
queue-6.12/fs-prepare-for-adding-lsm-blob-to-backing_file.patch
queue-6.12/dma-mapping-drop-unneeded-includes-from-dma-mapping.h.patch
queue-6.12/mmc-core-optimize-time-for-secure-erase-trim-for-some-kingston-emmcs.patch
queue-6.12/x86-shadow-stacks-proper-error-handling-for-mmap-loc.patch
queue-6.12/net-txgbe-fix-rtnl-assertion-warning-when-remove-mod.patch
queue-6.12/erofs-move-in-out-pages-into-struct-z_erofs_decompress_req.patch
queue-6.12/dma-mapping-add-__dma_from_device_group_begin-end.patch
queue-6.12/rxrpc-fix-conn-level-packet-handling-to-unshare-resp.patch
queue-6.12/iommu-amd-use-atomic64_inc_return-in-iommu.c.patch
queue-6.12/crypto-nx-migrate-to-scomp-api.patch
queue-6.12/alsa-aloop-fix-peer-runtime-uaf-during-format-change-stop.patch
queue-6.12/udf-fix-partition-descriptor-append-bookkeeping.patch
queue-6.12/bluetooth-l2cap-fix-deadlock-in-l2cap_conn_del.patch
queue-6.12/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
queue-6.12/hfsplus-fix-uninit-value-by-validating-catalog-record-size.patch
queue-6.12/crypto-nx-fix-bounce-buffer-leaks-in-nx842_crypto_-alloc-free-_ctx.patch
queue-6.12/gtp-disable-bh-before-calling-udp_tunnel_xmit_skb.patch
queue-6.12/net-stmmac-avoid-shadowing-global-buf_sz.patch
queue-6.12/crypto-caam-guard-hmac-key-hex-dumps-in-hash_digest_key.patch
queue-6.12/hfsplus-fix-held-lock-freed-on-hfsplus_fill_super.patch
queue-6.12/octeon_ep_vf-add-null-check-for-napi_build_skb.patch
queue-6.12/printk-add-print_hex_dump_devel.patch
queue-6.12/net-af_key-zero-aligned-sockaddr-tail-in-pf_key-expo.patch
queue-6.12/tracepoint-balance-regfunc-on-func_add-failure-in-tracepoint_add_func.patch
queue-6.12/flow_dissector-do-not-dissect-pppoe-pfc-frames.patch
queue-6.12/fbdev-defio-disconnect-deferred-i-o-from-the-lifetime-of-struct-fb_info.patch
queue-6.12/erofs-tidy-up-z_erofs_lz4_handle_overlap.patch
queue-6.12/iommu-amd-serialize-sequence-allocation-under-concur.patch
queue-6.12/x86-shstk-prevent-deadlock-during-shstk-sigreturn.patch
queue-6.12/erofs-fix-unsigned-underflow-in-z_erofs_lz4_handle_overlap.patch
queue-6.12/net-stmmac-prevent-null-deref-when-rx-memory-exhausted.patch
queue-6.12/net-stmmac-rename-stmmac_get_entry-stmmac_next_entry.patch
queue-6.12/mtd-spinand-winbond-declare-the-qe-bit-on-w25nxxjw.patch
queue-6.12/hwmon-powerz-avoid-cacheline-sharing-for-dma-buffer.patch
queue-6.12/wifi-mt76-mt7925-fix-incorrect-tlv-length-in-clc-command.patch

