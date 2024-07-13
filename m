Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C549303AD
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jul 2024 06:44:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IOL5SEQB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WLbTc3DtPz3cXd
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jul 2024 14:44:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IOL5SEQB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WLbTV5KGPz30Sv
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Jul 2024 14:44:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720845847; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pbw5HE5q1zUNveorgQOxPxxxjsrNzfWAQYEcqlUSdtk=;
	b=IOL5SEQBkGtGgkNlfyy4QSbY5/7FxYFm8vGX+36XnQpWjK2eSJV6E1WZkExMfNk4Ec2M8WaTuC84OhYS2n0LQkF9LMkq6KnFFLrWy9YKjrTWVOU+9wlUr69Mn1U9g+8ocbqwz/Kg+WaxraNA2lFro8sQKJnoxjV4QSeIeISANDA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAQ.gRt_1720845845;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAQ.gRt_1720845845)
          by smtp.aliyun-inc.com;
          Sat, 13 Jul 2024 12:44:06 +0800
Message-ID: <91b66d05-eeff-4d84-a726-cee087bce967@linux.alibaba.com>
Date: Sat, 13 Jul 2024 12:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: silence uninitialized variable warning in
 z_erofs_scan_folio()
To: Dan Carpenter <dan.carpenter@linaro.org>, Gao Xiang <xiang@kernel.org>
References: <f78ab50e-ed6d-4275-8dd4-a4159fa565a2@stanley.mountain>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <f78ab50e-ed6d-4275-8dd4-a4159fa565a2@stanley.mountain>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/13 09:04, Dan Carpenter wrote:
> Smatch complains that:
> 
>      fs/erofs/zdata.c:1047 z_erofs_scan_folio()
>      error: uninitialized symbol 'err'.
> 
> The issue is if we hit this (!(map->m_flags & EROFS_MAP_MAPPED)) {
> condition then "err" isn't set.  It's inside a loop so we would have to
> hit that condition on every iteration.  Initialize "err" to zero to
> solve this.
> 
> Fixes: 5b9654efb604 ("erofs: teach z_erofs_scan_folios() to handle multi-page folios")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, applied.

Thanks,
Gao Xiang
