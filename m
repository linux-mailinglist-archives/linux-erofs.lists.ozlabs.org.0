Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF852A577
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 16:57:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2fN96rW5z3bwX
	for <lists+linux-erofs@lfdr.de>; Wed, 18 May 2022 00:56:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qGBxyzRK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qGBxyzRK; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2fN64FBlz30Dp
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 May 2022 00:56:54 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5C1BFB81852;
 Tue, 17 May 2022 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA40EC385B8;
 Tue, 17 May 2022 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652799409;
 bh=9G4bRLZbkmaoTeyxyDS0FY/VhwuNvTEg2IWb6RR7uDs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qGBxyzRKO/VviBndF4dA0oxNkyStZ0yhkdRZvuYHuIqsomujGyf3QiKOPZPYJ6Ei2
 G3NTdNxBWb5NRgZkG84x31DrNH8qg82lPljsdLPtknwV/fyp2rD11hmrbTeOGRp2BJ
 SfR0Fbdq0MpiC/+r9AICVWlig49y8Tsr8BBmh5WM2a0C0oD9+2dxEy3OvKdII/0PBL
 Tsjv0lEu3YT4PCqfY1+JxxOz8QqYNZHzMxE27iQRGJfkzpJSSIHjf7Y2fTY7ZP8XAl
 RH2zp/4r93qMfayhYirj/XN2I1AcJMfuIYsyKruvzlWS3BQev+RJ7D4ftvZCJODnyU
 QW77kam9yUszQ==
Message-ID: <2cf13dcd-7fa3-4216-a67e-0a4ea66ecf95@kernel.org>
Date: Tue, 17 May 2022 22:56:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] erofs: remove obsoluted comments
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
 <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
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

On 2022/5/7 3:46, Gao Xiang wrote:
> Some comments haven't been useful anymore since the code updated.
> Let's drop them instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
