Return-Path: <linux-erofs+bounces-3409-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHzIKUmTCmrL3gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3409-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 06:19:21 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BDB5659DD
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 06:19:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJl163N8jz2xfB;
	Mon, 18 May 2026 14:18:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779077930;
	cv=none; b=Hg9uNJ3KCwBWUPCobQxFLPL4vvb6yURAFPY9tyjwDd+HxMRV1oij+UpwaU6dXU3kmfXmFyd/ZK7CG9vaunQsoJVPzufAt+yPslKJoKSJi7II2xWKqTwNUUN0lwY3CnO3wnAdxT7otYnuVaMqqs69vOC/nxBmAUg6yt1QNXua/8q8bVFegfBFHukEekmWhMOQkbf7Jpol3poajJTUYwVjweO/FgU8nvtVUBVY1SQLR0zHsmPJN5G6DtMppjypZLKkYtaOvm8VxCKUIriT1GE56Azaa7Y3/5iZP+QVOYTLxZyIxuUHwwRKRvpIyAm+23jk5PpAJfZi2v3Xh0EzWLpCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779077930; c=relaxed/relaxed;
	bh=ytp+fDBw2liGaMlB67MJhnJrhArdI1RgYJ695XV8dX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEsOTgCbgNrnyRBVKMPxH04Xz2gVbZ7tM14VnGRYjU+x0TsEZBjOa0nwEZeh22zh5jTN1Wb0n0axjbJRZOgk424xIvgRBXMT0s0u/SduJBDDaS1hJQnn4K1/iahcwOVHUBXSbeKKbJ2XuNzFv6IdX3QgsbkruSvlLKXQKbacHFyuy4RN0p75NcZHGgt/05VRA0v0tHQw0l4QFN7TQachOpDh2dUFtwHMekxFlTgnQspK8Tgtj0HWVEk7TJWZczsviAUiP5tb+vlqL36M6DCsBaQvFLyINT5vVogvvd8ZM6OlIAXAc5GK3VfQ0SUXlHJ4BRk/24LHQLipPDRJtcg5pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CM7y3x0M; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CM7y3x0M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJl130Rk3z2xWP
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 14:18:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779077921; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ytp+fDBw2liGaMlB67MJhnJrhArdI1RgYJ695XV8dX8=;
	b=CM7y3x0MEtzTI8t8rugcQur2wkMngnsmUNLecpH6Wf9gtgPYzWSK7MKseSiAKdqhEOM0x2JapX0uyu+2P8dfXyVK6rCdCWP4KrZVFnKvAsbOVgXZWuh8zGIHOU7ffMc4D7kvUS0to1/YyC2+r1ed7n/hqzid41DXIIOHHGEOR3E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X336a36_1779077917;
Received: from 30.221.130.166(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X336a36_1779077917 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 12:18:37 +0800
Message-ID: <91d164b2-adac-4f17-970b-698e500f84a2@linux.alibaba.com>
Date: Mon, 18 May 2026 12:18:33 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: mkfs: also handle last compacted 2B pack in
 z_erofs_drop_inline_pcluster
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, ke.wang@unisoc.com,
 linux-erofs@lists.ozlabs.org
References: <1777449565-22154-1-git-send-email-zhiguo.niu@unisoc.com>
 <e4701c42-1ed5-40a6-8f5d-927c40e3856b@linux.alibaba.com>
 <CAHJ8P3KB02f2dTWrMXtyBMQwfqmFEeOwa4SW8CKL-rKrE=Dg=w@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHJ8P3KB02f2dTWrMXtyBMQwfqmFEeOwa4SW8CKL-rKrE=Dg=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 79BDB5659DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3409-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:niuzhiguo84@gmail.com,m:zhiguo.niu@unisoc.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

Hi Zhiguo,

On 2026/5/11 15:54, Zhiguo Niu wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> 于2026年5月11日周一 12:01写道：
>>
>> Hi Zhiguo,
>>
>> On 2026/4/29 15:59, Zhiguo Niu wrote:
>>> With ztailpacking enabled, the current process assumes that a compacted_4b_end
>>> always exists in the compacted pack. However, in some specific files, the
>>> compacted pack may not have a compacted_4b_end. This leads to an incorrect
>>> modification of the last compacted_2B entry, resulting in incorrect modification
>>> of its clusterofs. In subsequent fsck operations, incorrect parameters will
>>> affect the decompression of the penultimate pcluster.
>>>
>>> This patch determines whether the last entry of the current compacted pack
>>> belongs to compacted 2B or 4B and then updates the correct bits accordingly.
>>>
>>> Fixes: a7c1f0575ef8 ("erofs-utils: lib: refine tailpcluster compression approach")
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>
>> Sorry for late response.
>>
>> I do think the issue is valid, but either the previous
>> solution or the proposed one is ugly.
> 
> Hi Xiang,
> Yes it would be ideal if the same piece of common code could cover
> both scenarios.
> But I haven't figured it out yet, so I'll distinguish them like this for now. ^^
> thanks!
>>
Could you confirm if the following diff fixes the issue?


diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 9f3d0f9c35bc..0e4c2a9b53c7 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -218,6 +218,11 @@ typedef int64_t         s64;
  #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
  #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))

+static inline u32 get_unaligned_le16(const void *p)
+{
+	return le32_to_cpu(__get_unaligned_t(__le16, p));
+}
+
  static inline u32 get_unaligned_le32(const void *p)
  {
  	return le32_to_cpu(__get_unaligned_t(__le32, p));
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 450e2647cca7..2cc9cc8009aa 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -210,6 +210,12 @@ struct erofs_diskbuf;
  #define EROFS_INODE_DATA_SOURCE_RESVSP		3
  #define EROFS_INODE_DATA_SOURCE_REBUILD_BLOB	4

+enum erofs_idata_type {
+	EROFS_IDATA_TYPE_RAW,
+	EROFS_IDATA_TYPE_COMPRESSED_DEFAULT,
+	EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B,
+};
+
  #define EROFS_I_BLKADDR_DEV_ID_BIT		48

  struct erofs_inode {
@@ -262,7 +268,7 @@ struct erofs_inode {
  	unsigned short idata_size;
  	char datasource;
  	bool in_metabox;
-	bool compressed_idata;
+	char idata_type;
  	bool lazy_tailblock;
  	bool opaque;
  	/* OVL: non-merge dir that may contain whiteout entries */
diff --git a/lib/compress.c b/lib/compress.c
index 62d2672cb665..e171aee48c0b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -483,7 +483,7 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
  {
  	inode->z_advise |= Z_EROFS_ADVISE_INLINE_PCLUSTER;
  	inode->idata_size = len;
-	inode->compressed_idata = !raw;
+	inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_DEFAULT;

  	inode->idata = malloc(inode->idata_size);
  	if (!inode->idata)
@@ -980,7 +980,8 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
  					      &dummy_head, big_pcluster);
  		compacted_2b -= 16;
  	}
-	DBG_BUGON(compacted_2b);
+	if (!compacted_4b_end && inode->idata_size)
+		inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B;

  	/* generate compacted_4b_end */
  	while (compacted_4b_end > 1) {
@@ -1210,10 +1211,12 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)

  	h->h_advise = cpu_to_le16(le16_to_cpu(h->h_advise) &
  				  ~Z_EROFS_ADVISE_INLINE_PCLUSTER);
+	DBG_BUGON(inode->idata_size != le16_to_cpu(h->h_idata_size));
  	h->h_idata_size = 0;
+
  	if (!inode->eof_tailraw)
  		return;
-	DBG_BUGON(inode->compressed_idata != true);
+	DBG_BUGON(inode->idata_type != EROFS_IDATA_TYPE_RAW);

  	/* patch the EOF lcluster to uncompressed type first */
  	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
@@ -1224,18 +1227,26 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
  		di->di_advise = cpu_to_le16(type);
  	} else if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
  		/* handle the last compacted 4B pack */
-		unsigned int eofs, base, pos, v, lo;
+		unsigned int lclusterbits = inode->z_lclusterbits;
+		unsigned int lobits, eofs, base, pos, v;
  		u8 *out;

-		eofs = inode->extent_isize -
-			(4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
-		base = round_down(eofs, 8);
-		pos = 16 /* encodebits */ * ((eofs - base) / 4);
-		out = inode->compressmeta + base;
-		lo = erofs_blkoff(sbi, get_unaligned_le32(out + pos / 8));
-		v = (type << sbi->blkszbits) | lo;
-		out[pos / 8] = v & 0xff;
-		out[pos / 8 + 1] = v >> 8;
+		lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
+
+		if (inode->idata_type == EROFS_IDATA_TYPE_COMPRESSED_DEFAULT) {
+			eofs = inode->extent_isize -
+				(4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
+			base = round_down(eofs, 8);
+			pos = 16 /* encodebits */ * ((eofs - base) / 4);
+			out = inode->compressmeta + base + pos / 8;
+		} else {
+			out = inode->compressmeta + inode->extent_isize - 4 - 2;
+			lobits = 16 - 14 /* encodebits */ + lobits;
+		}
+		v = (get_unaligned_le16(out) & (BIT(lobits) - 1)) |
+			(type << lobits);
+		*out = v & 0xff;
+		*(out + 1) = v >> 8;
  	} else {
  		DBG_BUGON(1);
  		return;
@@ -1244,7 +1255,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
  	/* replace idata with prepared uncompressed data */
  	inode->idata = inode->eof_tailraw;
  	inode->idata_size = inode->eof_tailrawsize;
-	inode->compressed_idata = false;
+	inode->idata_type = EROFS_IDATA_TYPE_RAW;
  	inode->eof_tailraw = NULL;
  }

diff --git a/lib/inode.c b/lib/inode.c
index 735319e1d3bf..c225faa121e7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1043,7 +1043,7 @@ noinline:
  		if (is_inode_layout_compression(inode)) {
  			DBG_BUGON(!params->ztailpacking);
  			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
-				  inode->compressed_idata ? "" : "un",
+				  inode->idata_type == EROFS_IDATA_TYPE_RAW ? "un": "",
  				  inode->idata_size, inode->i_srcpath);
  			erofs_sb_set_ztailpacking(sbi);
  		} else {
@@ -1149,7 +1149,8 @@ static int erofs_write_tail_end(struct erofs_importer *im,
  		pos = erofs_btell(bh, true) - erofs_blksiz(sbi);

  		/* 0'ed data should be padded at head for 0padding conversion */
-		h0 = erofs_sb_has_lz4_0padding(sbi) && inode->compressed_idata;
+		h0 = erofs_sb_has_lz4_0padding(sbi) &&
+			inode->idata_type != EROFS_IDATA_TYPE_RAW;
  		DBG_BUGON(inode->idata_size > erofs_blksiz(sbi));

  		iov[h0] = (struct iovec) { .iov_base = inode->idata,




