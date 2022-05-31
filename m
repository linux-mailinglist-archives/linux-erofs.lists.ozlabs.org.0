Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B610538B82
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 08:45:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LC2q665Vtz3bfr
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 16:45:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q2s0wXvb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q2s0wXvb;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LC2q001Swz2yyQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 16:45:47 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AC016B80FB5;
	Tue, 31 May 2022 06:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2347DC385A9;
	Tue, 31 May 2022 06:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653979542;
	bh=JWUY8gLxM6a8ecx+oeq5zIpOkvxaRWMyrTnL80aNhrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q2s0wXvb1We+8wZiL1fkROY36DyyMvj3B2eBxjLz6YmUXaSWPe7MVHp1jlGa3v0fZ
	 5jokGDyjHhNcEWsOf1F9QB1hGE7bgtq8GPa2cWne4UxloGPLUFIc1eWlcoAb/cefwl
	 julBU61N4wGG+hX+3qi4APZbkEmepBPP1zBfRaxAcBwEZSUpI6iA1CLY06P9ve8fDT
	 PvgW32xRed4cnsDVRrvJjKg15EcAh4KJXK9RfdRTF8zE6LH2pdHexVIuhVn8xh3l4I
	 +soMQYIrlMxJVWDbnJYfU+GOMLiCSTIOKaubwd2lPiholP+Akk6sSKn2d+J9YPIcHX
	 4ru1RWs21QaJQ==
Message-ID: <903a5a66-be1c-6371-708e-ac7f491b9585@kernel.org>
Date: Tue, 31 May 2022 14:45:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] erofs: random decompression cleanups
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20220529055425.226363-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220529055425.226363-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

On 2022/5/29 13:54, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Hi folks,
> 
> Now I'm working on cleanuping decompression code and doing some
> folio adaption for the next 5.20 cycle, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/folios
> 
> This cleanup work completely gets rid of PageError usage finally
> and tries to prepare for introducing rolling hashing for EROFS
> since EROFS supports compressing variable-sized data instead of
> fixed-sized clusters.
> 
> Therefore, EROFS can support rolling hash easily and our mechanism
> can make full use of filesystem interfaces (byte-addressed) naturally.
> 
> Before that, I'd like to submit some trivial cleanups in advance for
> the 5.19 cycle. All patches are without any logical change, so I can
> have a more recent codebase for the next rework cycle.
> 
> Thanks,
> Gao Xiang
> 
> Gao Xiang (3):
>    erofs: get rid of `struct z_erofs_collection'
>    erofs: get rid of label `restart_now'
>    erofs: simplify z_erofs_pcluster_readmore()
> 
>   fs/erofs/zdata.c | 165 +++++++++++++++++++----------------------------
>   fs/erofs/zdata.h |  50 +++++++-------
>   2 files changed, 88 insertions(+), 127 deletions(-)
> 
