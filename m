Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389680C2C2
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Dec 2023 09:11:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SpZFP51b0z3bWy
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Dec 2023 19:11:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SpZFL1nHCz30XZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Dec 2023 19:10:59 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyDC938_1702282251;
Received: from 30.97.48.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VyDC938_1702282251)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 16:10:52 +0800
Message-ID: <9fd5a85e-2521-4295-938b-bedb9ee1b67b@linux.alibaba.com>
Date: Mon, 11 Dec 2023 16:10:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] erofs: support I/O submission for sub-page compressed
 blocks
To: linux-erofs@lists.ozlabs.org
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
 <20231206091057.87027-2-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231206091057.87027-2-hsiangkao@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/12/6 17:10, Gao Xiang wrote:
> Add a basic I/O submission path first to support sub-page blocks:
> 
>   - Temporary short-lived pages will be used entirely;
> 
>   - In-place I/O pages can be used partially, but compressed pages need
>     to be able to be mapped in contiguous virtual memory.
> 
> As a start, currently cache decompression is explicitly disabled for
> sub-page blocks, which will be supported in the future.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

...

> +		cur = mdev.m_pa;
> +		end = cur + pcl->pclusterpages << PAGE_SHIFT;

In this patch, here should be
end = cur + (pcl->pclusterpages << PAGE_SHIFT);

but since this line will be immediately updated in the next patch
as `end = cur + pcl->pclustersize;` so it will have no impact.
I've fixed it up in the development tree.

Thanks,
Gao Xiang
