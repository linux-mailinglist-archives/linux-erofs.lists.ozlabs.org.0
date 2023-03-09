Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0F66B26E7
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 15:30:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXWmx2R4Tz3cd2
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 01:30:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Te6hDaVl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Te6hDaVl;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXWms6nG4z2yRV
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 01:30:21 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2976061882;
	Thu,  9 Mar 2023 14:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E642EC433D2;
	Thu,  9 Mar 2023 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678372219;
	bh=29b1Xoc/WLcRlHoQ3CO6W52Ad1oWwKJf2jlU6m/7htc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Te6hDaVlj4PpLcOiT1SZdJNfAL/FFsGXbIVRs2h1YKFtfVEOEcvBkJM5GNmCEPtrU
	 yzKdNHaArrYrpf93lY7R3K8iti3C0QNjDPML3XfFVuvJe9HvdMrTTWaxHd1qOQM05R
	 R2vjz3KmY7kr5Ss7PvnGrM6ww1TiFoP/iCdNpXcm9pPj8BtohI690Zt4ta75zYL4is
	 P91Ps0pDjl0pB6G7XJP47vB7jiF109cSuGpACLGHiljN9ZHx73iucF72yyWQ9z3muQ
	 oB3fmb2r2xVeAqOdKcGeOt87q90SnSgJuWQjP7qTbwoO0atKZzzFBTFasmt984r8qR
	 XOuun0XoQhycw==
Message-ID: <69463ce0-2ee7-6676-017d-06f0edd47570@kernel.org>
Date: Thu, 9 Mar 2023 22:30:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] erofs: Revert "erofs: fix kvcalloc() misuse with
 __GFP_NOFAIL"
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
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



On 2023/3/9 13:31, Gao Xiang wrote:
> Let's revert commit 12724ba38992 ("erofs: fix kvcalloc() misuse with
> __GFP_NOFAIL") since kvmalloc() already supports __GFP_NOFAIL in commit
> a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc").  So
> the original fix was wrong.
> 
> Actually there was some issue as [1] discussed, so before that mm fix
> is landed, the warn could still happen but applying this commit first
> will cause less.
> 
> [1] https://lore.kernel.org/r/20230305053035.1911-1-hsiangkao@linux.alibaba.com
> Fixes: 12724ba38992 ("erofs: fix kvcalloc() misuse with __GFP_NOFAIL")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
