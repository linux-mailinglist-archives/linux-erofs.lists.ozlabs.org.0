Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBE6445B3
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 15:32:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRNCf3NF3z3bY2
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 01:31:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WG6eEwKa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WG6eEwKa;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRNCb318Sz2xJF
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 01:31:55 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B7515B815A6;
	Tue,  6 Dec 2022 14:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D22DC433D6;
	Tue,  6 Dec 2022 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670337111;
	bh=JeoFrNywnaQIRQPztyv4k9bjuMDfct61Uzw4cnGKLCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WG6eEwKaV7dWcpLCHsNZjtGR2LkZiZZFadt2VSMp+3SuEazEY8wSoda0Fmim8S0tc
	 O2iqTtqC1g2PbdGakqdkIfulajicHAlJa7keuVRhCFxKE0NvUkT4hut88upm352COm
	 pZNNbGaMr2oQkngkU9thZeXG2PfjNVDG/ylsnjXP+CRxW99k2Vif60wPSKXwcJ8/3s
	 QfsRe3VvkEjdTwJjqDgfmpAjm8PNeZ8n8ut3dq72H/c1X3ATH2qErvT/H1R4Nn9MDl
	 Y9ITfbFcOeteffmK0aIBziJNNk8OtSqYYGa5Odkw1efRfIm5Jixoi3x8zbiPh9OGNU
	 vU6L40m8GMfDg==
Message-ID: <0fe48416-fbc6-17de-0dcf-5c506315b23a@kernel.org>
Date: Tue, 6 Dec 2022 22:31:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] erofs: clean up cached I/O strategies
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20221206060352.152830-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221206060352.152830-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/12/6 14:03, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> After commit 4c7e42552b3a ("erofs: remove useless cache strategy of
> DELAYEDALLOC"), only one cached I/O allocation strategy is supported:
> 
>    When cached I/O is preferred, page allocation is applied without
>    direct reclaim.  If allocation fails, fall back to inplace I/O.
> 
> Let's get rid of z_erofs_cache_alloctype.  No logical changes.
> 
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
