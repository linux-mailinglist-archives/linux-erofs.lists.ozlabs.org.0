Return-Path: <linux-erofs+bounces-580-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A3AFFB77
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 09:57:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd6dY4Py1z30VZ;
	Thu, 10 Jul 2025 17:57:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752134257;
	cv=none; b=Rj/MAG+8Tf5WqXA/ewx86EnBgXGOfi0pWo/+mozs80wgik5qJqx2ZrSuk4p0WCp8MFfLFIumzK9bAq3XWtpC/WSqndBQybElFaz5xgfpKNKxg/YAMOSTwHPN4X7kUJBIUlPNdd6Ba/BpHke3g39bxiht2xr/2MbwpYrpl9t/6nr5LJjIKPmLaUhCDlPqgNUpTqJXZ1/NoyT/0VC3XvSWgPW6zW/QMwAD0VUaHYIANiyk1khdyDHLChVJ7ApFE+TwSgLM12dPCKPxkkid3bILCifcEhJ6N2oJhdqVOXWk4W7rNSjniDso3AAzS+FfIIMOYSfJuSZO1v4cK1lenczpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752134257; c=relaxed/relaxed;
	bh=4FMg+KL1yvIHkdcpUPs6xS5Q+Caxoze5aOR10u7++kA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=af1l2UbxddFy1JCHC2xpRU49mWB56rOFpEbKC+I4CRHTVitJuPGTlX0pAjfThjyYSIbmfFKApE7M+njaHGd4497qFZnWDV5boxbLygasu5ibNmRdXsn+F4Jjpj7m2ywLecoheRp4aG3qaShanWSYb3WhDuH87cGW/esA0f9P7cem2MzTTjxm2/y2ekLuSR0fvBFDaZ/d2wKRklWrioOqOopNv5RI7OVQDHo2OQukRoD8QkCQhxDnX4dBpUQZay6nY2XHYXzeuB8CbJPyuiRrfrNWLJMkSFoGxAf2awqmrXwi7KhsQPLfNonKcS1lr19ZZdOaeeoHHjkvzGG50+0VvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kgbShvcs; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kgbShvcs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd6dX5X01z2yMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 17:57:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2E163A5453B;
	Thu, 10 Jul 2025 07:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BE3C4CEE3;
	Thu, 10 Jul 2025 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134253;
	bh=cAeUtFb3ky7Chu1n9ZZZex7UIBdgbdVUpkxMm4VhNqM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kgbShvcsa8ZNyWyTxSzRh/P1oUVvjSbgcBlyHA2lGTkkKqidSoC/SLIX7b0TAWnBd
	 CJ3KTs3F7IQKiC5j9ssWPw98NS/hGwEqP3j6ctAGVAHCzMNv04Qrv7Bs4W5TyuD7fj
	 kDyj91eP0ua12mCe8pg3W4u7aUP8X0qtPr3x3wjQj75gk4Lv1U7K62aMSdbSABKYIW
	 WTyqW8nOWNZOxIwqot5pqSdvBLObhD1ILd+YLvyUKU+9HingUUS9emle9+lozpAb1x
	 YtQ7zdU09gOsj4QISIy/URfgoJQ7UYSxBj+vVMAmkbFPSnU0GrC97lkSBTIbZ7204Z
	 GMdevoMvMeEEg==
Message-ID: <156d89fd-7880-4d78-a7b1-d928fbe1a5cf@kernel.org>
Date: Thu, 10 Jul 2025 15:57:29 +0800
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
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH 1/2] erofs: allow readdir() to be interrupted
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250710073619.4083422-1-chao@kernel.org>
 <a4ab45c9-b3d2-4807-954d-1bd7d38b7242@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <a4ab45c9-b3d2-4807-954d-1bd7d38b7242@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/10/25 15:41, Gao Xiang wrote:
> 
> 
> On 2025/7/10 15:36, Chao Yu wrote:
>> In a quick slow device, readdir() may loop for long time in large
>> directory, let's give a chance to allow it to be interrupted by
>> userspace.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
>> ---
>>   fs/erofs/dir.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index 2fae209d0274..cff61c5a172b 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -58,6 +58,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>           struct erofs_dirent *de;
>>           unsigned int nameoff, maxsize;
>>   +        /* allow readdir() to be interrupted */
> 
> Hi Chao,
> 
> It seems that comment is unnecessary since the following code
> is obvious, if you have no objection I will remove this
> comment when applying.

Xiang, sure, no problem. :)

Thanks,

> 
> Thanks,
> Gao Xiang


