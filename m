Return-Path: <linux-erofs+bounces-633-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D991EB06D4E
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 07:40:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhlJG40kPz30T0;
	Wed, 16 Jul 2025 15:40:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752644414;
	cv=none; b=jWEqchL2exhaDW+A/W2QJcXsbIl2ydf3AWuCjDrzrqj8bWpK1i3CQPR4SzuOZqZnT5ix/jaBVIHjG7e9dW1Kz2ONC+QpLUGY7XoDgP/TEscdpxCV7SrQCpGI32T0tFL8hbn04ClnTlFhJbgT5DH38A6nRFgDjcZYZKfpr+33sD5qsR1C+DfVxJt3NMwIAdPrzC42v8thK4x4jsjfzFUMiZ1kdE7meJzvG2dOTtZfa5UrlexNfPc6yd29LxW0EFRL6vVhdtJexUZARb2k2qZ0fNvytHYivks9Hgw2/FgKo1/6lftk2CvxGEpd2P1cmXq0/0HvmncwBOU0RbosxVSrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752644414; c=relaxed/relaxed;
	bh=/qADFoeOXBnAEHP6o81g96cI4IF1HJRJHWKwBGouJpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KUDWcffGP+Dt2NCjFr39FCNeqkOADXpZVtt00Uo7IYw2hul2jiR+QITm1rVz2ATFTMY61Fu7O7s3ySt6Ff/BVoksMenBmZi5yTPMrM7oiiCYwup+uS+tmTmVnHTP0sigReZtHVbaN5SvA/7FoPBIT24gpWNaqINAn7rjNMOM04biWH0+XA8HdkDo6krjVykEFVmEoatdVsJFqGU58QF//6aTWTns1V7rti//fPnKECDLLUkAlwzcgbJ3ncdgiO9MivoFXShBEaXHbBIgkrCb6CN8Kj4VNKuCmnlQSOlxUpbHrRRO2c8dAvNfFD6GDmJhSBjfbgLu+0OZDCqIAH8gRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oeT1Nyqj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oeT1Nyqj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhlJD2r3Lz2ySY
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 15:40:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752644406; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/qADFoeOXBnAEHP6o81g96cI4IF1HJRJHWKwBGouJpA=;
	b=oeT1NyqjfjzJ2YmhyWz+Hq0lkl9JUfQCtaQFx8hH6YXWYCgfH64BMXKh8sJpQGi7JInaf2W6P8tWyemCvsUmbktNUNpPOSD3n6jok1RgbrHkKsZ2LA/TR9xnJfl9YduELmT8pgwEOO0pEYWw+VT/gXQJwNw/XyDLIlKYYzYw3Hs=
Received: from 30.221.131.131(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj2mLXU_1752644403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 13:40:04 +0800
Message-ID: <e143f730-6ae7-491e-985e-cc021411edd8@linux.alibaba.com>
Date: Wed, 16 Jul 2025 13:40:02 +0800
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
To: Qu Wenruo <wqu@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>,
 netfs@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
 <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
 <b43fe06d-204b-4f47-a7ff-0c405365bc48@suse.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b43fe06d-204b-4f47-a7ff-0c405365bc48@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/16 12:54, Qu Wenruo wrote:
> 
> 
> 在 2025/7/16 10:46, Gao Xiang 写道:
>> ...
>>
>>>
>>>>
>>>> There's some discrepancy between filesystems whether you need scratch
>>>> space for decompression.  Some filesystems read the compressed data into
>>>> the pagecache and decompress in-place, while other filesystems read the
>>>> compressed data into scratch pages and decompress into the page cache.
>>>
>>> Btrfs goes the scratch pages way. Decompression in-place looks a little tricky to me. E.g. what if there is only one compressed page, and it decompressed to 4 pages.
>>
>> Decompression in-place mainly optimizes full decompression (so that CPU
>> cache line won't be polluted by temporary buffers either), in fact,
>> EROFS supports the hybird way.
>>
>>>
>>> Won't the plaintext over-write the compressed data halfway?
>>
>> Personally I'm very familiar with LZ4, LZMA, and DEFLATE
>> algorithm internals, and I also have experience to build LZMA,
>> DEFLATE compressors.
>>
>> It's totally workable for LZ4, in short it will read the compressed
>> data at the end of the decompressed buffers, and the proper margin
>> can make this almost always succeed.
> 
> I guess that's why btrfs can not go that way.
> 
> Due to data COW, we're totally possible to hit a case that we only want to read out one single plaintext block from a compressed data extent (the compressed size can even be larger than one block).
> 
> In that case such in-place decompression will definitely not work.

Ok, I think it's mainly due to btrfs compression design.  Another point
is that decompression inplace can also be used for multi-shot interfaces
(as you said, "swapping input/ output buffer when one of them is full")
like deflate, lzma and zstd. Because you can know when the decompressed
buffers and compressed buffers are overlapped since APIs are multi-shot,
and only copy the overlapped compressed data to some additional temprary
buffers (and they can be shared among multiple compressed extents).

It has less overhead than allocating temporary buffers to keep compressed
data during the whole I/O process (again, because it just uses very small
number buffers during decompression process), especially for slow (even
network) storage devices.

I do understand Btrfs may not consider this because of different target
users, but one of EROFS main use cases is low overhead decompression
under the memory pressure (maybe + cheap storage), LZ4 + inplace
decompression is useful.

Anyway, I'm not advocating inplace decompression in any case.  I think
unlike plain text, encoded data has various approaches to organize
on disk and utilize page cache.  Due to different on-disk design and
target users, there will be different usage mode.

As for EROFS, we already natively supports compressed large folios
since 6.11, and order-0 folio is always our use cases, so I don't
think this will give extra benefits to users.

> 
> [...]
> 
>>> All the decompression/compression routines all support swapping input/ output buffer when one of them is full.
>>> So kmap_local() is completely feasible.
>>
>> I think one of the btrfs supported algorithm LZO is not,
> 
> It is, the tricky part is btrfs is implementing its own TLV structure for LZO compression.
> 
> And btrfs does extra padding to ensure no TLV (compressed data + header) structure will cross block boundary.
> 
> So btrfs LZO compression is still able to swap out input/output halfway, mostly due to the btrfs' specific design.

Ok, it seems much like a btrfs-specific design, because it's much
like per-block compression for LZO instead, and it will increase
the compressed size, I know btrfs may not care, but it's not the
EROFS case anyway.

Thanks,
Gao Xiang

> 
> Thanks,
> Qu

