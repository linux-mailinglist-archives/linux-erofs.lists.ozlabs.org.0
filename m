Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC7536FE0
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 08:09:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9p5Y4lxdz3bkq
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 16:09:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ESh4Ev1C;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ESh4Ev1C;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9p5V6RHkz2yhD
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 16:09:02 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2C037B80A07;
	Sun, 29 May 2022 06:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D804AC3411C;
	Sun, 29 May 2022 06:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653804539;
	bh=fTq3TFugdQvN+NIEiTHx9BkL/wFe1xdYTWte7HgSp38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ESh4Ev1C1GiK5f9Il1q0APQInkXuh20NZc3BaAm2/TewaTvftmM0aOZ0Wy9U9Pfs+
	 UkNPue+mG4aJ650Sxxps+qOb2kiM+/AvOsjFwrjHv1YDOLew9+AAKw/g8kY4gl8NXW
	 f2hcuYinJD1AVR+wAJmZ7c4CaYaa/s8ZxsLUDtOnDIXl+7CdMpUBsCSzwO+Ko0Y2ET
	 OZL63DNCAWvc0p13deaVO/kz+Vh650Tc9xhE1Hb0bb0bXfMTmxrfFi09CKs2Mnu6Fp
	 hWwFaOhGm50rkktS7CCAm0lHmcwlaqF6sEyjofhFFgxMARG1Q59Cl75AoWiwmCR6iK
	 ExD+FN2LLts8g==
Message-ID: <bc642f61-c353-5d33-28a6-b5c0ad21335d@kernel.org>
Date: Sun, 29 May 2022 14:08:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: fix crash when enable tracepoint
 cachefiles_prep_read
Content-Language: en-US
To: Xin Yin <yinxin.x@bytedance.com>, hsiangkao@linux.alibaba.com,
 jefflexu@linux.alibaba.com
References: <20220527101800.22360-1-yinxin.x@bytedance.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220527101800.22360-1-yinxin.x@bytedance.com>
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

On 2022/5/27 18:18, Xin Yin wrote:
> RIP: 0010:trace_event_raw_event_cachefiles_prep_read+0x88/0xe0
> [cachefiles]
> Call Trace:
>    <TASK>
>    cachefiles_prepare_read+0x1d7/0x3a0 [cachefiles]
>    erofs_fscache_read_folios+0x188/0x220 [erofs]
>    erofs_fscache_meta_readpage+0x106/0x160 [erofs]
>    do_read_cache_folio+0x42a/0x590
>    ? bdi_register_va.part.14+0x1a7/0x210
>    ? super_setup_bdi_name+0x76/0xe0
>    erofs_bread+0x5b/0x170 [erofs]
>    erofs_fc_fill_super+0x12b/0xc50 [erofs]
> 
> This tracepoint uses rreq->inode, should set it when allocating.
> 
> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache
> readpage/readahead")

Should not wrap long 'fixes' line.

> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
