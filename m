Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E644BA8A
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 04:09:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpqZs4k7Zz2yPm
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 14:09:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XVRCyC2K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XVRCyC2K; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpqZn4Qyfz2xtW
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 14:09:37 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E529661105;
 Wed, 10 Nov 2021 03:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636513774;
 bh=uQVPZ0mWoc5SLX+cZOARzJKpAXaOWwVcwHcs3Im4nVI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XVRCyC2KwiDdBSbErsEpShEmHaTUvDMcfn2RmpouA3oWyvFVkQ83EUFS0Wikz4xZg
 toQx6TezG4m7cl/a1hOi9XeTxIqJ7bdIm31Qq2tz/r+YmhhK2ch9jMeSdTcHpwcFDd
 WXYMRxPCQwo/6/bS9fs7oc/bTGjxAGS4BEi1pgU9i9M1NiqPR1FX4dPueFfxcDIrPS
 EHboCBIebZLRzBQoH/1qj77ni2ZLjB53AqFfLEt5u1Oy+xVEzYLLKJgzDifHQXsZaM
 9fzpkyYOz+eQp2HLJr6Xw6aprtZnv+rJ4kL1kBBk4aKSoM9ZZXTbUln1aM3ZPXIVti
 NbKVcg78JFNUA==
Message-ID: <7b82718a-2a12-67f4-42f9-523777c74573@kernel.org>
Date: Wed, 10 Nov 2021 11:09:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 1/2] erofs: add sysfs interface
Content-Language: en-US
To: Huang Jianan <jnhuang95@gmail.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <fa2eeb31-9579-a4a4-71b3-200509da1ed9@kernel.org>
 <20211109153856.12956-1-huangjianan@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211109153856.12956-1-huangjianan@oppo.com>
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/11/9 23:38, Huang Jianan wrote:
> 
> Add sysfs interface to configure erofs related parameters later.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
