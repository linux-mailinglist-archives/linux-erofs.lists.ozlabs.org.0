Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F197163A74
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 03:47:10 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Mhvc195yzDqdZ
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 13:47:08 +1100 (AEDT)
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
 header.s=n1 header.b=ekXkvC/Q; dkim-atps=neutral
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MhvX1skzzDq5n
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 13:47:03 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4ca1830002>; Tue, 18 Feb 2020 18:46:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Feb 2020 18:46:59 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 18:46:59 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 02:46:59 +0000
Subject: Re: [PATCH v6 09/19] mm: Add page_cache_readahead_limit
To: Matthew Wilcox <willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-16-willy@infradead.org>
 <1263603d-f446-c447-2eac-697d105fa76c@nvidia.com>
 <20200219022300.GJ24185@bombadil.infradead.org>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <f2d2346d-611c-ebdd-8430-ea4478e044d4@nvidia.com>
Date: Tue, 18 Feb 2020 18:46:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219022300.GJ24185@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582080388; bh=V/HjUqswaF1dKPtA+ar56SFisPTsJ76O2QClKAvYPMw=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ekXkvC/QTudnr/E7HumrPKVft3Ce5bTjTn20IMsFFhe9t9mDZ0EgD+a2C09d+D85z
 AGPEc99roqIevW1cBB2LdQIY1R6pe8q72KUOxkuIp6p8ulVKsh7zjBwgatxBG8hoeY
 QCLpxGRClqbTVbQD9myhbXiWfGyh0XLZkFJPDeq8WH2Shs7nzWGWidWzrF8oIhNTD7
 gsu9og2JxYod5aXUSdIlTtmakADanFstew6fv/i4LfFYqRVcDKJxsz2fwKiq29RqNZ
 JuJ7HKzL8sQILyEv0UsrM9YMdAbV3+bKN9dwYJItSxNZFn4ZwN8tC/8LQGXu1nSPCC
 H2F7kU+zXB7Eg==
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

On 2/18/20 6:23 PM, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 05:32:31PM -0800, John Hubbard wrote:
>>> +			page_cache_readahead_limit(inode->i_mapping, NULL,
>>> +					index, LONG_MAX, num_ra_pages, 0);
>>
>>
>> LONG_MAX seems bold at first, but then again I can't think of anything smaller 
>> that makes any sense, and the previous code didn't have a limit either...OK.
> 
> Probably worth looking at Dave's review of this and what we've just
> negotiated on the other subthread ... LONG_MAX is gone.


Great. OK, I see where it's going there.

> 
>> I also wondered about the NULL file parameter, and wonder if we're stripping out
>> information that is needed for authentication, given that that's what the newly
>> written kerneldoc says the "file" arg is for. But it seems that if we're this 
>> deep in the fs code's read routines, file system authentication has long since 
>> been addressed.
> 
> The authentication is for network filesystems.  Local filesystems
> generally don't use the 'file' parameter, and since we're going to be
> calling back into the filesystem's own readahead routine, we know it's
> not needed.
> 
>> Any actually I don't yet (still working through the patches) see any authentication,
>> so maybe that parameter will turn out to be unnecessary.
>>
>> Anyway, It's nice to see this factored out into a single routine.
> 
> I'm kind of thinking about pushing the rac in the other direction too,
> so page_cache_readahead_unlimited(rac, nr_to_read, lookahead_size).
> 
>>> +/**
>>> + * page_cache_readahead_limit - Start readahead beyond a file's i_size.
>>
>>
>> Maybe: 
>>
>>     "Start readahead to a caller-specified end point" ?
>>
>> (It's only *potentially* beyond files's i_size.)
> 
> My current tree has:
>  * page_cache_readahead_exceed - Start unchecked readahead.


Sounds good.

> 
> 
>>> + * @mapping: File address space.
>>> + * @file: This instance of the open file; used for authentication.
>>> + * @offset: First page index to read.
>>> + * @end_index: The maximum page index to read.
>>> + * @nr_to_read: The number of pages to read.
>>
>>
>> How about:
>>
>>     "The number of pages to read, as long as end_index is not exceeded."
> 
> API change makes this irrelevant ;-)
> 
>>> + * @lookahead_size: Where to start the next readahead.
>>
>> Pre-existing, but...it's hard to understand how a size is "where to start".
>> Should we rename this arg?
> 
> It should probably be lookahead_count.
> 
>>> + *
>>> + * This function is for filesystems to call when they want to start
>>> + * readahead potentially beyond a file's stated i_size.  If you want
>>> + * to start readahead on a normal file, you probably want to call
>>> + * page_cache_async_readahead() or page_cache_sync_readahead() instead.
>>> + *
>>> + * Context: File is referenced by caller.  Mutexes may be held by caller.
>>> + * May sleep, but will not reenter filesystem to reclaim memory.
>>
>> In fact, can we say "must not reenter filesystem"? 
> 
> I think it depends which side of the API you're looking at which wording
> you prefer ;-)
> 
> 

Yes. We should try to write these so that it's clear which way we're looking:
in or out. 


thanks,
-- 
John Hubbard
NVIDIA
