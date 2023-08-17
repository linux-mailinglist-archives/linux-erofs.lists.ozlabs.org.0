Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7E677F305
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 11:15:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRK9h4TrYz3bc0
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 19:15:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRK9c6Fsjz2yV5
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 19:15:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VpzJcqa_1692263739;
Received: from 30.221.132.1(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VpzJcqa_1692263739)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 17:15:40 +0800
Message-ID: <daa330d8-867d-d98b-29c3-e0cb208ff6fb@linux.alibaba.com>
Date: Thu, 17 Aug 2023 17:15:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] fs/erofs: avoid noisy messages
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Huang Jianan <jnhuang95@gmail.com>
References: <20230817070138.44258-1-heinrich.schuchardt@canonical.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230817070138.44258-1-heinrich.schuchardt@canonical.com>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Heinrich,

On 2023/8/17 15:01, Heinrich Schuchardt wrote:
> The erofs file system creates noisy messages when it is not used:
> 
>      => host bind 0 disk.img
>      => part list host 0
>      cannot find valid erofs superblock
>      cannot find valid erofs superblock
> 
>      Partition Map for HOST device 0  --   Partition Type: EFI
> 
> If there is not erofs file system, this only deserves a debug message.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

There was already a patch to address that:
https://lore.kernel.org/u-boot/20230813142708.361456-13-sjg@chromium.org/

Anyway, I'm fine with either patch.  For this patch,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
