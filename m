Return-Path: <linux-erofs+bounces-628-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C1B06A68
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 02:28:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhcNS5W8nz30T3;
	Wed, 16 Jul 2025 10:28:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752625704;
	cv=none; b=cCV1CwVnrKLhnYSx76u8YfgtVcMUt/6+7bh0uR6rmxElLCtXCmRDGpgLxB7rmrZ+0YznCnsB8/vp/4jXN9tZthC+5n2GlWXiWUDYVyQiRdeOBiW7JQPeZ0p6ooqLYGW4E13PB6Nlu2O54Y3j48D/fHYHfvhfKrZdyDAa2WwWxXEIjGXwtF4TrwVYXMURLYBKKbnQG6ZpJEe5d7hIUAcMmOo4NOY8HXypvSfSQItGEKmi1I/CtA9Aybk/cyZFfTlE+keCqwrhplq1Tti0S4tQdGnmfi9cDnGJXJv2iC/yaDObghd4qUZ4y8fypbND/A1tLWVmxj2wX3w5u3G7BVuYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752625704; c=relaxed/relaxed;
	bh=LbjcxXFKh7BwDlSh88rF8t3KBJnwLKqPh8QSBj+K9Y8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=M3K8OjVRT9BNDM1suDYzg77K0uaEyUyndbvYBbQ+lFHU02wg2FSudSrXAflHGMBuAzJfSI4JR+d0PcU2ErPt+FvkJWByLrWN31yopHMuJtvMLvesjb9OauxlJog+K/ak0NXwNZ7vNVMbb9/be9Oz/wqsMrmLBmdK4nVuXfY1fE7wiIrW6ZxBDRc5zMBYYvww6QOeyAsBbCm8jsm4uYq5oUvIv8EcfPosLJk5DvKDI54CBPDlLsvTBlUoN6+xDoUtOHKo3tKFrVzMGcOLRIK/DqwdGetV7HGMp5iAo0qxmyfBqRLKfsTpBjOzaL00ANr0wWMnKoUcekB8HaDqk+S4gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oNO8LIxJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oNO8LIxJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhcNQ59Ptz2xd3
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 10:28:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752625698; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=LbjcxXFKh7BwDlSh88rF8t3KBJnwLKqPh8QSBj+K9Y8=;
	b=oNO8LIxJ9JKzFhhufSxxzDFVSYo+r5lJyctwIsPNfTE4pjJWxDp8ALbNDauIeSoY1+yhEvRKIiaB2h51jf+0ypYmfuLEo+YXZT0PLwPG3NMyYmB8tdFUsQoYLXtSOlzKo0ptsdnC3YcAr8HiKGOR8wnJLKGPdS8IDGASPyKzibY=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj1msOW_1752625684 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 08:28:15 +0800
Message-ID: <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
Date: Wed, 16 Jul 2025 08:28:04 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
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
 Hailong Liu <hailong.liu@oppo.com>, Barry Song <21cnbao@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
In-Reply-To: <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/16 07:32, Gao Xiang wrote:
> Hi Matthew,
> 
> On 2025/7/16 04:40, Matthew Wilcox wrote:
>> I've started looking at how the page cache can help filesystems handle
>> compressed data better.  Feedback would be appreciated!  I'll probably
>> say a few things which are obvious to anyone who knows how compressed
>> files work, but I'm trying to be explicit about my assumptions.
>>
>> First, I believe that all filesystems work by compressing fixed-size
>> plaintext into variable-sized compressed blocks.  This would be a good
>> point to stop reading and tell me about counterexamples.
> 
> At least the typical EROFS compresses variable-sized plaintext (at least
> one block, e.g. 4k, but also 4k+1, 4k+2, ...) into fixed-sized compressed
> blocks for efficient I/Os, which is really useful for small compression
> granularity (e.g. 4KiB, 8KiB) because use cases like Android are usually
> under memory pressure so large compression granularity is almost
> unacceptable in the low memory scenarios, see:
> https://erofs.docs.kernel.org/en/latest/design.html
> 
> Currently EROFS works pretty well on these devices and has been
> successfully deployed in billions of real devices.
> 
>>
>>  From what I've been reading in all your filesystems is that you want to
>> allocate extra pages in the page cache in order to store the excess data
>> retrieved along with the page that you're actually trying to read.  That's
>> because compressing in larger chunks leads to better compression.
>>
>> There's some discrepancy between filesystems whether you need scratch
>> space for decompression.  Some filesystems read the compressed data into
>> the pagecache and decompress in-place, while other filesystems read the
>> compressed data into scratch pages and decompress into the page cache.
>>
>> There also seems to be some discrepancy between filesystems whether the
>> decompression involves vmap() of all the memory allocated or whether the
>> decompression routines can handle doing kmap_local() on individual pages.
>>
>> So, my proposal is that filesystems tell the page cache that their minimum
>> folio size is the compression block size.  That seems to be around 64k,
>> so not an unreasonable minimum allocation size.  That removes all the
>> extra code in filesystems to allocate extra memory in the page cache.> It means we don't attempt to track dirtiness at a sub-folio granularity
>> (there's no point, we have to write back the entire compressed bock
>> at once).  We also get a single virtually contiguous block ... if you're
>> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
>> vmap_file() which would give us a virtually contiguous chunk of memory
>> (and could be trivially turned into a noop for the case of trying to
>> vmap a single large folio).
> 
> I don't see this will work for EROFS because EROFS always supports
> variable uncompressed extent lengths and that will break typical
> EROFS use cases and on-disk formats.
> 
> Other thing is that large order folios (physical consecutive) will
> caused "increase the latency on UX task with filemap_fault()"
> because of high-order direct reclaims, see:
> https://android-review.googlesource.com/c/kernel/common/+/3692333
> so EROFS will not set min-order and always support order-0 folios.
> 
> I think EROFS will not use this new approach, vmap() interface is
> always the case for us.

... high-order folios can cause side effects on embedded devices
like routers and IoT devices, which still have MiBs of memory (and I
believe this won't change due to their use cases) but they also use
Linux kernel for quite long time.  In short, I don't think enabling
large folios for those devices is very useful, let alone limiting
the minimum folio order for them (It would make the filesystem not
suitable any more for those users.  At least that is what I never
want to do).  And I believe this is different from the current LBS
support to match hardware characteristics or LBS atomic write
requirement.

BTW, AFAIK, there are also compression optimization tricks related
to COW (like what Btrfs currently does) or write optimizations,
which would also break this.

For example, recompressing an entire compressed extent when a user
updates just one specific file block (consider random data updates)
is inefficient. Filesystems may write the block as uncompressed data
initially (since recompressing the whole extent would be CPU-intensive
and cause write amplification) and then consider recompressing it
during background garbage collection or when there are enough blocks
have been written to justify recompression of the original extent.

The Btrfs COW case was also pointed out by Wenruo in the previous
thread:
https://lore.kernel.org/r/62f5f68d-7e3f-9238-5417-c64d8dcf2214@gmx.com

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
> 


