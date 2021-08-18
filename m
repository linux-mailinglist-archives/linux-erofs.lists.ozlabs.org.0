Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67013F05DF
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 16:11:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqVFT3xJsz3bhb
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 00:11:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TbR8t2Px;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TbR8t2Px; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqVFR05fTz2xnd
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Aug 2021 00:11:38 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7EFC610A7;
 Wed, 18 Aug 2021 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629295896;
 bh=Gz6CCkSmBpJBb//SixnJg3yiMy1j4X3NG4qAXGzi90I=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=TbR8t2PxXP85BxY8iJ+zv5suFPI9j1kMGjLSwWK9VduVeQFuRlKImvkjsPw08I2Nc
 Yfwo/E+C8mIZFpLimYl7JWnNbJIKPj3UYGQcN4zK5+j6TpobFdyG50rzAqJ3F8kvOh
 Vg0ZUSkB2qJchlBANicVCPgJo+cZQODlryiAxmDwK2821L9era9oxHjI+3jdSBye+z
 g8NeXkTMfgfy/bWuQqxBP1ulrBHvhKEZIegyCQBP7dHEb4gLVKRR+OrTjiVcajhJlC
 bM80Z0PUcRBMjZVx1yzH7BmffNGMgbA99rx4/we9EnGgqrOyWHoZZqxt54Dr72eCCS
 81c1dPppV5HyA==
Subject: Re: [PATCH v1.1 1/2] erofs: add support for the full decompressed
 length
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20210813052931.203280-2-hsiangkao@linux.alibaba.com>
 <20210814152727.78451-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <e3144a66-c5e6-6f2b-88a9-74730972abff@kernel.org>
Date: Wed, 18 Aug 2021 22:11:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210814152727.78451-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: nl6720 <nl6720@gmail.com>, Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/8/14 23:27, Gao Xiang wrote:
> Previously, there is no need to get the full decompressed length since
> EROFS supports partial decompression. However for some other cases
> such as fiemap, the full decompressed length is necessary for iomap to
> make it work properly.
> 
> This patch adds a way to get the full decompressed length. Note that
> it takes more metadata overhead and it'd be avoided if possible in the
> performance sensitive scenario.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
