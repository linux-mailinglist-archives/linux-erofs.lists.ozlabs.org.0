Return-Path: <linux-erofs+bounces-1479-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0FCC9ABFB
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 09:48:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLDtn47Lvz3bq4;
	Tue, 02 Dec 2025 19:48:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764665281;
	cv=none; b=Qa/fGzXp/H0HUsRzYGsuunjz7u3ks4+o3Tqdx4fweBEzLeiCI/BcbQ0j0C/w0FvifCWIMGv32zYNY4cIXNEgbLZxvW4NE5vHQ20d9cSn9N5PWyoZzw+v5ZRMeXA2bdvlYVVTLVhc+NJe2YSu0rxrwc6MzfIdhw4FGwNfUNaMlUEAcdxGy340LY67iUcBxsiOgVWoLUx4YMvyyLMCu+93Svc7WZ9oXNYttHu8VEsH0E24XfQVZgYwyyNnLDpL0LHGIjpq9Be1xg4Mr2aFYM1nMQcRKP9hI8feI/LEZS1hIfNXEUl3Yt4G+rjnoT4zTlzy0p0hnwUGKk21O89LaT+K9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764665281; c=relaxed/relaxed;
	bh=7BGIKeSzDh3HEnU190X5Mw/BhZ6+fuhgo2GT1iDaSSw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y09PVKr1t9p4a1qlep//wo/kAIJLfrafxvhe9p57flxmLtsmQfTvaJzyaggVVvXa6JYpUxuF9S0pNC+DPCCFUR3QzN4PAcFAw4dTXAuCZxgc6so3HOJJguWRXQ4CNsz3o0mPdoLCmx3D18C6Wu47dWAtT7gmVPNxSn73yj1RK4V4qHTfSYl3RxvvBOFMsy5HkpYJ9wlrl6QdKUoin0Sev2UQF8QMdY3khxS7RiI8rtGTpH2H9WhW+STEkQLiybMs7GPT/S/Qi0IdKyfl4/V4eEx74X04Z63+Vbzlslx0iElm+wnjVDcjPF2M7Hw1yBS7O7y/gQgEQPp4LuXe/NxdiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CxP1fRsS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CxP1fRsS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLDtm4r79z3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 19:48:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764665276; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=7BGIKeSzDh3HEnU190X5Mw/BhZ6+fuhgo2GT1iDaSSw=;
	b=CxP1fRsSsHQzdWyETup68YIB4/34zXLtk3cZho/HStCIyPTO75Q6I+OcnTLZp7jIm5+d217hEgBx8n1Q2LxkE0e2u6FPoH8eKjgFVqDQ9lOfYEdTQLOMrQz+TP9ggrTNq57zAK8f4vKQKZTq7Ij4LoqgX+BORHxfBFlSgSFfgro=
Received: from 30.221.131.182(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wtvmrcx_1764665274 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 16:47:54 +0800
Message-ID: <fd00a606-2f62-4222-b8a8-4c12602c3141@linux.alibaba.com>
Date: Tue, 2 Dec 2025 16:47:54 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
References: <aS6kC82aalX854i8@stanley.mountain>
 <867d5e84-a0e6-4ff5-a0e0-b514578fc7fc@linux.alibaba.com>
In-Reply-To: <867d5e84-a0e6-4ff5-a0e0-b514578fc7fc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/2 16:43, Gao Xiang wrote:
> Hi Dan,
> 
> On 2025/12/2 16:32, Dan Carpenter wrote:
>> Hello Gao Xiang,
>>
>> Commit 30e13e41a0eb ("erofs: enable error reporting for
>> z_erofs_fixup_insize()") from Nov 27, 2025 (linux-next), leads to the
>> following Smatch static checker warning:
>>
>> fs/erofs/decompressor.c:217 z_erofs_lz4_decompress_mem() warn: 'reason' isn't an ERR_PTR
>> fs/erofs/decompressor_lzma.c:193 z_erofs_lzma_decompress() warn: 'reason' is an error pointer or valid
>> fs/erofs/decompressor_zstd.c:180 z_erofs_zstd_decompress() warn: 'reason' is an error pointer or valid

BTW, I don't think any issue out of `fs/erofs/decompressor_lzma.c`
and `fs/erofs/decompressor_zstd.c`.

"reason != NULL" means failure, so it will break and propagate to
the caller.

>>
>> fs/erofs/decompressor.c
>>      198 static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst)
>>      199 {
>>      200         bool support_0padding = false, may_inplace = false;
>>      201         unsigned int inputmargin;
>>      202         u8 *out, *headpage, *src;
>>      203         const char *reason;
>>      204         int ret, maptype;
>>      205
>>      206         DBG_BUGON(*rq->in == NULL);
>>      207         headpage = kmap_local_page(*rq->in);
>>      208
>>      209         /* LZ4 decompression inplace is only safe if zero_padding is enabled */
>>      210         if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
>>      211                 support_0padding = true;
>>      212                 reason = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
>>      213                                 min_t(unsigned int, rq->inputsize,
>>      214                                       rq->sb->s_blocksize - rq->pageofs_in));
>>      215                 if (reason) {
>>      216                         kunmap_local(headpage);
>> --> 217                         return IS_ERR(reason) ? PTR_ERR(reason) : -EFSCORRUPTED;
>>      218                 }
>>
>> The z_erofs_fixup_insize() function used to return error pointers, but
>> now it returns an error string or NULL.  So probably we could just
>> change this to:
>>
>>         return -EFSCORRUPTED;
> 
> I think `return -EFSCORRUPTED;` is valid for now, but later
> z_erofs_lz4_decompress_mem() will be changed into returning
> `const char *` as well but it's late for this cycle.
> 
>>
>> Are we planning to make it return error pointers again?
> 
> z_erofs_lz4_decompress_mem() will be `const char *` later too
> along with other cleanups, but it's somewhat late for this cycle.
> 
>>
>> NULL means success in this case, right?  It's sort of weird how NULL means
>> success and a valid pointer means failure.
> 
> Because -EFSCORRUPTED isn't enough to represent the detailed
> decompression errors (because each decompressor has its own
> error messages and it's helpful for users to know how the
> compressed data is corrupted).
> 
> NULL means success, and both valid pointers or error pointers
> != NULL means failure, so personally I don't think it's weird.
> 
> A valid pointer indicates an detailed error string to be
> printed so that users know the detailed reasons and the error
> number is -EFSCORRUPTED.
> 
> Thanks,
> Gao Xiang


