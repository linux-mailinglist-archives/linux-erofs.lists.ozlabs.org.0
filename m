Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCB8912041
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 11:14:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KoRHQx9v;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W5BWd610Pz3cSK
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 19:14:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KoRHQx9v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W5BWV3PyKz30Vb
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 19:14:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718961263; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O9mP/08aAQ9dyg28He1RiA58IjqYB58NI0tJ1WKuAY0=;
	b=KoRHQx9vyZn1+ENWBJy/x04AJPxAqA0xrdit0N+Vjs1makH1Gtcj0/pNHdmSc+gTatcjY7B9YI3pPZXuCAbXK8RiMnFrJna98yKjzvIKqEjfBNYFpFAbp8GlvM4Rh8IaS5YvV9uNaUCyOAe1Yz0uctGSzAtNaISrOgUxqJTeixI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8vr-NK_1718961260;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8vr-NK_1718961260)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 17:14:21 +0800
Message-ID: <c4748d68-b61f-4935-815b-f4d3af77f890@linux.alibaba.com>
Date: Fri, 21 Jun 2024 17:14:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cachefiles: support query cachefiles ondemand feature
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-3-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240621061808.1585253-3-lihongbo22@huawei.com>
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
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/21 14:18, Hongbo Li wrote:
> Erofs over fscache need CONFIG_CACHEFILES_ONDEMAND in cachefiles
> module. We cannot know whether it is supported from userspace, so
> we export this feature to user by sysfs interface.
> 
> [Before]
> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
> cat: /sys/fs/cachefiles/features/cachefiles_ondemand: No such file or directory
> 
> [After]
> $ cat /sys/fs/cachefiles/features/cachefiles_ondemand
> supported
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

I don't think such sysfs is needed, you could just use
`bind ondemand` to check if it is supported:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/cachefiles/daemon.c?h=v6.9#n780


Thanks,
Gao Xiang
