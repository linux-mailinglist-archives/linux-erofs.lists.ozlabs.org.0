Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3DB912049
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 11:17:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GGFidwe8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W5BZS1lFKz3cW1
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 19:17:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GGFidwe8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W5BZN2fFZz30W0
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 19:16:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718961417; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wiiUV5lFg3P81nGdqXa0NIdIwHVNHSBPtJsi4JxnXYo=;
	b=GGFidwe8T7iYgGClWY6OOoO8UiqzgD/hYYCh/WNKcEdVxcA6gPxGCd9eSeNYk26v/bt3e6T4GcwLaxS23KCYkvu23jBtBujXynVNuISnVaEIN1f0jIDWRTVoHcS8uvuCEdlfOOdl0WxvrReXYrK/ZzRXf0OuGTfw6RYr5gzqOQ4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8vqdoJ_1718961414;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8vqdoJ_1718961414)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 17:16:55 +0800
Message-ID: <2a3fa2a6-8a34-456a-b471-9eec83a4ba74@linux.alibaba.com>
Date: Fri, 21 Jun 2024 17:16:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: support query erofs ondemand feature by sysfs
 interface
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
 <20240621061808.1585253-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240621061808.1585253-2-lihongbo22@huawei.com>
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
> Erofs over fscache depands on the config CONFIG_EROFS_FS_ONDEMAND
> in erofs. There is no way to check whether this feature is supported
> or not in userspace. We introduce sysfs file `erofs_ondemand` for
> user checking current features. Here is the example:
> 
> [Before]
> $ cat /sys/fs/erofs/features/erofs_ondemand
> cat: /sys/fs/erofs/features/erofs_ondemand: No such file or directory
> 
> [After]
> $ cat /sys/fs/erofs/features/erofs_ondemand
> supported
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Similar here, I guess you could pass in any `fsid` mount
option and check the return value instead.

Thanks,
Gao Xiang
