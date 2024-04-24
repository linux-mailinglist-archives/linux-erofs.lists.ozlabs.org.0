Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB38B013A
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 07:43:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vE1ykwuQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPSb75BD2z3cDk
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 15:43:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vE1ykwuQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPSb22ySzz2xPZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 15:43:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713937416; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=clW0U32Kpmr1JtwBiyML9M962IwMYb7rwdjrfQPyliI=;
	b=vE1ykwuQFZdNS8rn+iiJn0PkXWNBaVLzg+Q3ZikHaQJRu1X+BfWFarbbgyrTs6uwE92g1C/NMDXe+D8c634U24D408CokttXdkbvyztBHtuguqvVHXXYSahvBUWn/FpjCHPnBGVdIoBDFGMsVwnD9Ab3xPQKEpYJ10NwSNaiEu4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5BFg3G_1713937413;
Received: from 30.97.48.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5BFg3G_1713937413)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 13:43:34 +0800
Message-ID: <034baa80-5510-4d60-a576-f50ee21659c6@linux.alibaba.com>
Date: Wed, 24 Apr 2024 13:43:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: add missing block counting
To: Noboru Asai <asai@sijam.com>
References: <20240424043413.90179-1-asai@sijam.com>
 <39f07091-6919-4fa6-86b8-cb04f3135fe6@linux.alibaba.com>
 <CAFoAo-KTL+HqCQ2oDULorykd=Kv_yzixX4-9EAupPBbX92Wk9Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAFoAo-KTL+HqCQ2oDULorykd=Kv_yzixX4-9EAupPBbX92Wk9Q@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/24 13:33, Noboru Asai wrote:
> Hi Gao,
> 
> I think that erofs_balloc() and erofs_bh_baloon() function in
> erofs_write_tail_end()
> also alloc a tail block, Is it not true?

erofs_prepare_tail_block() is the place to decide the fallback
tail block. But due to some dependency, bh can be allocated in
erofs_write_tail_end() later.

erofs_write_tail_end() is designed for filling tail data, not
decide to get a fallback tail block, anyway.

commit 21d84349e79a ("erofs-utils: rearrange on-disk metadata")
changed the timing due to some dependency as I said before, but
later I need to revisit it.  erofs_prepare_tail_block() is the
original place to decide if a fallback tail block is needed,
that is also true for old versions.

Thanks,
Gao Xiang
