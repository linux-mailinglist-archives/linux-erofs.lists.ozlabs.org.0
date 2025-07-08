Return-Path: <linux-erofs+bounces-546-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D6AFC0E1
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 04:35:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bblZg3ypLz3064;
	Tue,  8 Jul 2025 12:35:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751942123;
	cv=none; b=Q7mBKbeiYSiLM+mkq+VFp5Oik5h8EvHhKCaV0NZeFQEEex1HUr+VpwVEUnpXqsU6xpaHXJGDPu+sjnae2tiBkMcQnMIX/XHtToZbnQChoX0fVYvriDrV9jdN7rdSN3b5plyc1muyQYlpaxRksnM+NhgeplLAB4SFW/SjJkbisFfsPhRC3j51fTxJu1ScQLOcrL+bUWtwnmGt3qwWnWCzz62dJZ4sKLuSgZPgOYcBSRMZbwUrpV8M1tMxymsOOEHCwbvAWViR3xEBHMK4fArvghV+ZJ7ahItm+XpxBN+668+TxcTq+aHfcc31ZVlkpq6kVgq3ScbfgRoxK4Md09smFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751942123; c=relaxed/relaxed;
	bh=DJouJoPGQ/wtVO05sl/QvXv0R/AiW/eMB9jzTKKTOXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwEa65BHrDH72hs26pXrXefjBG4oimvry2Uafr6ENWak8QKXGFYEzH7bUH4Yupskh4FLz8INgih7JM2PsMCQ+dn4WzVYal4pg4yL0p7WvaT8eigisZXrBqT3P9h6+X9pUyl5kwE2z9whlpc6G5L30+U3vhSHZD8cHt3sOrs+0O4Ub3wdRUmK+BiHdlGuLqMg4/WSZsvnVpxZ6TtH0q2NOuiYyCnaFMxebXCAln32kWqIUMoMBUrJJIMfX02HE+m9hMnJlSD+tFOXR2+Pm92cRtAN2qVwKDPEbwv6LqRJtmDMokmiRV5zOS0B/8Mw96XJWqHKevwGtUBrtJjXQARZQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hmh3ZYy7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hmh3ZYy7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bblZd4JKJz2yFP
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 12:35:20 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751942117; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DJouJoPGQ/wtVO05sl/QvXv0R/AiW/eMB9jzTKKTOXM=;
	b=hmh3ZYy709mIg/2cXQSGp17YkD5mN0WbsxkWsf0LcwHHDeWcxCEn+xvIJ5O+xGrOjxHnlF3SBJtWwG1cEB7/8t7ipzrK9c0xR9Dy5WH1wYVpwk6pgM72R97pkyN4RIxdpEovd2G96bcrPu6jz0NLQfx5hamQ4z2VRdtu1H83sWo=
Received: from 30.221.131.215(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiIzyXk_1751942101 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:35:16 +0800
Message-ID: <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
Date: Tue, 8 Jul 2025 10:35:15 +0800
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
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Hongbo Li <lihongbo22@huawei.com>, Chao Yu <chao@kernel.org>,
 xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>
References: <20250707084723.2725437-1-chao@kernel.org>
 <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/8 10:30, Hongbo Li wrote:
> 
> 
> On 2025/7/7 16:47, Chao Yu wrote:
>> All below functions will do sanity check on m->type, let's move sanity
>> check to z_erofs_load_compact_lcluster() for cleanup.
>> - z_erofs_map_blocks_fo
>> - z_erofs_get_extent_compressedlen
>> - z_erofs_get_extent_decompressedlen
>> - z_erofs_extent_lookback
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
>>   1 file changed, 22 insertions(+), 38 deletions(-)
>>
>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>> index 0bebc6e3a4d7..e530b152e14e 100644
>> --- a/fs/erofs/zmap.c
>> +++ b/fs/erofs/zmap.c
>> @@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>>   static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
>>                          unsigned int lcn, bool lookahead)
>>   {
>> +    if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>> +        erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
>> +                m->type, lcn, EROFS_I(m->inode)->nid);
>> +        DBG_BUGON(1);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
> 
> Hi, Chao,
> 
> After moving the condition in here, there is no need to check in z_erofs_extent_lookback, z_erofs_get_extent_compressedlen and z_erofs_get_extent_decompressedlen. Because in z_erofs_map_blocks_fo, the condition has been checked in before. Right?

I've replied some similar question.

Because z_erofs_get_extent_compressedlen and z_erofs_get_extent_decompressedlen()
use the different lcn (lcluster) against z_erofs_map_blocks_fo().

So if a new lcn(lcluster number) is loaded, we'd check if the type is valid.

Thanks,
Gao Xiang


