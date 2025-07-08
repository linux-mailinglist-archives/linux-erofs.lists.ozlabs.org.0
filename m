Return-Path: <linux-erofs+bounces-549-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0DCAFC3AA
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 09:10:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbsh338SMz30gC;
	Tue,  8 Jul 2025 17:10:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751958627;
	cv=none; b=bKeLSyf/PltAKj0If+rKy7kHsB+QtLjdHZOZ5pTQNws8/HqkqYjgZ4SM9q7k24ASvZk5KCXm4DpI26kBjdnbghJXS/fZPWsLpXvDpCL3w0F3vcNZkdtPKhcwRvx6utu9fU/8MI7BjWig6Oe3rtVqx+yrFUPYImSO3zMsTId9zXURQVD35tvQLr/FG+Sta7an6oppCdyRi8WYAJhlOzwFnfBjP+ye2f02c86yJLqaBZkQLrwnMtvAM/HtWuLhXjztxMOdQ4TUr+MjuMiBdBv3SdR089oUnKuw9ukij+ih/W/icTmSFWmHFs5zeKvZOASxwILCeBtLzoRURYTigorwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751958627; c=relaxed/relaxed;
	bh=NDH79zBCG+UHDshpiWbK/ZFJLCc/iXNK2rwwl7cQUJU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f49GcQP5m1A4doJcmPXBNpFWsY70Zp5j8hxL5iuLopkZRq8HLiUsR5dpLIQaK5sfZ9omP6ZDH8UO1zOCBCOdfWVENlZj4BKQ99f37dA/KX3yxzQYAuXu/D1MQ8K4kpf2MXTXHhDW7rmLiQcnuOkOWowqhVJdlcT7I/eycojPFwa+6aOEU5w8DeOBGIidxqGxd+roz84zCVja81FxEJzvL6kx8uMOGdxoMbeSnWwONwXQPS8q4ERPh8NdjLjPu7NesOSwjn1stjszeT7kSfSfYPEvJm/2LLU3ErRu4Ww3k6BOx+sWnKKcWXAYxDJKizp+vlQc9QF4Sm5VAEBXyhTkdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fDOWvthk; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fDOWvthk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbsh23bTbz30Wn
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 17:10:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0B6095C5F4D;
	Tue,  8 Jul 2025 07:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E6C4CEED;
	Tue,  8 Jul 2025 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751958623;
	bh=P45Jk/EmJUMA81OY9ojg02wzUNzOoajhvXGsnpXs8Ys=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fDOWvthkF/PYY1fFyalR5jpp7QEJLtaZoppHEoYiEUJG02a3bYcDmMSISpa3oMvb0
	 yWlCBQDr83jKppejL5tdrYw2vg4zGGHldEwgorVP0lByMAr7Gy2zYDJOFHVkk2eT65
	 7VUpkxepp9+pII95ix77NMFpzURiTGPRhvmcDwTJef4k7rfEGtWN42prr37wOzLbHD
	 3J7yQensvq3+SnrPD2HOKVRPJFbnsCwyMOHF2UvKzfrt8O1Sv/b74dEoMLalj1otaa
	 xWlcYhEmr5R4f4tlS58rhpwWdQ/a9C8EzhzDXMfq+RgQWbpivHlt7kdqN3mebeYiBm
	 3WGbfo0yt0JWg==
Message-ID: <6edacba6-a97e-460f-af06-96e8acf5546a@kernel.org>
Date: Tue, 8 Jul 2025 15:10:19 +0800
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
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Hongbo Li
 <lihongbo22@huawei.com>, xiang@kernel.org
References: <20250707084723.2725437-1-chao@kernel.org>
 <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
 <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/8/25 10:35, Gao Xiang wrote:
> 
> 
> On 2025/7/8 10:30, Hongbo Li wrote:
>>
>>
>> On 2025/7/7 16:47, Chao Yu wrote:
>>> All below functions will do sanity check on m->type, let's move sanity
>>> check to z_erofs_load_compact_lcluster() for cleanup.
>>> - z_erofs_map_blocks_fo
>>> - z_erofs_get_extent_compressedlen
>>> - z_erofs_get_extent_decompressedlen
>>> - z_erofs_extent_lookback
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
>>>   1 file changed, 22 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>> index 0bebc6e3a4d7..e530b152e14e 100644
>>> --- a/fs/erofs/zmap.c
>>> +++ b/fs/erofs/zmap.c
>>> @@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>>>   static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
>>>                          unsigned int lcn, bool lookahead)
>>>   {
>>> +    if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +        erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
>>> +                m->type, lcn, EROFS_I(m->inode)->nid);
>>> +        DBG_BUGON(1);
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>
>> Hi, Chao,
>>
>> After moving the condition in here, there is no need to check in z_erofs_extent_lookback, z_erofs_get_extent_compressedlen and z_erofs_get_extent_decompressedlen. Because in z_erofs_map_blocks_fo,
>> the condition has been checked in before. Right?
> 
> I've replied some similar question.
> 
> Because z_erofs_get_extent_compressedlen and z_erofs_get_extent_decompressedlen()
> use the different lcn (lcluster) against z_erofs_map_blocks_fo().
> 
> So if a new lcn(lcluster number) is loaded, we'd check if the type is valid.

Yeah, Xiang has noticed that previously [1], the case is as below, so we'd better check the
condition in z_erofs_load_compact_lcluster() rather than z_erofs_map_blocks_fo():

- z_erofs_extent_lookback
 - z_erofs_load_lcluster_from_disk
  - z_erofs_load_full_lcluster
  : m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
 - z_erofs_load_compact_lcluster
 : m->type = type;

[1] https://lore.kernel.org/linux-erofs/04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org/

Thanks,

> 
> Thanks,
> Gao Xiang
> 
> 


