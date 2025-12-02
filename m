Return-Path: <linux-erofs+bounces-1478-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4914C9ABB6
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 09:43:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLDnl1JXRz3bpt;
	Tue, 02 Dec 2025 19:43:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764665019;
	cv=none; b=NjQ91wGQ4OmiKBLs238qeKRWlw/W27QV87OZkUuqTb462zRODqefaghryDuRUZ6Ig5LBn/dG8y9MdxEtR1t8TJdMe+XAoDepsboenn5UTLnXPNH86Ajq1o8OrDgJMmr89jIBVSOVfss2IuAiiqtj1vDbl8bu9GwnagDn+Pmw/3eOqcEMTMPDWM3q9nppVguy898JkoskHQkvivZ61JgDO4fvxaO1VXeaOJYHi+HVLhEDQdzZV2jG7GyX/M2jt2TMvlxWO6GbP8J2St8HmrGtXmsmSfJffPMt3SUb7l3gfbDkHCLy2emSEGOYhfALLumOnIpA0aqy+vV/EM1H0Ycx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764665019; c=relaxed/relaxed;
	bh=LRcU8tiyrmCBUiZTFdv4DtPjK3mY256/RvyvSTXdzX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnsEtS1OrfRM+UPf2/KNpmZrTQUMJJo+UAR6/a7y+R6OfaklsLqVokMXHrIcscrWaXvpH5Z90FBOSVKTHNgivQo/DdhgPi/5TxPGP77h1CiKB1HbvRfMNBs8L4rmdie8Vgs8dLRNBHy3lDMECLUxvKigtgHbiSOh48X2MrLVVpiCxi8v14t+TW422hDCL8chsqMAnXbLfBDU01ikOQAfo28LeT+K6ZlLUxyMqTLfTXNZfHpH9qy8veKSCXeV85ihGTJqzodgQBfULOxCiePevb0eGfL0tVHFX5+dT1EjPj3fpKaV9K2Fk65EoTxz3IpGJ6TqYvZSMvGRNzJT3G3pWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NTjxLeFZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NTjxLeFZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLDnj22xlz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 19:43:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764665011; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LRcU8tiyrmCBUiZTFdv4DtPjK3mY256/RvyvSTXdzX8=;
	b=NTjxLeFZoq8DYGiXQSIrQVhscIbr5xBTZLYqfx4VMAuHnakTlmJQyJpKlzwF7DpN8mxtAecfvnaXA5J8D+LWboO1iykVNGBuU9LkeJpRL/s7o9Os+qwzhwxttaHhx9+HUOXcKaE/cbCulg0ur1cWVCzZ92bCmfpCdTCyULLffBk=
Received: from 30.221.131.182(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wtvogw9_1764665009 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 16:43:29 +0800
Message-ID: <867d5e84-a0e6-4ff5-a0e0-b514578fc7fc@linux.alibaba.com>
Date: Tue, 2 Dec 2025 16:43:29 +0800
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
Subject: Re: [bug report] erofs: enable error reporting for
 z_erofs_fixup_insize()
To: Dan Carpenter <dan.carpenter@linaro.org>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
References: <aS6kC82aalX854i8@stanley.mountain>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aS6kC82aalX854i8@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Dan,

On 2025/12/2 16:32, Dan Carpenter wrote:
> Hello Gao Xiang,
> 
> Commit 30e13e41a0eb ("erofs: enable error reporting for
> z_erofs_fixup_insize()") from Nov 27, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> fs/erofs/decompressor.c:217 z_erofs_lz4_decompress_mem() warn: 'reason' isn't an ERR_PTR
> fs/erofs/decompressor_lzma.c:193 z_erofs_lzma_decompress() warn: 'reason' is an error pointer or valid
> fs/erofs/decompressor_zstd.c:180 z_erofs_zstd_decompress() warn: 'reason' is an error pointer or valid
> 
> fs/erofs/decompressor.c
>      198 static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst)
>      199 {
>      200         bool support_0padding = false, may_inplace = false;
>      201         unsigned int inputmargin;
>      202         u8 *out, *headpage, *src;
>      203         const char *reason;
>      204         int ret, maptype;
>      205
>      206         DBG_BUGON(*rq->in == NULL);
>      207         headpage = kmap_local_page(*rq->in);
>      208
>      209         /* LZ4 decompression inplace is only safe if zero_padding is enabled */
>      210         if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
>      211                 support_0padding = true;
>      212                 reason = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
>      213                                 min_t(unsigned int, rq->inputsize,
>      214                                       rq->sb->s_blocksize - rq->pageofs_in));
>      215                 if (reason) {
>      216                         kunmap_local(headpage);
> --> 217                         return IS_ERR(reason) ? PTR_ERR(reason) : -EFSCORRUPTED;
>      218                 }
> 
> The z_erofs_fixup_insize() function used to return error pointers, but
> now it returns an error string or NULL.  So probably we could just
> change this to:
> 
> 		return -EFSCORRUPTED;

I think `return -EFSCORRUPTED;` is valid for now, but later
z_erofs_lz4_decompress_mem() will be changed into returning
`const char *` as well but it's late for this cycle.

> 
> Are we planning to make it return error pointers again?

z_erofs_lz4_decompress_mem() will be `const char *` later too
along with other cleanups, but it's somewhat late for this cycle.

> 
> NULL means success in this case, right?  It's sort of weird how NULL means
> success and a valid pointer means failure.

Because -EFSCORRUPTED isn't enough to represent the detailed
decompression errors (because each decompressor has its own
error messages and it's helpful for users to know how the
compressed data is corrupted).

NULL means success, and both valid pointers or error pointers
!= NULL means failure, so personally I don't think it's weird.

A valid pointer indicates an detailed error string to be
printed so that users know the detailed reasons and the error
number is -EFSCORRUPTED.

Thanks,
Gao Xiang

