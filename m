Return-Path: <linux-erofs+bounces-1648-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8ACE8959
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Dec 2025 03:41:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgHQT2fQBz2yDk;
	Tue, 30 Dec 2025 13:41:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767062465;
	cv=none; b=Kgps3GTDoJwTqdxT/cGfXEtpLuKZvr7VdOa+7qZvV9op9D3tIytvY9cC1vSMilo3zVvbvDRn08ItnYLRAiE+fXqmlRGttw+2YSv9xtxRlq0tRRdcAU5f+DK7fdeUOofw7HxxfgCV6OOKE+REdhWwrQkwRaAk/BUpECWKS64xb8Ur9GO2A6FGMFVss55cpMVoJWqMmCacu/Eu0Rp3exHsLglPIWusBkTrK17+l4SyPC9jS02Ni1wIcxpLQqRayGL/M5xOre2aM7KHjCVJyFpg+xjCI9koOrH7KdH0rMsSVy9DgxPK3tfL6OvqToH2hLdPNqXYAbE7c+bx4WTrwLxtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767062465; c=relaxed/relaxed;
	bh=7T2Okcm/ZLcgNyW9y2g2gb9S65cZNgMpx3z3miyTHaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RboHDr6lBSfsEPtesSvarfQvOJOFvQ17DDrYB2jFurmTynoPlm5hdaSPfocvwQw5gqmD88ALL7WiytXBm44PKQXi3vqnEubv6nHci/K7bTJqBnmgOZ+BcNdi1N4KMqwDogt77LVxZ8MugVOgQXSUZCVU2nz0gtcFz+9jyk//vh2yIo0LLCHfte/4YyU1pH7wTtrkzVBUUf64S3jFr8vxu3sx/+QprHPN8yAhGgFz8G+/ibZdV7tiFfohDkFLr5nIjhhHkUdBmcxmNCbsaUk82t0uVPr556Itey0x4NfaEvw/MothaRwtzfPqNLMb2pEYacUStrpsvjw1V1KDifYjqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OuyeQeSV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OuyeQeSV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgHQP5QPzz2yD4
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 13:40:59 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767062455; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7T2Okcm/ZLcgNyW9y2g2gb9S65cZNgMpx3z3miyTHaY=;
	b=OuyeQeSVYyjWFWfpnv5Eiam0xXkI8jjW4iL45I9sYS8z+OvAh1XlrzQUdTt39quf/45TOHuO269vjxOKUUUpKkkDjIlTwPHHdiWq7PrcybqWuD8/+tjXYgJapmust4pETPW0J7JjYUYPm3gMWrROLX26t02GduLm3SvxuC55CWA=
Received: from 30.221.131.96(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvyVVzE_1767062453 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 10:40:54 +0800
Message-ID: <ee72357e-5861-4065-ba75-d906462fa997@linux.alibaba.com>
Date: Tue, 30 Dec 2025 10:40:53 +0800
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
Subject: Re: [PATCH 2/4] erofs: fix incorrect early exits in volume label
 handling
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
 <20251229092949.2316075-2-hsiangkao@linux.alibaba.com>
 <2568ceaf-0d94-4a9a-a5af-133487595a7a@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2568ceaf-0d94-4a9a-a5af-133487595a7a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/12/29 21:08, Hongbo Li wrote:
> 
> 
> On 2025/12/29 17:29, Gao Xiang wrote:
>> Crafted EROFS images containing valid volume labels can trigger
>> incorrect early returns, leading to folio reference leaks.
>>
>> However, this does not cause system crashes or other severe issues.
>>
>> Fixes: 1cf12c717741 ("erofs: Add support for FS_IOC_GETFSLABEL")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Since you already reviewed the first two patches, I wonder
if you can review the remaining two patches too since they
are all trivial?

Thanks,
Gao Xiang

