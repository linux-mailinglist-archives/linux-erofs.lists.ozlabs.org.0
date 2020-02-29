Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA317453A
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 06:29:22 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Tw272L5yzDqxm
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 16:29:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Tw1z3F3HzDqnW
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 16:29:08 +1100 (AEDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 6B0A76F1ADB2CE9069B7;
 Sat, 29 Feb 2020 13:28:57 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Feb 2020 13:28:56 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 29 Feb 2020 13:28:56 +0800
Date: Sat, 29 Feb 2020 13:27:26 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [WIP] [PATCH v0.0-20200229 00/11] ez: LZMA fixed-sized output
 compression
Message-ID: <20200229052726.GA187655@architecture4>
References: <20200229045017.12424-1-hsiangkao.ref@aol.com>
 <20200229045017.12424-1-hsiangkao@aol.com>
 <20200229045842.GA930@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200229045842.GA930@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Eric,

On Fri, Feb 28, 2020 at 08:58:42PM -0800, Eric Biggers wrote:
> On Sat, Feb 29, 2020 at 12:50:06PM +0800, Gao Xiang via Linux-erofs wrote:
> > From: Gao Xiang <gaoxiang25@huawei.com>
> > 
> > This is a WIP PREVIEW patchset, just for archiving to open
> > source community only.
> > 
> > For now, it implements LZMA SDK-like GetOptimumFast approach
> > and GetOptimum is still on schedule.
> > 
> > It's still buggy, lack of formal APIs and actively under
> > development for a while...
> > 
> > Usage:
> > $ ./run.sh
> > $ ./a.out output.bin.lzma infile
> > 
> > It will compress the beginning as much as possible into
> > 4k RAW LZMA block.
> 
> Why not just use liblzma?

I discuss with Lasse and Igor in private, they have no recent plan to
develop fixed-sized output compression for now so it could not have
a formal upstream release in the near future.

After I digged into liblzma, it has many filters and LZMA2 wrapper so
it needs some more hack for now. I tend that Lasse could implement it
(Lasse said no recent, but it can be potential upstreamed. In fact,
liblzma is odd fixes status recent years compared with LZMA SDK...
However LZMA SDK coding style is so weird.)

On the other hand, it's just a product when I learned LZMA internals,
just like libdeflate in some extent. Bacause I need to do some coding
so I can learn LZMA internals and get how to do next step by step
because I'm not a LZMA expert at first.

> 
> Also, if you care enough about compression ratio to use LZMA instead of
> Zstandard, why use only a 4 KB blocksize?

They are all on schedule. I need some priority because I only have 24
hours a day and the content of my HUAWEI job is not all about EROFS. :(

If Zstandard developers have more interests on it. I'm happy to integrate
Zstd to EROFS as well. Otherwise, I need to do them myself. As a quick
glance, Zstandard uses multi-pass approach, so it may be hard for me to
do a quick hack. And I don't know all Zstandard internals as well.

Why use only a 4 KB blocksize --- It's just that I need to find a cleverer
and elegant way to do in-place decompression for larger physical cluster.
I need to think it over otherwise it could have potential compatibility
concerns and make EROFS more complex in the future.

In fact, Lasse raised a clever idea month ago. I will sort it out after
LZMA algortithm for EROFS is ready.

LZMA and larger physical cluster will be implemented this year If nothing
unexpected happens. I'm happy more experts and volunteers could have interest
in it but if only me, I only can do my best in my spare time...

Thanks,
Gao Xiang

> 
> - Eric
