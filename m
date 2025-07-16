Return-Path: <linux-erofs+bounces-645-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFDB080BE
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 00:57:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjBJd3PjPz2yDk;
	Thu, 17 Jul 2025 08:57:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=188.121.53.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752706625;
	cv=none; b=hkThB/+e6oC+nRKei4xJTtuJ2IrRvdfotmmknlRFBgSD8ukQ3zSTCoiPiwCHn71a2Io9lD8esRbZ0VQsPlGmxPL9SDj4DOjWZ7Jo76X5E1rS3/MfFgNDPiKPpvwmymYziQ5NiwWeJ+ou/eNb1Dsm19mTrCEjMNZcJC4ouukX/MPJGpuiO04tLly2AsgHVwbEcT5oSGW9YD1Jm566MVAknon+X+QFnRKiKxzsXGY2eSCkEZ59+4Xib57V6JBDell0hFUM/WzAvxl1/TQFtVJaY0nJozS2Dj6dIXmLP15L63rscprA59x1sGJMyWbxmBFjQuaouraFEhTOToSxoKyqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752706625; c=relaxed/relaxed;
	bh=LXw6ldY+YQgvzasUoEe9Ha+WGxfEFTQd/LtLVKR9rZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aKjKb4aCQA5T2lpdcJ72rS8QcDDfayMtj/10AqeDCjqd2rOl3G1jfAq9CRVnGoTy44tUS3xE6/w5BWuZvcyIjmALttRLNTq3naexOiT3HDQ9wN3GvLjWNQqUyyiFflD//ws5ZS4FFy6dmpa2q0WpoI925BibAoCxR+HUr1uPXFcMNR+QT889KKi8oAGyMV/igb65n9jvNBojA0TI4Je+vBTlC3Z6txTI4UvhYiBMFTBL0QIqHBuhYNrI2djn6OVbq4cqXBqibK4inPqwYg311cSnFS6xzNXbcZh15mV7PTGiIKYx6GgfT67IhgcobLAotNP2HIfFNhGf9krTc5MOHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass (client-ip=188.121.53.35; helo=sxb1plsmtpa01-04.prod.sxb1.secureserver.net; envelope-from=phillip@squashfs.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=squashfs.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=squashfs.org.uk (client-ip=188.121.53.35; helo=sxb1plsmtpa01-04.prod.sxb1.secureserver.net; envelope-from=phillip@squashfs.org.uk; receiver=lists.ozlabs.org)
X-Greylist: delayed 987 seconds by postgrey-1.37 at boromir; Thu, 17 Jul 2025 08:57:04 AEST
Received: from sxb1plsmtpa01-04.prod.sxb1.secureserver.net (sxb1plsmtpa01-04.prod.sxb1.secureserver.net [188.121.53.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjBJc1zf2z2xlL
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 08:57:03 +1000 (AEST)
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id cAlKuoVr96J4FcAlNu4Dmt; Wed, 16 Jul 2025 15:38:10 -0700
X-CMAE-Analysis: v=2.4 cv=TYmWtQQh c=1 sm=1 tr=0 ts=687829d2
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=Z9je9KOXq8erZ9ix0VAA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <f4b9faf9-8efd-4396-b080-e712025825ab@squashfs.org.uk>
Date: Wed, 16 Jul 2025 23:37:28 +0100
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
 linux-cifs@vger.kernel.org
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfF7PhqfDTvf0GLbE+ZqPgfM1AhwOJlHSpsMzx6XOcDZuT9YqsTaq8QVlGaLYbZSCACkmupuX6+moDnsLw8z6oXo/oW+NBiLgU6y5TBJWXg6tV88e5Euj
 1giZ2fZsoopVdzm/v4Tlp3z0KvSwDUxO6m0SnvjOtH9zvReYNZLA2FNMM+DrFEJFaiIkCvRrmoBmbv4h3OnUHX5sclo1/Wezm+BEj6dLaDXAyuKVHku8Kvy6
 3A9SkS3ZtrCtIQcuDoAamTotabkyq8u+NbETcu+wgZcHz79D2Cqa4hBUqSAxUGPLdjqjvKdz0Y+w0IVDS3aE1LUKcnIDytVIxDas6bwTbJD2/Yz7PsjwtKtl
 JoRL1DOXscuVOLxBvw+0xQnpDotzu0Vo1GrTRn1rfHJKD4Exmb3wOCyCD+h2AYMKaGBCjBVgXvf5G6DK3/s3MVbkLRjH09uolqpyyQAsKggrC2Moa3qwKWia
 tBwCIdLZWPpQOFc2HOlLjv7vmcMVwr97TODyoKXcYSBdRG5Aj19H80t7Vc1kPbVELOFd5EDHNfQ8ATDugkZBq2J/V21dERsOluc2pak7RNmbJyOzrPcIwalB
 Nf6fEekDRHicDoV2q2tew6sPotWewTjdjMw9iwbRhZpamiZqsp/XI9f5XhZcOQoUdsCy/ey/U995vHBeMMo6H0yRk9BNVCMpINAVKCtQmjIv7xNp+Ioo2Sxs
 gPnTBcUD++qhM8KfplNiTcJXoQ96eTIssdBe+BMWUXv1qhpWQ9GKojXGcX8mKMvEG7sKSgFMNrc3J5Xm28GieZWCzy/+ZDv2I7VwecP2j5T1w/WLBfHEUgk5
 gufg4AqEMh/tWtnL4rvSfpFcA6zbEUbuBjvPEzIYLlyjogb7n+266BU1vQZO72XCtgIJOh/KDHsuteA4LS7mxuWjWepHBR+R1mjV5Mwu
X-Spam-Status: No, score=-0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 15/07/2025 21:40, Matthew Wilcox wrote:
> I've started looking at how the page cache can help filesystems handle
> compressed data better.  Feedback would be appreciated!  I'll probably
> say a few things which are obvious to anyone who knows how compressed
> files work, but I'm trying to be explicit about my assumptions.
> 
> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.  This would be a good
> point to stop reading and tell me about counterexamples.

For Squashfs Yes.

> 
>>From what I've been reading in all your filesystems is that you want to
> allocate extra pages in the page cache in order to store the excess data
> retrieved along with the page that you're actually trying to read.  That's
> because compressing in larger chunks leads to better compression.
> 

Yes.

> There's some discrepancy between filesystems whether you need scratch
> space for decompression.  Some filesystems read the compressed data into
> the pagecache and decompress in-place, while other filesystems read the
> compressed data into scratch pages and decompress into the page cache.
> 

Squashfs uses scratch pages.

> There also seems to be some discrepancy between filesystems whether the
> decompression involves vmap() of all the memory allocated or whether the
> decompression routines can handle doing kmap_local() on individual pages.
> 

Squashfs does both, and this depends on whether the decompression
algorithm implementation in the kernel is multi-shot or single-shot.

The zlib/xz/zstd decompressors are multi-shot, in that you can call them
multiply, giving them an extra input or output buffer when it runs out.
This means you can get them to output into a 4K page at a time, without
requiring the pages to be contiguous.  kmap_local() can be called on each
page before passing it to the decompressor.

The lzo/lz4 decompressors are single-shot, they expect to be called once,
with a single contiguous input buffer containing the data to be
decompressed, and a single contiguous output buffer large enough to hold
all the uncompressed data.

> So, my proposal is that filesystems tell the page cache that their minimum
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.  That removes all the
> extra code in filesystems to allocate extra memory in the page cache.
> It means we don't attempt to track dirtiness at a sub-folio granularity
> (there's no point, we have to write back the entire compressed bock
> at once).  We also get a single virtually contiguous block ... if you're
> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> vmap_file() which would give us a virtually contiguous chunk of memory
> (and could be trivially turned into a noop for the case of trying to
> vmap a single large folio).
> 

The compression block size in Squashfs can be 4K to 1M in size.

Phillip

