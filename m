Return-Path: <linux-erofs+bounces-75-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C5A636BC
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 18:17:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZG4Xs3bcDz2yRm;
	Mon, 17 Mar 2025 04:17:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742145437;
	cv=none; b=R5z+hJzMdTjoRJYgJfNGtZWGzFz1LQ/R7/qxdwzCclS0IX8SIs0S89vva+X1vk6VPV/DDRUk7jyFGaOK2aYk3nArwucCrgxuBGSA1mBvkPAxLQEXsTmfHLaBf/zm3D8xM931Wal8t6F3Derc4dNyx0APRTLx5d3EGgczMe+rIQC8C9lysC2VjBtCsOZzIM1qnuegakYxLPohR2a7tlUumM4A6SibDTsmedNCh3rikPaPWaswo13O7S4/FzXyAWrYRfrOExw0cRQq7clp5ksCSflgBKecQXL8w2RjNU2rpWB0v00BtqOUvksCU68H8f1TsIgFp1tTaUIed0Ou4vGNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742145437; c=relaxed/relaxed;
	bh=UUeB2FUt0HAuaRZxXLaie80QjepErNYtIn4MOft9MmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io2dLB7Z6kcR/GMHBjI/U5Hr7FWnw3HBuV3ELfV0d4c0HLM7SuxkgBeicdOnXhQJv4R9YHM9up1Bl6xYXIjWfPLddUSZSwfQv1jjVorQaGcz5jUmQZ/LQFhiehs0mXny+eWssAhTgfh+8rr9KpKcgj9/mo8S7C0mUlWJU5rdc8T42K5B4tOOzAAlslPKf4EinSZDX0bOULhQDeV5lTOhqVrOapd28TBpQcYeomWghwgCH+s2Th82cS8GT8WUcRGtEh1URQcjTeE1OCXql7muwQPhk0WbxVRXyeD74uUiByqhAoeWZyu5EhY1NAuk6X3XJ+N3mr97LxDrf54MM4v3Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jabzg1Wi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jabzg1Wi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZG4Xq44Fjz2xdg
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Mar 2025 04:17:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742145431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UUeB2FUt0HAuaRZxXLaie80QjepErNYtIn4MOft9MmI=;
	b=jabzg1WiepnD8omQjPAulSGZBQ3xejp57YckghYIDas9uW8gFe95WwqTA9Aef28aS/0umdCbk3QNWzwEcONO/MYXI5sVZvhTgnYcx2AC1uDk8/neGPY4xrPCht2yUMp0yA0q8tK4fuwNIgRvLNol7oplKPRDrkB1Jb4WL10qe3k=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRVc8sJ_1742145427 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 01:17:08 +0800
Message-ID: <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
Date: Mon, 17 Mar 2025 01:17:07 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

On 2025/3/16 10:36, Chao Yu wrote:
> On 2025/2/10 11:29, Hongzhen Luo wrote:
>> There's no need to enumerate each type.  No logic changes.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Looks good to me, feel free to add:
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> And one minor comment below.
> 
>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>> index 689437e99a5a..d278ebd60281 100644
>> --- a/fs/erofs/zmap.c
>> +++ b/fs/erofs/zmap.c
>> @@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>>           if (err)
>>               return err;
>> -        switch (m->type) {
>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>> +        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>> +            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> +                  m->type, lcn, vi->nid);
>> +            DBG_BUGON(1);
>> +            return -EOPNOTSUPP;
>  > +        } else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {>               lookback_distance = m->delta[0];
>>               if (!lookback_distance)
>> -                goto err_bogus;
>> +                break;
>>               continue;
>> -        case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>> +        } else {
>>               m->headtype = m->type;
>>               m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>>               return 0;
>> -        default:
>> -            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> -                  m->type, lcn, vi->nid);
>> -            DBG_BUGON(1);
>> -            return -EOPNOTSUPP;
> 
> Should return EFSCORRUPTED here? is m->type >= Z_EROFS_LCLUSTER_TYPE_MAX a possible
> case?

It's impossible by the latest on-disk definition, see:
#define Z_EROFS_LI_LCLUSTER_TYPE_MASK	(Z_EROFS_LCLUSTER_TYPE_MAX - 1)

Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
introduced, but the `default:` case is already deadcode now.

> 
> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
> then we can treat m->type as reliable variable later.
> 
>      advise = le16_to_cpu(di->di_advise);
>      m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>      if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {

It's always false here.

Thanks,
Gao Xiang

