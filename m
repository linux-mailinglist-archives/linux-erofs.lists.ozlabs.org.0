Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D701993208C
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 08:46:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mjfFPjVN;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WNV3L5Fhqz3cZy
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 16:46:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mjfFPjVN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WNV3F5HzDz2ysc
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2024 16:46:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112389; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3VjkPs1ND3ZkbMZwPcFQ6dQO7g+M9DvU25mbr2pS8LQ=;
	b=mjfFPjVNYK4Wps804ia13gu8m0vSEewXLJLfJ1//Te35L+M39Kf0Yv+S95r84IFqLV3g2NbGPVuSE4UR+Gwcp5LJi4jNeMNyGyhejm4wtRMvFtZ/Kl+AK0wQyU2a5EupKFmukNQcKWED/NXKxbfKsPnZymb7WhWRjSa1kLQ/X9E=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAgYxGS_1721112385;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAgYxGS_1721112385)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:46:26 +0800
Message-ID: <dedea322-c2c5-4e1b-b5c6-0889a78c19fa@linux.alibaba.com>
Date: Tue, 16 Jul 2024 14:46:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of
 erofs_allocpage
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
 <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com>
 <CAGWkznEpn0NNTiYL-VYohcmboQ-kTDssiGZyi84BXf5i8+KA-Q@mail.gmail.com>
 <a41d38bb-756a-4773-8d87-b43b0c5ed9a9@linux.alibaba.com>
 <CAGWkznH4h=B1iUHps6r6DKhx2xt-Pn3-Pd1_fFjabeun6rmO_Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGWkznH4h=B1iUHps6r6DKhx2xt-Pn3-Pd1_fFjabeun6rmO_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-kernel@vger.kernel.org, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, steve.kang@unisoc.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/16 14:43, Zhaoyang Huang wrote:
> On Tue, Jul 16, 2024 at 2:20 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>

...

>>>>
>>>> I don't see why it's an atomic context,
>>>> so this patch is incorrect.
>>> Sorry, I should provide more details. page_cache_ra_unbounded() will
>>> call filemap_invalidate_lock_shared(mapping) to ensure the integrity
>>> of page cache during readahead, which will disable preempt.
>>
>> Why a rwsem sleepable lock disable preemption?
> emm, that's the original design of down_read()

No.

> 
>> context should be always non-atomic context, which is applied
>> to all kernel filesystems.
>   AFAICT, filemap_fault/read have added the folios of readahead to page
> cache which means the aops->readahead basically just need to map the
> block to this folios and then launch the bio. The erofs is a little
> bit different to others as it has to alloc_pages for decompression
> when doing this.

Interesting.  The whole .readahead is sleepable, including
submit block I/Os to storage.

Nacked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
