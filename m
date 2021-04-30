Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44036FE5E
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 18:17:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWyFt4YB5z2yy9
	for <lists+linux-erofs@lfdr.de>; Sat,  1 May 2021 02:17:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1619799474;
	bh=wfOssoSNj+jsojEgrlO0v7AeLUyXvvG1gZR5mzhxdjg=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=gnJLw/RqL40eA3Hvp8IQpQuj1hNWVzNdO1LrUssEebzxGoYnBieadDK5n8I3GpVXe
	 FLxdQejYp34CrmjR1ao5Khc2M0+pOtB/UAyXFnGTDV6RUiZDXZMhF/wi4j9ClmJ/JR
	 HoAh+ZquCfUFxsVvOB1cHwQnzJ2EM5G18kBZMrQzBYMvd9Ae5cFTrPr05TeP2XtedA
	 y1syHSOq7nXCum4Jse8GWol1Oj53vbuWZlLfMNm5Al9GAZQUQaLX5YPbJBlMgde6aB
	 8bsNCqCdFzFfBvImrQcrou8KQZv9ly+tIRV7OFcR3dY2kOTbwQbmxF0CMA84QTZsuG
	 OvfO8tDyaUVUA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.14;
 helo=out30-14.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=Q/lm+M03; dkim-atps=neutral
Received: from out30-14.freemail.mail.aliyun.com
 (out30-14.freemail.mail.aliyun.com [115.124.30.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWyFp6wr7z2xZG
 for <linux-erofs@lists.ozlabs.org>; Sat,  1 May 2021 02:17:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2471704|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.00587421-0.000469466-0.993656;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04426; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UXHjxeV_1619799455; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UXHjxeV_1619799455) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 01 May 2021 00:17:36 +0800
Subject: Re: [PATCH v4 5/5] erofs-utils: manpage: add manual for erofsfuse
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Li Guifu <bluce.liguifu@huawei.com>
References: <20210430040345.17120-1-xiang@kernel.org>
 <20210430040345.17120-5-xiang@kernel.org>
Message-ID: <0c145ccd-e082-9b45-b555-d12d172d027b@aliyun.com>
Date: Sat, 1 May 2021 00:17:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210430040345.17120-5-xiang@kernel.org>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/4/30 12:03, Gao Xiang wrote:
> This patch adds missing erofsfuse manpage.
> 
> Signed-off-by: Gao Xiang <xiang@kernel.org>
> ---
>  man/erofsfuse.1 | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 man/erofsfuse.1
> 
It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
