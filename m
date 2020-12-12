Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66E2D854C
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Dec 2020 10:04:49 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CtMD71mdQzDqpr
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Dec 2020 20:04:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607763879;
	bh=8w2KVJmHvCAemzZ8XDjWl2qC8Hj+5REHZAqK25RSmUY=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Drbcd0fZjxhzz42QkIqngmOn2wuKPOeF0FezaHbdQlOPhRZY0ySg7qGxLhDLZiOci
	 /TA3kiRlxPrGbgRVqmfPKNaAhhUxmvSIsJkl3ZZzyyE0iPuv84J/JzQDwcZRPBLmlh
	 XjNUgTLf9OwFTkIuPuqJ28K51P0H1T6wRh7vBWKZUPXZXD1CyeECMHACuAVeC6jiJa
	 E9GHQUCP1yVjhGINwjZaN1Bu4S6c8M3ninva2TeFO6uXZzxQlQE0Z+gPl50vqIuK7J
	 M+ziKIXq0p3hCCmOzW/X74tlGeW+UlnHd5WASxD7i//5x2KJlRu0k+qv407lhyBSxy
	 Ti/mpkicHPROg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.38;
 helo=out30-38.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=S5i42roR; dkim-atps=neutral
Received: from out30-38.freemail.mail.aliyun.com
 (out30-38.freemail.mail.aliyun.com [115.124.30.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CtMCz2jFwzDqnF
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Dec 2020 20:04:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607763853; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=x5rmhfC76uEgCOJkMqANyXYWBy/zrpOAULldTVvk7/4=;
 b=S5i42roRaviLQreII2S3IFLJe+NhEZdTGvziNp+szXao2AlMKjVPVEab8FUq16lZkOdczvqoHONVTFBzFdZwKCdL2XDkt1EzuJP1Yxzqb5fSj+TA2O+iO3X5m9w8SZqosllxPGtMIOmEyjD2RE5hqyq2btY9SGsNwq7v4CxlQy0=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1147502|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_social|0.00476732-0.000386185-0.994846; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01e04407; MF=bluce.lee@aliyun.com; NM=1; PH=DS; RN=3; RT=3; SR=0;
 TI=SMTPD_---0UIJzhfb_1607763851; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UIJzhfb_1607763851) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 12 Dec 2020 17:04:11 +0800
Subject: Re: [PATCH] erofs-utils: mkfs: fix uuid.h location
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201209004937.1672-1-hsiangkao.ref@aol.com>
 <20201209004937.1672-1-hsiangkao@aol.com>
Message-ID: <8b27d4e3-46fa-ec9d-409f-6440d5d1749a@aliyun.com>
Date: Sat, 12 Dec 2020 17:04:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209004937.1672-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Cc: Karel Zak <kzak@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2020/12/9 8:49, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> As Karel reported [1], "The subdirectory in
>     #include <uuid/uuid.h>
> 
> is unnecessary (or wrong), if you use
>     PKG_CHECK_MODULES([libuuid], [uuid])
> 
> than it returns the subdirectory as -I, see
> 
>     $ pkg-config --cflags uuid
>     -I/usr/include/uuid
> 
> so the correct way is
>      #include <uuid.h>". Let's fix it now!
> 
> [1] https://lore.kernel.org/r/20201208100910.dqqh5cqihewkyetc@ws.net.home
> 
> Reported-by: Karel Zak <kzak@redhat.com>
> Fixes: e023d47593ff ("erofs-utils: support 128-bit filesystem UUID")
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  mkfs/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
