Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B978FD14D
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 16:59:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N7VnMW4Y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvVxJ2wVKz3brC
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 00:59:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N7VnMW4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvVx62HBGz30Tp
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 00:59:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717599570; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UKDGoGqR+vXsq35B+ekWWNLpAZgkfPuNDp+b7EgRVCI=;
	b=N7VnMW4Y/wQI1FqpvFdtm8iNiSNLOsjVN6lz+VrTxsCiTaOsvCmSrekr8rQG/X3KDqGjI8aguStJw3F2Ph0pVfFeiBuDO7aW5nNVeQyPkBNH19GJEz8TVMuR36A2wqBZweHpZ1aazpqxUaQu/WrHsvbSJGUPogcDZr58B73JTdI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7vPktO_1717599567;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7vPktO_1717599567)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 22:59:28 +0800
Message-ID: <cd4cb812-88a3-4cb6-ae92-dc20d706642b@linux.alibaba.com>
Date: Wed, 5 Jun 2024 22:59:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/erofs: fix an overflow issue of unmapped extents
To: Jianan Huang <jnhuang95@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20240605140554.1883-1-jnhuang95@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240605140554.1883-1-jnhuang95@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, wjq.sec@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/5 22:05, Jianan Huang wrote:
> Here the size should be `length - skip`, otherwise it could cause
> the destination buffer overflow.
> 
> Reported-by: jianqiang wang <wjq.sec@gmail.com>
> Fixes: 65cb73057b65 ("fs/erofs: add lz4 decompression support")
> Signed-off-by: Jianan Huang <jnhuang95@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
