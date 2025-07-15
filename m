Return-Path: <linux-erofs+bounces-627-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CDB069E8
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 01:32:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhb7q5kpdz30T3;
	Wed, 16 Jul 2025 09:32:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752622343;
	cv=none; b=YsW47+spoW1h1ah2oep33reQHvS8tBxRGYW4kM+NqtvsEhRsBfF0Ydfa19myK1hIzNG4yCnpDbIx3SFLAfunXZs9pOX84lOoeOqYuLOgupMZqyusqR2Hvp4WI0zPN3M71Y56ycaAcQnGWMm7O2LY1GspMivUcGDWXd2sXo8Hw83vFuVwuHpUPvYh/HsCEKCIlw9IMG87ZNdQ9N73cwiM6xEi8aW7Gs9Nvagcj8ss0wrFxIewhw87ZQydTMQrwcwzJU0Ip8saQi3S6he7hcOmKKhqRhEo9MOqiQFN76hNbu91GQfq5UscnPTgsg2RZKz0YUTN1AEkHvyTlA6ySTf76A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752622343; c=relaxed/relaxed;
	bh=nUy4PEMS4CazYHiywIu/1adtHnlC3QRDbiuwxgypLnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gJ2e4lJZ/OKKN9tRu2b9R7AuM1n0YD8zG0QjHUTtEfxSihvdxCxVqyWtUDKMr9kxhjpwonxcrzPKR5kDjcA1pDxhobz835cunlz3wjuaw0mkxHNAK/nitEUN1XA7CK2bEBjH4UuAPlcBoQ3t69RVBkICALC2Hq2yrhgbV2PHCmh4TS7z+pzzsVNTIGVYuTiCws4OQ0lX/7PC1POm07YI6rFFkCKuY1XJnCnFDUhK+CTKrRAkeBfOGCxYoFoiS0zZG6OWlKcOm5KHXQ9MaAlR0nzHeYLO+vFeRIamL9nvu8H13qMx9oSyBqvXc+RFjzlHTny79Mexsgz0esNEcBiIgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uVh9tRTK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uVh9tRTK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhb7m6Tw4z30T0
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 09:32:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752622334; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nUy4PEMS4CazYHiywIu/1adtHnlC3QRDbiuwxgypLnQ=;
	b=uVh9tRTKyYCBTKheLSpfjGOd5Ayv9BMukBadlr0pOkUwfpFNQLqGBvc6vKJ9GIa/TilYONz1fFTrTbzN4hkZHNhdZYPEPgj/zADJp5M2+PJYAWvJnShJK34IZKS+BMUf4yfCDXtNLVoY5g8fpxYnq76szlS/cfhWt7s1vh9eg0g=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj1gQiN_1752622331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 07:32:12 +0800
Message-ID: <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
Date: Wed, 16 Jul 2025 07:32:10 +0800
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
Subject: Re: Compressed files & the page cache
To: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>,
 Hailong Liu <hailong.liu@oppo.com>, Barry Song <21cnbao@gmail.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Matthew,

On 2025/7/16 04:40, Matthew Wilcox wrote:
> I've started looking at how the page cache can help filesystems handle
> compressed data better.  Feedback would be appreciated!  I'll probably
> say a few things which are obvious to anyone who knows how compressed
> files work, but I'm trying to be explicit about my assumptions.
> 
> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.  This would be a good
> point to stop reading and tell me about counterexamples.

At least the typical EROFS compresses variable-sized plaintext (at least
one block, e.g. 4k, but also 4k+1, 4k+2, ...) into fixed-sized compressed
blocks for efficient I/Os, which is really useful for small compression
granularity (e.g. 4KiB, 8KiB) because use cases like Android are usually
under memory pressure so large compression granularity is almost
unacceptable in the low memory scenarios, see:
https://erofs.docs.kernel.org/en/latest/design.html

Currently EROFS works pretty well on these devices and has been
successfully deployed in billions of real devices.

> 
>  From what I've been reading in all your filesystems is that you want to
> allocate extra pages in the page cache in order to store the excess data
> retrieved along with the page that you're actually trying to read.  That's
> because compressing in larger chunks leads to better compression.
> 
> There's some discrepancy between filesystems whether you need scratch
> space for decompression.  Some filesystems read the compressed data into
> the pagecache and decompress in-place, while other filesystems read the
> compressed data into scratch pages and decompress into the page cache.
> 
> There also seems to be some discrepancy between filesystems whether the
> decompression involves vmap() of all the memory allocated or whether the
> decompression routines can handle doing kmap_local() on individual pages.
> 
> So, my proposal is that filesystems tell the page cache that their minimum
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.  That removes all the
> extra code in filesystems to allocate extra memory in the page cache.> It means we don't attempt to track dirtiness at a sub-folio granularity
> (there's no point, we have to write back the entire compressed bock
> at once).  We also get a single virtually contiguous block ... if you're
> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> vmap_file() which would give us a virtually contiguous chunk of memory
> (and could be trivially turned into a noop for the case of trying to
> vmap a single large folio).

I don't see this will work for EROFS because EROFS always supports
variable uncompressed extent lengths and that will break typical
EROFS use cases and on-disk formats.

Other thing is that large order folios (physical consecutive) will
caused "increase the latency on UX task with filemap_fault()"
because of high-order direct reclaims, see:
https://android-review.googlesource.com/c/kernel/common/+/3692333
so EROFS will not set min-order and always support order-0 folios.

I think EROFS will not use this new approach, vmap() interface is
always the case for us.

Thanks,
Gao Xiang

> 


