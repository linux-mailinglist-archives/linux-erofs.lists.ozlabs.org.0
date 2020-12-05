Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A722CFAA9
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 09:43:06 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp34R1kcjzDqjp
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 19:43:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607157783;
	bh=VCflHxqumDarff5cOu17HrHTEBKQXkH80zoj9mDv1/Y=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OfRI4dUhioBXxuj1KMa7Jc6Tr4GNhKwDMv9/IbFx7pHLB257xId6qIZ3k8auFaPeT
	 48LjfGWV5DFDktfxFUiMWrfoFRu5ZUtReeBpa6AE2Ne245DlEysgzuMncBrwsN7JQx
	 XKzRgdO5r8pz1mLbPTklWU2LSrScf6ZZYHnynXP5X7vIUYEqkr3RV7k45QPqmJslNS
	 SQM9IUhAor45pLG79vOA01FMdEGV3OEzQjKLv0G6CWQ0MeBDpiDgE8Pvnk3a4MXau9
	 xpdwIjTOnDF72OkrHw/fafIuLDdDcQDv7R1NaS1LQTmxZa2NkYilN3Qb5fo1hOFBsI
	 YLaX8EusvkZiA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.5;
 helo=out30-5.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=pRNqantw; dkim-atps=neutral
Received: from out30-5.freemail.mail.aliyun.com
 (out30-5.freemail.mail.aliyun.com [115.124.30.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp34J0Dg4zDqWH
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 19:42:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607157757; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=TVRAmdClZJ5OKLvfzvEYnWvc+kaLXVg+jujx1dIU5aM=;
 b=pRNqantwLkIVU4szx28TGWtnWwrgsDwU7AFAwtodYF3PhwCRAzMB+O9PHpQjCmcLEFrBgpOcvbcphiHYM958gSyItcUk1gfAnFIQpoTu6G7QwMRT0GJfbL03ITZ/LCgxVYnfCqS+dOtJwVEyHS7lXUoElHlFlT8lmVmqfYUUE98=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1007826|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.113021-0.00746022-0.879519;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04426; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UHa1uGE_1607157756; 
Received: from 172.168.2.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UHa1uGE_1607157756) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 05 Dec 2020 16:42:36 +0800
Subject: Re: [PATCH v4 3/3] erofs-utils: fuse: add compressed file support
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201127114617.13055-4-hsiangkao@aol.com>
 <20201127122409.7035-1-hsiangkao@aol.com>
Message-ID: <798ecfbd-e5a7-0688-0189-55b296c56e78@aliyun.com>
Date: Sat, 5 Dec 2020 16:42:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201127122409.7035-1-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2020/11/27 20:24, Gao Xiang via Linux-erofs wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> This patch adds a simple approach (~ 700 LOC) to EROFS fixed-sized
> output decompression without inplace I/O or decompression inplace
> so it's easy to be ported everywhere with less constraint.
> 
> However, the on-disk compressed index parser (aka. zmap) is largely
> kept in line with the kernel side, therefore new on-disk features
> under development can be verified effectively first here.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> changes since v3:
>  - fix build error without lz4 library.
> 
>  include/erofs/decompress.h |  35 ++++
>  include/erofs/defs.h       |   5 +
>  include/erofs/internal.h   |   8 +
>  lib/Makefile.am            |   2 +-
>  lib/data.c                 |  72 ++++++-
>  lib/decompress.c           |  87 ++++++++
>  lib/namei.c                |   4 +
>  lib/zmap.c                 | 415 +++++++++++++++++++++++++++++++++++++
>  8 files changed, 626 insertions(+), 2 deletions(-)
>  create mode 100644 include/erofs/decompress.h
>  create mode 100644 lib/decompress.c
>  create mode 100644 lib/zmap.c
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Tested-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
