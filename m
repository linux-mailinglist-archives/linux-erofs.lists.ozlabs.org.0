Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E885D0F
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 10:41:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46420m55RPzDqSD
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 18:41:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4641zf3DQyzDqT2
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2019 18:40:44 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id F0C7E64C495EF3C2A2DF;
 Thu,  8 Aug 2019 16:40:36 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 16:40:36 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 8
 Aug 2019 16:40:36 +0800
Date: Thu, 8 Aug 2019 16:57:45 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190808085745.GE28630@138>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
 <20190808081647.GI7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190808081647.GI7689@dread.disaster.area>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
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
Cc: "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
 "darrick.wong@oracle.com" <darrick.wong@oracle.com>, miaoxie@huawei.com,
 Goldwyn Rodrigues <RGoldwyn@suse.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, "hch@lst.de" <hch@lst.de>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dave,

On Thu, Aug 08, 2019 at 06:16:47PM +1000, Dave Chinner wrote:
> On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> 
> *nod*
> 
> Especially once we get the inline encryption support for fscrypt so
> the storage layer can offload the encrypt/decrypt to hardware via
> the bio containing plaintext. That pretty much forces fscrypt to be
> the lowest layer of the filesystem transformation stack.  This
> hardware offload capability also places lots of limits on what you
> can do with block-based verity layers below the filesystem. e.g.
> using dm-verity when you don't know if there's hardware encryption
> below or software encryption on top becomes problematic...
> 
> So really, from a filesystem and iomap perspective, What Eric says
> is the right - it's the only order that makes sense...

Don't be surprised there will be a decrypt/verity/decompress
all-in-one hardware approach for such stuff. 30% random IO (no matter
hardware or software approach) can be saved that is greatly helpful
for user experience on embedded devices with too limited source.

and I really got a SHA256 CPU hardware bug years ago.

I don't want to talk more on tendency, it depends on real scenerio
and user selection (server or embedded device).

For security consideration, these approaches are all the same
level --- these approaches all from the same signed key and
storage source, all transformation A->B->C or A->C->B are equal.

For bug-free, we can fuzzer compression/verity algorithms even
the whole file-system stack. There is another case other than
security consideration.

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
