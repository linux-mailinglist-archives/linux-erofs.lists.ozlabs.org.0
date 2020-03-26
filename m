Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F09A194437
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2020 17:26:44 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48p9Nd5K1yzDr0T
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 03:26:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1585240001;
	bh=YhuxVBlwFzru6EPg1urYQVdkjhXz1P4LOHc2l1NQtko=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=O1Nnsxen7WsO8EFM+WrwdCgVfIsR2iIVSLwXY5GOZ2YZ+8HM9MGRNAlj1Sc2yt6J3
	 vR3ORPUpAk+N9iuQ+AVAY/1Cb6Haw3Oq6bkukZhbFitWl7gyxzDckG5d+jKAPaXuqG
	 UZS9zhpC0bY13f6HpFNCV1qwzfhjprVZ28YrQ+t6xD5gMOemiE29+F9A3dGCNoXg6L
	 Dk31UeDB6Gikv3uScR0m1YkU+izFr3AirbTRbfmkILuxRs+S84LJcnH8LTmX8UKchv
	 8919OyRI0sg8fWCtgZIWV/pub9k3IQC466ZgrcndXgzwUwOPu3rPdotNcsrJxmzeIU
	 8pYqx9lbbrrkw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.4;
 helo=out30-4.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=uUXt0rlW; dkim-atps=neutral
X-Greylist: delayed 322 seconds by postgrey-1.36 at bilbo;
 Fri, 27 Mar 2020 03:24:34 AEDT
Received: from out30-4.freemail.mail.aliyun.com
 (out30-4.freemail.mail.aliyun.com [115.124.30.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48p9LB3wgTzDr0T
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2020 03:24:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1585239860; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=biHrB8A8Rw9A5AR6fzDfHIFTLK3cBuhAUO3mBtPJpHM=;
 b=uUXt0rlW0eF85J2OOuM2GGpOGA78TCN85d26qu1rPyRh5Ni06jOUxbN/CDePRMt/ddT7wmxB4k3v5aJd8AgorK5y1H5MvMNCquJWlPXMmS+C/3MwZsaza5AzgHiYMaQy2JBPJYgKjSekvi12SMDJhaw6s1P+Wg2pGhdLo/fjaMw=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1001406|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0201725-0.00113074-0.978697;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01f04428; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---0TthwCuT_1585239534; 
Received: from 192.168.0.103(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0TthwCuT_1585239534) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 Mar 2020 00:18:54 +0800
Subject: Re: [PATCH] erofs-utils: avoid _LARGEFILE64_SOURCE and _GNU_SOURCE
 redefinition
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
 Li Guifu <bluce.liguifu@huawei.com>
References: <20200314105256.20142-1-hsiangkao.ref@aol.com>
 <20200314105256.20142-1-hsiangkao@aol.com>
Message-ID: <aaa73704-ead0-551d-4a11-fb95b88b6002@aliyun.com>
Date: Fri, 27 Mar 2020 00:18:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200314105256.20142-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
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



On 2020/3/14 18:52, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> This patch can be used to resolve the following build errors:
> 
> compress.c:10: error: "_LARGEFILE64_SOURCE" redefined [-Werror]
>  #define _LARGEFILE64_SOURCE
> 
> <command-line>: note: this is the location of the previous definition
> 
> io.c:9: error: "_LARGEFILE64_SOURCE" redefined [-Werror]
>  #define _LARGEFILE64_SOURCE
> 
> <command-line>: note: this is the location of the previous definition
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks
