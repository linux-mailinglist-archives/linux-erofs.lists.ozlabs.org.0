Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D56E3988
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:53:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PztVP1sHrz3cMb
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:53:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sZ26q8S6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sZ26q8S6;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PztVL0SRdz3c73
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:53:45 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD7B6100B;
	Sun, 16 Apr 2023 14:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2027FC433D2;
	Sun, 16 Apr 2023 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681656823;
	bh=acLuCsGU+sHF10zE6PC+R+hrzrIz9BwAzVKxN2i6iwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sZ26q8S6dVszAjfA1VKZ8rgKZwmbfp8kvmviUbP24wcVhuGpqQEbK3rWabGaMKQcB
	 rwTX7ZdoHse1QJ8qTh+I4Dh+b1KZBf63p5PzY3E2y9bjJ/f7TPpFrOQWekrrL2MH7/
	 fWzYzF3/KRJX5QNA4pOtitO0B1Gr99dq/woQ48thRxLSRjK5ejXuXNVBziK6SGdzSY
	 JEKuAjVieFECTdnVZc86vm1BndFNojkRprbNcE+x+4VLHHB4AIdvvbRdFG9o+pU6dx
	 z7nme3mVJVRH1fPlAhOKVKAPg+k62oDrco8DG7FEg4QLXP8xh0ONNxdTChTuUiFcYe
	 WInCFIZVN6rnQ==
Message-ID: <11b3a324-9378-da72-a4eb-00f0b814b25f@kernel.org>
Date: Sun, 16 Apr 2023 22:53:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] erofs: cleanup i_format-related stuffs
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
 <20230414083027.12307-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230414083027.12307-2-hsiangkao@linux.alibaba.com>
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

On 2023/4/14 16:30, Gao Xiang wrote:
> Switch EROFS_I_{VERSION,DATALAYOUT}_BITS into
> EROFS_I_{VERSION,DATALAYOUT}_MASK.
> 
> Also avoid erofs_bitrange() since its functionality is simple enough.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
