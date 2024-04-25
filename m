Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0E8B1C01
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 09:36:49 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R3qrtLlN;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ7333qCNz3dLR
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 17:36:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R3qrtLlN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ72y0Hm4z3bv8
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 17:36:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714030594; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dChTbnwW+CT2H9ZlwJIIUpsgWjZUS/kp07XhlH+/vOU=;
	b=R3qrtLlNBAHZZNN1RG4ZL6Q3FIwaKWkCijayik+6RZtp2ELr3CSygFOdRH8NSf0pXajmv6LimcrkIk4gmkL0zf/5sG7cFgB4N1RDG74G5rrDfbIybYvpWt+dqJjawAfY6rKeBcJogJ1UY/7ogkM26QQ+7sGtexO/Bop7f7uL2+g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5EfvwB_1714030591;
Received: from 30.97.48.180(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5EfvwB_1714030591)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 15:36:32 +0800
Message-ID: <9daf9ada-37a9-49a4-9377-80712c73621c@linux.alibaba.com>
Date: Thu, 25 Apr 2024 15:36:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: add missing block counting
To: Noboru Asai <asai@sijam.com>, linux-erofs@lists.ozlabs.org
References: <20240424055923.107209-1-asai@sijam.com>
 <288873a1-f594-4f5b-b3a1-881ad7ced1cf@linux.alibaba.com>
 <ZijhA4IJFSO7FYUy@debian>
 <CAFoAo-JvXBe39dLuWVPqb6OTwFMKJOfeqcZ=3QsYCusKsR4-tA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAFoAo-JvXBe39dLuWVPqb6OTwFMKJOfeqcZ=3QsYCusKsR4-tA@mail.gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/25 10:48, Noboru Asai wrote:
> Hi Gao,
> 
> Oh, sorry.
> I knew to access i_blkaddr on uncompressed file, but it didn't occur
> on the file system for testing, so I overlooked it.
>   I needed to be careful.

np, I've fixed it :)

Thanks,
Gao Xiang
