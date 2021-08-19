Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA2C3F11C5
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 05:32:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gqr1k4f1lz3bXP
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 13:32:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F2XWpu8Y;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=F2XWpu8Y; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gqr1b5s2gz2yX6
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Aug 2021 13:32:35 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24F5A6044F;
 Thu, 19 Aug 2021 03:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629343952;
 bh=J7zcvWJK4OZy21e19EhcGy6y2c9vUU1+2tNmbKsF1BA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=F2XWpu8YCwp5nqppcPKjiZOzdqvQDP1osizNCVr07bdVh1blCdJfEvkOUfeOzGdwu
 WlWUhM2fgs1QjhRWI8ZyhJiNBqsb/KT1UBzv9IXsQcEqaT921SbdDEU98+u2LHp0OG
 alPf1x2pYsh82yweh6DrhLV45g8Rn673KEhazh6101pY343f/ZQt6zM+E9cLT4k3fe
 znAARZpkuU+ToyhFGbH2I6HihM86KXRn+bOivYFEPh30qZsOSuAevC2ffvG2N+EYWy
 STVMENPyVOLTLGBKtPYsCD4IDnlaq/w9x+xDsDtFl61kMymuBzJ4IYRPk9WD5NOJa8
 UX1NIE7F5lejQ==
Subject: Re: [PATCH 1/2] erofs: introduce chunk-based file on-disk format
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Liu Bo <bo.liu@linux.alibaba.com>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <8e7291cf-8baf-2a79-997e-4847faa109db@kernel.org>
Date: Thu, 19 Aug 2021 11:32:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
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
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Eryu Guan <eguan@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>, Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/8/18 15:07, Gao Xiang wrote:
> Currently, uncompressed data except for tail-packing inline is
> consecutive on disk.
> 
> In order to support chunk-based data deduplication, add a new
> corresponding inode data layout.
> 
> In the future, the data source of chunks can be either (un)compressed.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
