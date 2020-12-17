Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD62DD2F5
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Dec 2020 15:24:06 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CxZ4M436nzDqSZ
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Dec 2020 01:24:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1608215043;
	bh=Gdc2gSs9vYC8dXgr7KopjFZMONKzFIa4KiYkEbgL6eo=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=G/0CaIvt3H2S/Bnevafop6RqueKix4sB+ncWh0hnUHDoQhcnXGPk5VeMFQZ2TgB1Q
	 MktULvQIYrrqbjV+kX7YKIs0mzDpoCPd/d3KXYSFXFgtobr4ud1sXsfGeJ1uH8LhSv
	 b/K6Phnogd0OttvxNmm3zBrFYPXbOiYvgGn8Q/G5tjm4WtGs0LdF9GTaT4T5t6yLIM
	 W4j+2/i0LuJRBM7OKNRKabT6+9cT9yTO4qHhciI/O0ytcA2tlLY1PJ4kwmkA7OQxP2
	 FDGA2VF0E6qWm9Uz3pz2FDnHgH9KABruM8MCUy2qi1vPEF+ueMX++bppBLN021ekWT
	 dm5cMPTD9yroA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.27;
 helo=out30-27.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=ji4728oC; dkim-atps=neutral
Received: from out30-27.freemail.mail.aliyun.com
 (out30-27.freemail.mail.aliyun.com [115.124.30.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CxZ4305rQzDqQB
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Dec 2020 01:23:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1608215017; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=ErC5yLsCFv31QW6BHgmncvg+EuEAXj/Yug7sft6rVpE=;
 b=ji4728oCxV22+M58lSst8HtGuo6atNnbbBaqPTzwiYsIQdgIj4Kop5EpgDPBeE0tiHpHc00WnE8M6ymIzoSGK4UAmn1vjALWCBrmVsqCy4SbXEZpeXYDq063CRVaOfAorucxwBkTXpk30WYPM6Jxexlq20LRC3/38MVo9oZxzts=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1079112|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0340606-0.0184813-0.947458;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04400; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UIvwFAL_1608215015; 
Received: from 172.16.20.46(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UIvwFAL_1608215015) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Dec 2020 22:23:36 +0800
Subject: Re: [PATCH] erofs-utils: fuse: disable backtrace if unsupported
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201217090625.22738-1-hsiangkao.ref@aol.com>
 <20201217090625.22738-1-hsiangkao@aol.com>
Message-ID: <306c31ec-6406-3047-6ed8-f09bab75501e@aliyun.com>
Date: Thu, 17 Dec 2020 22:23:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217090625.22738-1-hsiangkao@aol.com>
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



On 2020/12/17 17:06, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> Let's enable backtrace conditionally since it's a GNU extension.
> 
> Fixes: 5e35b75ad499 ("erofs-utils: introduce fuse implementation")
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  configure.ac | 3 ++-
>  fuse/main.c  | 8 ++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
