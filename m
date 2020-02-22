Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC7E168AE3
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2020 01:17:38 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48PTRg3kDczDqvK
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2020 11:17:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.64;
 helo=hqnvemgate25.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.a=rsa-sha256
 header.s=n1 header.b=p2+0C6I2; dkim-atps=neutral
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48PTPK64NZzDqmq
 for <linux-erofs@lists.ozlabs.org>; Sat, 22 Feb 2020 11:15:33 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e50727e0001>; Fri, 21 Feb 2020 16:14:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 21 Feb 2020 16:15:28 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 21 Feb 2020 16:15:28 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Feb
 2020 00:15:28 +0000
Subject: Re: [PATCH v7 01/24] mm: Move readahead prototypes from mm.h
To: Matthew Wilcox <willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-2-willy@infradead.org>
 <e065679e-222f-7323-9782-0c4471bb9233@nvidia.com>
 <20200221214853.GF24185@bombadil.infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <69fa8779-3433-9d35-a1f4-f115dc86c6d8@nvidia.com>
Date: Fri, 21 Feb 2020 16:15:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221214853.GF24185@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582330494; bh=Xu1W/y2f9OTxnj+6T8DBBjck/f2ICJjqDeKYJhM73bw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=p2+0C6I2/yxvNQ1pZnv87YfPksTddG+e8cc03+sVRvODjU2CaK7MWQBiokHBWhwgb
 ieVI22Ga85j5LMOJVhYhtaccRh8zhO2H+xRsWBU/P8jaMdk1KeAHP1UgdQZbuh/fxI
 hzO1rCi0fPdivx/Gdy87keJKQLfBTMl82lrGPg+HtMx4bbn1scu0JW30tCh15BSQmD
 mQSimv7RYwfVWTinVZWGntdq5fdSKt8II8eY04QJynTy8RS0zcVz5otr5kwPPCZ2pE
 v1Ek68IoRy4J0my4VYUXkHH4q/cEli9/t/FTx/7/JWNBZEw7tWg2FKjPvsTsMCyd6G
 n45AbsLmye9OQ==
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2/21/20 1:48 PM, Matthew Wilcox wrote:
> On Thu, Feb 20, 2020 at 06:43:31PM -0800, John Hubbard wrote:
>> Yes. But I think these files also need a similar change:
>>
>>     fs/btrfs/disk-io.c
> 
> That gets pagemap.h through ctree.h, so I think it's fine.  It's
> already using mapping_set_gfp_mask(), so it already depends on pagemap.h.
> 
>>     fs/nfs/super.c
> 
> That gets it through linux/nfs_fs.h.
> 
> I was reluctant to not add it to blk-core.c because it doesn't seem
> necessarily intuitive that the block device core would include pagemap.h.
> 
> That said, blkdev.h does include pagemap.h, so maybe I don't need to
> include it here.

OK. Looks good (either through blkdev.h or as-is), so:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


> 
>> ...because they also use VM_READAHEAD_PAGES, and do not directly include
>> pagemap.h yet.
> 
>>> +#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
>>> +
>>> +void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
>>> +		struct file *, pgoff_t index, unsigned long req_count);
>>
>> Yes, "struct address_space *mapping" is weird, but I don't know if it's
>> "misleading", given that it's actually one of the things you have to learn
>> right from the beginning, with linux-mm, right? Or is that about to change?
>>
>> I'm not asking to restore this to "struct address_space *mapping", but I thought
>> it's worth mentioning out loud, especially if you or others are planning on
>> changing those names or something. Just curious.
> 
> No plans (on my part) to change the name, although I have heard people
> grumbling that there's very little need for it to be a separate struct
> from inode, except for the benefit of coda, which is not exactly a
> filesystem with a lot of users ...
> 
> Anyway, no plans to change it.  If there were something _special_ about
> it like a theoretical:
> 
> void mapping_dedup(struct address_space *canonical,
> 		struct address_space *victim);
> 
> then that's useful information and shouldn't be deleted.  But I don't
> think the word 'mapping' there conveys anything useful (other than the
> convention is to call a 'struct address_space' a mapping, which you'll
> see soon enough once you look at any of the .c files).
> 

OK, that's consistent and makes sense.


thanks,
-- 
John Hubbard
NVIDIA
