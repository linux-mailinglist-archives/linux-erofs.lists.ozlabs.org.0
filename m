Return-Path: <linux-erofs+bounces-78-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A429DA64092
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Mar 2025 07:03:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGPY62v8sz2yd7;
	Mon, 17 Mar 2025 17:03:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742191418;
	cv=none; b=U5w/8xwnVcON0Yqy00bL1OcxhBB9eB8VmcDzZlKGyMYKFisTcPkEBFS8Ug9NszYgsvVeGSQIGrFvpnXc4mlCdp7Qr+8AMoa5TfveVjtxIFznIHqqHW2J7xOrlVHmVdXKt/XYRb9FaYIkjjqLNrtDR9JK+JfuGyA+PJ4pzrlnCyPfiFvQJoNGSgXGotTGlbpT3VXyITQGBElvG4v4+oAoejCPtU0VqQLYq2Zw9Hy5sfP+1rMjYiYJwMjdYCuXbR1uYWzoFKD5Y5oVF5hjAoIwXJJpj7MQaXpF5TYYsjU4Bq2j3PX2mNFRiAyaFjuFeBjV5dVBrr6TLmtE6+6lK7f8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742191418; c=relaxed/relaxed;
	bh=th40gWLid2TPAEe54CmUfZUCSFlZP9fNRqJQ1SIRMxw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bB7IfL0AKTrV6+/hT0pigR9yxZ398ChcRqBm1xl27Kf6MnQvD8zkcDw6vHYRPxuqB0JGUwDRIpQ4CeDU/kLj3mAgbZva26FZWBM0OZo44GPxxWWpyMMRxcsxWcCybwRIbFWKapkRf+iZw44b1750XQGVQkVeA6EnIXH2J5kDJUYhZNHbzOKmD9F4yagbDXuJFsMUson2HaE350qD68dAkqGll3zgT7YQjLnXmQIrdFhRK8zYLF6uWbyfKL7mRGnsdrPmJXVRxZJEOyht2trNiBCIzCbALTl+A4m9roDH9UsgLAUv/blZldZTYPS+wIlBCIzvd6K5pqnFfYbhP4MJTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RT59GHJl; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RT59GHJl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGPY5449fz2yGM
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Mar 2025 17:03:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8A559A44999;
	Mon, 17 Mar 2025 05:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0586C4CEE3;
	Mon, 17 Mar 2025 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742191413;
	bh=9GuJYZNYYI8a++OQNnQqfYWr0hu/Ni006bEAgzjYOk4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RT59GHJld+0mf/54D79lBO7EzTph/n9ZtqLsXyJUw6nxnKDLZi1shV1/+JJheYT2s
	 ilR/GHkvuK20xHoddW+xX5eGkvseEHWHJjFQ3DxGy3TOyNsELtTaT7UPLfLVlFvRj6
	 y1vm9fpZe86I+8qzbCYsBUnWd+G6tdtcix577CF0hWh81f5p1LuQ89tTrdmoZWy56H
	 arCb05nMlK+79yoJf2DKuYF1ZbAgfjsjN/A06tCP4M0msYDs7CPlWWPHPYE+4T83a7
	 9KDjhfQF2pozZnwk9wykLMpIOR174BJlaNSxuyjBneDmpQbJahgQPCE0vcZeb0y0Q8
	 oXVgiopNNJhAw==
Message-ID: <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
Date: Mon, 17 Mar 2025 14:03:30 +0800
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 3/17/25 01:17, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/3/16 10:36, Chao Yu wrote:
>> On 2025/2/10 11:29, Hongzhen Luo wrote:
>>> There's no need to enumerate each type.  No logic changes.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Looks good to me, feel free to add:
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>>
>> And one minor comment below.
>>
>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>> index 689437e99a5a..d278ebd60281 100644
>>> --- a/fs/erofs/zmap.c
>>> +++ b/fs/erofs/zmap.c
>>> @@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>>>           if (err)
>>>               return err;
>>> -        switch (m->type) {
>>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>>> +        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>>> +                  m->type, lcn, vi->nid);
>>> +            DBG_BUGON(1);
>>> +            return -EOPNOTSUPP;
>>  > +        } else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {>               lookback_distance = m->delta[0];
>>>               if (!lookback_distance)
>>> -                goto err_bogus;
>>> +                break;
>>>               continue;
>>> -        case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>>> +        } else {
>>>               m->headtype = m->type;
>>>               m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>>>               return 0;
>>> -        default:
>>> -            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>>> -                  m->type, lcn, vi->nid);
>>> -            DBG_BUGON(1);
>>> -            return -EOPNOTSUPP;
>>
>> Should return EFSCORRUPTED here? is m->type >= Z_EROFS_LCLUSTER_TYPE_MAX a possible
>> case?
> 
> It's impossible by the latest on-disk definition, see:
> #define Z_EROFS_LI_LCLUSTER_TYPE_MASK    (Z_EROFS_LCLUSTER_TYPE_MAX - 1)
> 
> Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
> introduced, but the `default:` case is already deadcode now.

Xiang, thanks for the explanation.

So seems it can happen when mounting last image w/ old kernel which can not
support newly introduced Z_EROFS_LCLUSTER_TYPE_* type, then it makes sense to
return EOPNOTSUPP.

> 
>>
>> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
>> then we can treat m->type as reliable variable later.
>>
>>      advise = le16_to_cpu(di->di_advise);
>>      m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>>      if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> 
> It's always false here.

So, what do you think of this?

From af584b2eacd468f145e9ee31ccdeedb7355d5afd Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 17 Mar 2025 13:57:55 +0800
Subject: [PATCH] erofs: remove dead codes for cleanup

z_erofs_extent_lookback() and z_erofs_get_extent_decompressedlen() tries
to do sanity check on m->type, however their caller z_erofs_map_blocks_fo()
has already checked that, so let's remove those dead codes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/zmap.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 8de50df05dfe..4d883ec212d7 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -265,17 +265,12 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		if (err)
 			return err;

-		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
-			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
-		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
 			if (!lookback_distance)
 				break;
 			continue;
-		} else {
+		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
 			m->headtype = m->type;
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
@@ -379,11 +374,6 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			if (lcn != headlcn)
 				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
-		} else {
-			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
 		}
 		lcn += m->delta[1];
 	}
-- 
2.48.1

> 
> Thanks,
> Gao Xiang
> 


