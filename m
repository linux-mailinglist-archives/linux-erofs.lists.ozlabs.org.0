Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0409C366C
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 03:12:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XmtNL69M7z2yYq
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 13:12:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731291136;
	cv=none; b=Ig1JEOOl+wYWMHf2sH+pr+mYnEG2GsGI0bH6qchw4JF7EFrV3NG3GKoUFG1/4fZJ55uUL/oXwr9MePGyFwOO185hMovJvAFOyIViOGGtBLaW/4kC6ZaLlLdnkeO5vmLaO5tnkxBgIQ6Ir/NQGURruPGRJJrFPPFzJINDJMgTrHSilgvEkC6pvK7oOTUSTxTjWKT/gISnYwaS6IdeeGXKvFGOhysru87kXMX86F05cDNMuA1Ayvb2YE27Jjz0/qxKizE6xer2GwzlxrXYfQGoBoVnNljpdh9ag4Ue4Fav4l6fwDzoxPRdHAjhO5O7yoLLigd22SNx9FwnHDii3i8Ctg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731291136; c=relaxed/relaxed;
	bh=kPhZpfwim8Tr8MRzViTRwXJRChpSgC6ZbMn8DI4K++I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHkLjDhQTX30iUXDBl9cTOz8qYVh8xCZS5V7hwUTQOcXu7hDvdMa/Jvc9qnPvFDqchdHztv5hnOedqnTJVf1jM+hjdDbghzz/S3BM4GYg5WP40pqbLKv8Ur4N+W+3K5ibW2iBU/w2dJRtSLPOBN+ekc68CA6OgxzIJ4HGT3+MLVTLTt0tN01h2E6DYbnxDO3Ef5Dqn55iYQD7LoHs+YfcmtLMV/w0GKR7JBGmoPE3mW2Z9NIeppAGzJuNrYQRdfXP8BXiPqEnNcA2vP/v52O9DnxsbgP+0Qmq1yrpFH/92oKWjJrSnDEpakHXeaeMfzjMXLbdUigztpYp9fbWBHygg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gem5a9YK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gem5a9YK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XmtNH4vw2z2xgp
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 13:12:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731291131; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kPhZpfwim8Tr8MRzViTRwXJRChpSgC6ZbMn8DI4K++I=;
	b=Gem5a9YKlQBM6eihVDm9hvmChCOttWSAza/cnW9vE6VfB3WPaCvG4TIly67wC985DrFsn8tj5+rXg3zGsw3KQR0nbEWbzlNRWRZHEKYCh3NDcEAHoCLChf71jmILtrQbSG7knU2phP4/Xp2E+sAi+jsjCoby0Nf5/Iq0/fMYcE4=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ3sJBC_1731291129 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:12:10 +0800
Message-ID: <bda19625-e43e-4ebe-82f5-dad860782e6d@linux.alibaba.com>
Date: Mon, 11 Nov 2024 10:12:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] erofs: get rid of erofs_{find,insert}_workgroup
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
 <36d1653d-249a-47b0-a87c-1216ed5bf1ca@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <36d1653d-249a-47b0-a87c-1216ed5bf1ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On 2024/11/7 11:09, Chao Yu wrote:
> On 2024/10/21 11:53, Gao Xiang wrote:
>> Just fold them into the only two callers since
>> they are simple enough.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v1: https://lore.kernel.org/r/20241017115705.877515-1-hsiangkao@linux.alibaba.com
>> change since v1:
>>   - !grp case should be handled properly mentioned by Chunhai;
>>
>>   fs/erofs/internal.h |  5 +----
>>   fs/erofs/zdata.c    | 38 +++++++++++++++++++++++++---------
>>   fs/erofs/zutil.c    | 50 +--------------------------------------------
>>   3 files changed, 30 insertions(+), 63 deletions(-)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 4efd578d7c62..8081ee43cd83 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -457,10 +457,7 @@ void erofs_release_pages(struct page **pagepool);
>>   #ifdef CONFIG_EROFS_FS_ZIP
>>   void erofs_workgroup_put(struct erofs_workgroup *grp);
>> -struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>> -                         pgoff_t index);
>> -struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>> -                           struct erofs_workgroup *grp);
>> +bool erofs_workgroup_get(struct erofs_workgroup *grp);
>>   void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
>>   void erofs_shrinker_register(struct super_block *sb);
>>   void erofs_shrinker_unregister(struct super_block *sb);
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index a569ff9dfd04..bb1b73d99d07 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -714,9 +714,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>   {
>>       struct erofs_map_blocks *map = &fe->map;
>>       struct super_block *sb = fe->inode->i_sb;
>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>>       bool ztailpacking = map->m_flags & EROFS_MAP_META;
>>       struct z_erofs_pcluster *pcl;
>> -    struct erofs_workgroup *grp;
>> +    struct erofs_workgroup *grp, *pre;
>>       int err;
>>       if (!(map->m_flags & EROFS_MAP_ENCODED) ||
>> @@ -752,15 +753,23 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>           pcl->obj.index = 0;    /* which indicates ztailpacking */
>>       } else {
>>           pcl->obj.index = erofs_blknr(sb, map->m_pa);
>> -
>> -        grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
>> -        if (IS_ERR(grp)) {
>> -            err = PTR_ERR(grp);
>> -            goto err_out;
>> +        while (1) {
>> +            xa_lock(&sbi->managed_pslots);
>> +            pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
>> +                       NULL, grp, GFP_KERNEL);
>> +            if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
>> +                xa_unlock(&sbi->managed_pslots);
>> +                break;
>> +            }
>> +            /* try to legitimize the current in-tree one */
>> +            xa_unlock(&sbi->managed_pslots);
>> +            cond_resched();
>>           }
>> -
>> -        if (grp != &pcl->obj) {
> 
> Do we need to keep this logic?

Thanks for the review.  I think

		if (grp != &pcl->obj)

equals to (pre && erofs_workgroup_get(pre)) here, so

		} else if (pre) {
			fe->pcl = container_of(pre,
				struct z_erofs_pcluster, obj);
			err = -EEXIST;
			goto err_out;
		}

Handles this case.

Thanks,
Gao Xiang
