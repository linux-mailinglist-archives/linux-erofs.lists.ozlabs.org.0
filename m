Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CED620745
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 04:07:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N5tLn0mq0z3cJ3
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 14:07:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nevb3Dsr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nevb3Dsr;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N5tLd5RNWz3bj0
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Nov 2022 14:07:21 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1F286B81627;
	Tue,  8 Nov 2022 03:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACBFC433D6;
	Tue,  8 Nov 2022 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667876836;
	bh=DoQVAWYIhuU/Va/KNg+xTTJC6B/0NXt4BCWT4F1PWQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nevb3DsrjqI1uRxHQEEw17z3+eEIgaQdTKi2pABtgHcvlVCEeyWefP3+0J3oOLPN1
	 Npe7sSODV2lY2mHJXsJar6JkfJA1WY5cyRHamIcC1J3aR1coyMSw7b7CFN8QLpSKO6
	 roVirnZahJ5hNU2pSMFmLXTVHm8OPFnWIp0yrNPnULYnHpRQXIsCgBqMRUU/PVqmma
	 bnyvuXzaqs0mwEE4RWnbhjq0wydlZztLp29scm/A4bZTSeruaMnHCZpPtQkdy646oO
	 NoZy686v2EMUgJ0epGH4fAJGLEY2fOeXnofiK3AFo/BMpvty1DFZRAbfflSL2DjqU8
	 APwFKsRqG2CNQ==
Message-ID: <9ce701ec-257a-b923-903f-2931bfb8c3ae@kernel.org>
Date: Tue, 8 Nov 2022 11:07:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] erofs: put metabuf in error path in fscache mode
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-2-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221104054028.52208-2-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/11/4 13:40, Jingbo Xu wrote:
> For tail packing layout, put metabuf when error is encountered.
> 
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
