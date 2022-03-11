Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AED4D5D2B
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 09:20:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFJlG1c73z2yxW
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 19:20:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JFmKLACp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JFmKLACp; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFJlC2CXtz2xXX
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 19:20:07 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CBEE0B82AE1;
 Fri, 11 Mar 2022 08:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA67C340E9;
 Fri, 11 Mar 2022 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646986803;
 bh=o8Xh2AdaEDIqnBziwekhg7TU+1OEG7Jo7u1pRDkEMNw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JFmKLACpUCKV2i2meReqkm53VUM6lMPjO8D+UCll4Juqmph77j71QLnEuhV6q29Vx
 cdNdzfunhxWamP2kpQRB/W6tSxYg0TGNofuIHxqsGjAg3lbB7DVMXyhW5tAUjiOrj3
 9/X7CwwUv2YJsGOdb05C9IlwNbnHPWUanmKDY8F+WySnZIvV4E7OPNxuDd3nYcn7J2
 Ex2yR1pcd5YNvG12eWXpOnS0HPSD+h3p98Dnf/YoQBK5PFy4WGcm+Fof1rnEMA9GvG
 pFIDzH7pxwn56AUeirmaFcA+NNAcAfjk2qvEnfH9FXmS648ERToH/XYVZ2asP3uzBT
 QSpxjdhb5M9qg==
Message-ID: <b00ca81a-82aa-3358-fd33-c0b1e8295207@kernel.org>
Date: Fri, 11 Mar 2022 16:20:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] erofs: clean up preload_compressed_pages()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
 <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/2 3:49, Gao Xiang wrote:
> Rename preload_compressed_pages() as z_erofs_bind_cache()
> since we're try to prepare for adapting folios.
> 
> Also, add a comment for the gfp setting. No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
