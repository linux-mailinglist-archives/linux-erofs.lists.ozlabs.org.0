Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C76951466
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 08:20:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YJD0OXDs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkJ5F635Jz2yPd
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 16:20:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YJD0OXDs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkJ592G4nz2xDl
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2024 16:19:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723616390; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P6vIigbI/vVUs/AEu10eOdCzQ/IjsyrOyuTXpmi+/vY=;
	b=YJD0OXDsRuJJWGAhSR3Vm5eKPbD79K5U798qwyx6mes9+/WNK0sGIUiNsa4VF3rLAngTaBePLQyT7WXYGolYxgoDy25EFb6jlok+ZurQZxXJd5OsH/T8GcoBVsqZbczyGbr/7g7jZ3ILO662mb7TgsF++SZcees760NByfrjPlA=
Received: from 30.221.130.115(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCrAf0i_1723616388)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 14:19:49 +0800
Message-ID: <66c0f608-9d0c-4b68-9d48-7b0cf1609e0f@linux.alibaba.com>
Date: Wed, 14 Aug 2024 14:19:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: free pcluster right after decompression if cache
 decompression is disabled
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240813102835.640534-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240813102835.640534-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/13 18:28, Chunhai Guo wrote:
> When the erofs cache decompression is disabled
> (EROFS_ZIP_CACHE_DISABLED), all pages in pcluster are freed right after
> decompression. There is no need to cache the pcluster as well and it can
> be freed.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

I tend to not implement so much specific code just
for EROFS_ZIP_CACHE_DISABLED, so it you make it common for other
use cases too I think it's more reasonable.

Thanks,
Gao Xiang
