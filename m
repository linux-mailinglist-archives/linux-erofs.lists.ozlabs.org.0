Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDBF6964D6
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Feb 2023 14:39:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGMlJ1xr2z3cJK
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Feb 2023 00:39:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z8mz4a0D;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z8mz4a0D;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGMlC0nGkz3bhZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Feb 2023 00:39:51 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2B0BFB81D46;
	Tue, 14 Feb 2023 13:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235BAC433D2;
	Tue, 14 Feb 2023 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676381985;
	bh=eK4vLSQoNPg7dk64n3Hmsxeg/eQPehh7IZrwJlPMJ/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z8mz4a0DyOP5T35ZNjJ6zdlb6+EHb/79Kuxw/vDEwOBRpWeCD2Jt6v+lEUIVdtliD
	 RPwNqAt4mFszdergB+WMU6mtlF/l8griz8LMunu3OCkr0PYuPkgnkJSOeqVH1H3Uuv
	 VhaGEM4tv+7fmc4e0B8kDvAr2erTJ+/WXLm3KvVTHxrXYUBDeNN7RkhYuHtpZ16+Jy
	 v6CFX8yA1B+xMJj1Wnr8nvr6xJtYCTjqNuLI8Hj+tKnptqYFRiSYXCORlHm/9kOwDk
	 /wm6GEtZtHhrdA+6p8O9Fzpm5STkDBWyd6TrdUjJuCbSclQE8DU//0PC2vLcaGyhxF
	 zeXF093F8P56Q==
Message-ID: <14957c9d-ed66-de02-f845-295314d01481@kernel.org>
Date: Tue, 14 Feb 2023 21:39:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] erofs: remove linux/buffer_head.h dependency
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
 <20230114015812.96836-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230114015812.96836-2-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/1/14 9:58, Gao Xiang wrote:
> EROFS actually never uses buffer heads, therefore just get rid of
> BH_xxx definitions and linux/buffer_head.h inclusive.
> 
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
