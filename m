Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B328B019F
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 08:16:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uY55mIFb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPTJb1GZCz3cG6
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 16:16:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uY55mIFb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPTJS25Mtz3bnL
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 16:16:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713939360; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4sGMa6zXzPrhfMbSvctTkOUNb0R+2PMjXu6xS/j2cWM=;
	b=uY55mIFb4NphCd/Aeii8ZrESh9FPY4OAfpIniMlnr1RukwLQ1J0HRYBIEGo8FgOMMHSRLm3JVbXB3VuxduLfpv+yIKq3BpMGmBupEuzv/59u7/1n94ynPGr0cKK/2ZxhQZxdLj6hDH7TpwIAwFSVgV5ArYp1LkC2xDW+axjrrjE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5BMx.w_1713939358;
Received: from 30.97.48.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5BMx.w_1713939358)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 14:16:00 +0800
Message-ID: <288873a1-f594-4f5b-b3a1-881ad7ced1cf@linux.alibaba.com>
Date: Wed, 24 Apr 2024 14:15:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: add missing block counting
To: Noboru Asai <asai@sijam.com>
References: <20240424055923.107209-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240424055923.107209-1-asai@sijam.com>
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



On 2024/4/24 13:59, Noboru Asai wrote:
> Add missing block counting when the data to be inlined is not inlined.
> 
> ---
> v2:
> - move from erofs_write_tail_end() to erofs_prepare_tail_block()
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
