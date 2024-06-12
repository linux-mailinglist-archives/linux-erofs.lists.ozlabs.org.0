Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E71905513
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 16:26:13 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ssooxjfo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VznsG2vMKz3dVK
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 00:26:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ssooxjfo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vzns56TqMz3cyM
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jun 2024 00:25:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718202354; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VPqsnngP6Msuty09s5btoVz23RhEI/2lKIgk4pnmyxU=;
	b=ssooxjfocF4umz/IcYibWIwCAi5MAnw4m1VF4rqmW6i5/nAk5p75JUZFSPm6GfQBjgBZBhenHeYbSUgis+U8jP1wnYJRKfSouxqyU3CtArGsXYAIMIDCylE8NNU+fqTUC8N47R2zmewbrLfxkJWOGynhlCE+y1cry/j0mYAmxzA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8L5hzk_1718202351;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8L5hzk_1718202351)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 22:25:52 +0800
Message-ID: <8d9753ad-9c88-49e5-b590-2e0ea9374bb4@linux.alibaba.com>
Date: Wed, 12 Jun 2024 22:25:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9.y] erofs: avoid allocating DEFLATE streams before
 mounting
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
 <2911d7ae-1724-49e1-9ac3-3cc0801fdbcb@linux.alibaba.com>
 <2024061231-nuclear-almighty-1a81@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024061231-nuclear-almighty-1a81@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/12 20:54, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2024 at 08:33:05PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> ping? Do these backport fixes miss the 6.6, 6.8, 6.9 queues..
> 
> Sorry for the delay, all now queued up.
> 
> well, except for 6.8.y, that branch is now end-of-life, sorry.

Thanks Greg!

Thanks,
Gao Xiang

> 
> greg k-h
