Return-Path: <linux-erofs+bounces-79-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 76303A640FF
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Mar 2025 07:15:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGPpk4DNJz2yd7;
	Mon, 17 Mar 2025 17:15:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742192126;
	cv=none; b=EmT8VqFEJbMr/qT3/FggXYtDwrwvK5CkrdKkCqWwbP15k2jSFEr9SxWuqemU+y5Qgc2Yn5DcWRnFx/m+MlUCJ/3NEtRvUB9/NiudxHoZQGqn5RwDbaXAZ23kQIu3JPB4k5pM4ngP5tK0LEKk/e+Pdv/qdzwKTWoZZdS0gaCHm40jDbAaaeSoG9IqQDvUAuJuwZFAbcE8i7gXc+i0och2vvE+QMz+be5kk1QmVUrMrQnKuNUChaiqUldsXNDkOFkLI/QejgkavJJjlIByuqO/fn9pip1aiZcMTaP26U4gWWpvaGFwic5AsyXGetjM8bsQ9StZBLwR2NdwZswrSI6HEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742192126; c=relaxed/relaxed;
	bh=lcumtgAUnd66okozoJf6gqw1VxhKrCwQJRm3zl3dAOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiD3usG3AnTDb/X3vR/tdncQBsa3ZDLML/EoyDffiPNEw0dsJ6sjXg9eKKWoxfh3VvzzNdU1MM4a74Ai4XphJxYFuVP0puv1kQieZ4REEEsguZhTQ/4sPkuGrDbCcOFnmW38+4Xv0kAplq6K8SHi+VyE7RXNrpfmy+D83chADEeHa2VprqR6dfh0ZHS/JgvLt5JhniVXZcQM1LDM1pRDqR1ruuPhnyVr8NtY/IqBAqs8fEHwkq4pLMZ3EM4nNHr30a0nUazs5AwOCiGTF7tOJkOkRIv8qP+NMVAiTxxOpAG0dtGMz85oXhiuqIoQfXmy9u1FPyny3aSvzVfV5dv/5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=psvBrGWG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=psvBrGWG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGPpg712Yz2yGM
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Mar 2025 17:15:22 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742192119; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lcumtgAUnd66okozoJf6gqw1VxhKrCwQJRm3zl3dAOI=;
	b=psvBrGWGBp4hFjfP/VHAeab7a5mDBqlWjgFBok6FogYK4hMZ1d1jiu9WR8IDkCQcn+/VrH72MawtN9O2SDCfUe081YnQEcRam4Q3VGBwdAYjMq8neHH2veFP6BIlHlY8n6lIkYkVcasUPf/tBal+DapRUpu+Zp7z9NBUxiyXuV4=
Received: from 30.74.130.1(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRZQMxw_1742192118 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 14:15:18 +0800
Message-ID: <18767765-53b5-4e78-b50d-9305fe1cb2d0@linux.alibaba.com>
Date: Mon, 17 Mar 2025 14:15:16 +0800
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
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
 <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

On 2025/3/17 14:03, Chao Yu wrote:
> On 3/17/25 01:17, Gao Xiang wrote:
>> Hi Chao,
>>

...

>>
>> Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
>> introduced, but the `default:` case is already deadcode now.
> 
> Xiang, thanks for the explanation.
> 
> So seems it can happen when mounting last image w/ old kernel which can not
> support newly introduced Z_EROFS_LCLUSTER_TYPE_* type, then it makes sense to
> return EOPNOTSUPP.

Yeah.

> 
>>
>>>
>>> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
>>> then we can treat m->type as reliable variable later.
>>>
>>>       advise = le16_to_cpu(di->di_advise);
>>>       m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>>>       if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>
>> It's always false here.
> 
> So, what do you think of this?
> 
>  From af584b2eacd468f145e9ee31ccdeedb7355d5afd Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Mon, 17 Mar 2025 13:57:55 +0800
> Subject: [PATCH] erofs: remove dead codes for cleanup
> 
> z_erofs_extent_lookback() and z_erofs_get_extent_decompressedlen() tries
> to do sanity check on m->type, however their caller z_erofs_map_blocks_fo()
> has already checked that, so let's remove those dead codes.

z_erofs_extent_lookback() will (lookback) read new lcn in
z_erofs_load_lcluster_from_disk() so it won't be covered by
the original z_erofs_map_blocks_fo().

I think this check can be resolved in
z_erofs_load_lcluster_from_disk() instead but maybe address
for the next cycle? since there are already enough features
for this cycle and I have to make sure no major issues....

Thanks,
Gao Xiang

