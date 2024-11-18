Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E483E9D0DC7
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Nov 2024 11:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731924524;
	bh=SBGXcRO+8FEFM3k4xRoXCbbIG55nPObO6VpdHCFdPu8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kafTaxrK5xJmlQXR+7T0N1aeminHLaq/iONDYLIgfcIR9/duviqsbq8UyylhflMb6
	 TULxFdGwY/q0BWijf3BjX8JvZDveoJEM3A0JozmKu0yMYHP9kwis7FmDMvpRecVZS0
	 WldZ0EuWyDxHE77gvBRGrJGWZItK2Ggbnl+ird4ybqmi6wW4DbIRvoECxlm54pWBPR
	 rGqG0XCAIUGX/jHwqwZFTxo6SoNkOKef4XZNBUx5jjo5WDTghW58mz+2rdTkkW2qH7
	 m2lzI2gl/9Y3lLHMdG9UWqIv11A7VKiyoJpT9BWYOw4ABixepK7LjeRKORjDsSpfub
	 mjPjh1++GAivA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsNcr2XfHz30f5
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Nov 2024 21:08:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731924519;
	cv=none; b=Y9T+D6oQCMQL8uSnftYwbfEwtixJ2ARZwLGnyUi12EFZwNVXgFFz4ut/WFhFlZc5fpJL/LARL9krSnI04lw1z7uD6DF2d4LSCavyR2bQtjm77B2www86pgMEsGAXS4BiFS8bgZfPPYjkore8RCP1tgv7Y0gZrEYH2SmNVsmkKJyH3xJswnvSx898PrnQsWEhJNi0CKvhPk2U3JXfghFx6R0wrRG5iVNlSm1MbLfCeuBHFlySP/LBqubOuJ0jUsk7lRjmYbAEkspY9MH9bDnk7mdcy3mOIRphuSdPfEJpBxrZtXLZhH6WX11oF1pkfPyYX/m/zyfcdjqCZRIARpRHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731924519; c=relaxed/relaxed;
	bh=SBGXcRO+8FEFM3k4xRoXCbbIG55nPObO6VpdHCFdPu8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P8OMAvvZ/3q2iV0zO2GL+fC3cNNZKGKVY5EHcEoNZN6OJ2+LeVA7jVvMO9iRd+4GvCLusV69SiW10wH+2qs0G7PNgSWbCIFBLIWy2mXJpeWVvxdKcALJTr7oN1rosdxIwWxN3g1JzvEKhgmMwZ2kmDH2KlI8K9m+Fv3/gCkBg7wroi8q9pB9Dc5VQSnjz46AWXVzpX70IQWNDrMVNmxK85ab2ndbf6xu6njVUm0U/2fuScyq2vk2DCOfPSWUU0pZR1rWlBKqjbXuh3LkD4HJClhFR8vpH9eMLfjn+0hdgRoDLT1/Ml40ZTX4p8lWkVt3bXnfnvCESy110cychg5xrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hsLECLzJ; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hsLECLzJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XsNcf03Kpz2xjw
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Nov 2024 21:08:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4B233A4160B;
	Mon, 18 Nov 2024 10:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731D2C4CED6;
	Mon, 18 Nov 2024 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731924509;
	bh=ElbV7+y46xOwExqz+QF3XktAt+Sx1IHP9XxevAPamFU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hsLECLzJWeIvPpsAAHBOOIrZ/skFjRU9YqYuQPERDT9sVHEH4Uz28A+QOOn8R10t5
	 btkC9J4Op652G/F6H3Gz9T2g6OcSwA1YyxhSQ7kVVNrq5OMN+Bm+Lkd4psL4eKMCT8
	 jp3PjFpzVUu84uOdbJDicysdDAU33IY9hpsZUp6Y9SscWS6UWEZS9cRTCB/V7TNnri
	 AO7pH4eztBpR6Brw9opORCgv2sGBdsySleTmctnZQub2hNh23g/gdEOY3Io8129SZg
	 UVtU7JeXwMfMBmM6O4FaRylTQ92z277I0GkDRRnAJsSQ20HgaX7NzzTljvRPnBuozp
	 +8MNrkTuC/yrQ==
Message-ID: <4dfbb8ba-f141-42d4-aedb-c6d98e8c930a@kernel.org>
Date: Mon, 18 Nov 2024 18:08:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] erofs: get rid of erofs_{find,insert}_workgroup
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
 <36d1653d-249a-47b0-a87c-1216ed5bf1ca@kernel.org>
 <bda19625-e43e-4ebe-82f5-dad860782e6d@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <bda19625-e43e-4ebe-82f5-dad860782e6d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/11/11 10:12, Gao Xiang wrote:
> Hi Chao,
> 
> On 2024/11/7 11:09, Chao Yu wrote:
>> On 2024/10/21 11:53, Gao Xiang wrote:
>>> Just fold them into the only two callers since
>>> they are simple enough.
>>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>> v1: https://lore.kernel.org/r/20241017115705.877515-1-hsiangkao@linux.alibaba.com
>>> change since v1:
>>>   - !grp case should be handled properly mentioned by Chunhai;
>>>
>>>   fs/erofs/internal.h |  5 +----
>>>   fs/erofs/zdata.c    | 38 +++++++++++++++++++++++++---------
>>>   fs/erofs/zutil.c    | 50 +--------------------------------------------
>>>   3 files changed, 30 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 4efd578d7c62..8081ee43cd83 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -457,10 +457,7 @@ void erofs_release_pages(struct page **pagepool);
>>>   #ifdef CONFIG_EROFS_FS_ZIP
>>>   void erofs_workgroup_put(struct erofs_workgroup *grp);
>>> -struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>>> -                         pgoff_t index);
>>> -struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>>> -                           struct erofs_workgroup *grp);
>>> +bool erofs_workgroup_get(struct erofs_workgroup *grp);
>>>   void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
>>>   void erofs_shrinker_register(struct super_block *sb);
>>>   void erofs_shrinker_unregister(struct super_block *sb);
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>> index a569ff9dfd04..bb1b73d99d07 100644
>>> --- a/fs/erofs/zdata.c
>>> +++ b/fs/erofs/zdata.c
>>> @@ -714,9 +714,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>>   {
>>>       struct erofs_map_blocks *map = &fe->map;
>>>       struct super_block *sb = fe->inode->i_sb;
>>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>>>       bool ztailpacking = map->m_flags & EROFS_MAP_META;
>>>       struct z_erofs_pcluster *pcl;
>>> -    struct erofs_workgroup *grp;
>>> +    struct erofs_workgroup *grp, *pre;
>>>       int err;
>>>       if (!(map->m_flags & EROFS_MAP_ENCODED) ||
>>> @@ -752,15 +753,23 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>>           pcl->obj.index = 0;    /* which indicates ztailpacking */
>>>       } else {
>>>           pcl->obj.index = erofs_blknr(sb, map->m_pa);
>>> -
>>> -        grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
>>> -        if (IS_ERR(grp)) {
>>> -            err = PTR_ERR(grp);
>>> -            goto err_out;
>>> +        while (1) {
>>> +            xa_lock(&sbi->managed_pslots);
>>> +            pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
>>> +                       NULL, grp, GFP_KERNEL);
>>> +            if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
>>> +                xa_unlock(&sbi->managed_pslots);
>>> +                break;
>>> +            }
>>> +            /* try to legitimize the current in-tree one */
>>> +            xa_unlock(&sbi->managed_pslots);
>>> +            cond_resched();
>>>           }
>>> -
>>> -        if (grp != &pcl->obj) {
>>
>> Do we need to keep this logic?
> 
> Thanks for the review.  I think
> 
>          if (grp != &pcl->obj)
> 
> equals to (pre && erofs_workgroup_get(pre)) here, so
> 
>          } else if (pre) {
>              fe->pcl = container_of(pre,
>                  struct z_erofs_pcluster, obj);
>              err = -EEXIST;
>              goto err_out;
>          }
> 
> Handles this case.

Xiang, thanks for your explanation.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang

