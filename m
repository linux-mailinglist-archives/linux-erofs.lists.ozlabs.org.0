Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC272CFA59
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 08:53:34 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp1zH5p61zDqd2
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 18:53:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607154811;
	bh=vkmqzZXtNtNss0/NQdL++psN4/UEGSSgrZVrsph6K4I=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=jHglZOORtfO8mk5rvGolnNWG/z/Be3waC0SjU6rn7Aqrv4NmjVJGgnVNbjOtLsLAh
	 BT2lDPJAJJHtl6bCgpei/JqkJ4CBklCqcda78AGEto4CHt4TFRNg99vzaeIjzUuIr9
	 ubyiHb4wlIuHsK9L929bMkkUpr8NiQfFYHEvqivaRKB/nzKFBJQKSJ9mM0R9N3MokH
	 4NerK+E8JOnv+OQhuwcmkeCHeGecdt/spTDmQTwso55lUzwX2G6N0XycAYN3SwLDNS
	 pGoldn+lJ9PrQS6vfx5q1xnz5LG0dm8C23j5DI5+UKryXEzvvSvEGyouNmnDJKHhUC
	 o1ryz0jqhLz3A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.40;
 helo=out30-40.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=YsRdYN3x; dkim-atps=neutral
Received: from out30-40.freemail.mail.aliyun.com
 (out30-40.freemail.mail.aliyun.com [115.124.30.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp1z63g62zDqVR
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 18:53:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607154796; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=2wKWlbVwRVCtVEIko+GLaTfgNEc7gesRKwbl14osIJI=;
 b=YsRdYN3xoeo3tZnH/H/HxDsJ+N/WtMStJ/hqjZanxCtQA+XiBDFi/23UNFtUDAQmZ+vOr/f2jQkuj1E+BmbCFGJXv2NiyXV15/yC9quPWnvo6np6pHMBHAdBvt7RO09otPby1V2ieK/4+CmyeSmw8yX7xkTxn9m9etz1lttf24k=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1471251|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_news_journal|0.00348758-0.00123026-0.995282;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04400; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UHZv2if_1607154794; 
Received: from 172.168.2.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UHZv2if_1607154794) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 05 Dec 2020 15:53:14 +0800
Subject: Re: [PATCH 1/2] erofs-utils: don't create hardlinked directories
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201204172042.24180-1-hsiangkao.ref@aol.com>
 <20201204172042.24180-1-hsiangkao@aol.com>
Message-ID: <42b78052-d9e9-045b-1b23-6f736e01fd6d@aliyun.com>
Date: Sat, 5 Dec 2020 15:53:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201204172042.24180-1-hsiangkao@aol.com>
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



On 2020/12/5 1:20, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> From: Gao Xiang <hsiangkao@aol.com>
> 
> Fix an issue which behaves the same as the following
> mkisofs BZ due to bindmount:
> https://bugzilla.redhat.com/show_bug.cgi?id=1749860
> 
> Fixes: a17497f0844a ("erofs-utils: introduce inode operations")
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> regression testcases will be uploaded to:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests
> for now (erofs-utils v1.3 will include testcases then.)
> 
>  lib/inode.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
