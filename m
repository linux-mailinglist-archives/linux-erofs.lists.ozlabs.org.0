Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331B874856
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 07:50:55 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eyAVcOAg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr0Lj1p4Yz3dVf
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 17:50:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eyAVcOAg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr0Lc2L1vz3d28
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 17:50:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709794243; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VjKpKALca+cRV+EtKGDHobe2Vrr2piVSSVolsSe4T+I=;
	b=eyAVcOAgqlTu8SQAPGxEjnNQxkdNGXrNQRGp8qekJyXrSwLbRzoK8hUn/mIO/zUQgG34uTWHD0tpmUJxQ7PXKHtc5jXZtNGJAFfSKQRUpA1XN6LkjhBjNEmy39Dmu4GhLe+sB1e/w6zzI6kjBo/fGwkTgiBPKKbchS27si1/SEg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W1zqQ-3_1709794240;
Received: from 30.97.48.224(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1zqQ-3_1709794240)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 14:50:41 +0800
Message-ID: <b6d800fc-b5f7-4a2e-9d7d-f57196717341@linux.alibaba.com>
Date: Thu, 7 Mar 2024 14:50:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
To: Baokun Li <libaokun1@huawei.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
 <7e262242-d90d-4f61-a217-f156219eaa4d@linux.alibaba.com>
 <65d09bbe-9389-4502-1504-8c1557fe5e52@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <65d09bbe-9389-4502-1504-8c1557fe5e52@huawei.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/3/7 14:46, Baokun Li wrote:
> On 2024/3/7 11:41, Jingbo Xu wrote:
>> Hi Baokun,
>>

...

> Thank you for your feedback!
> 
> If I understand you correctly, you mean to remove erofs_pseudo_mnt
> directly to avoid this false positive, and use anon_inode_create_getfile()
> to create the required anonymous inode.
As Al pointed out, you could just follow his ideas
since it's mainly a VFS POV...

Thanks,
Gao Xiang

> 
