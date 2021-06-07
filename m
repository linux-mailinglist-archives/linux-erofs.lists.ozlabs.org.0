Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA0C39DE46
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Jun 2021 16:02:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FzFS04xh4z2yXT
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jun 2021 00:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YFkR9SRa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YFkR9SRa; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FzFRs0Wt6z2y0L
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jun 2021 00:02:16 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 353F06109F;
 Mon,  7 Jun 2021 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623074533;
 bh=KYCIX3pLUm0gdVK2rnWH38u1p5z/G1DqTnBuzw91XJE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=YFkR9SRasvWrfzUy9bmgDtrzo2DAYABeVhY8StSMDHPFXK9V7Sf3jYo/XZ7603cii
 CeAjDHRrJyciOPN/WBUitHr486qPo6ZkeG3afLXQh2t8Da6pvYlbLPidhyCpDUCJGA
 AGrltOiMXT+PIcV4PIK+PNn9l+WsL2rOVU2zj/HH4McMR36B/BvhGSe1E67X3pmhaB
 njKyUR6wUA8gCBpoKdThSwjmjmCsr/YL0L41JhxD0uF1mD+wcDU9rQ6kCLA0xQqXwv
 nwzcqUSbGGQhI7B0uGzLxCPA91SM4SzkXyr6haErB/6Xl/VTRuNyWB9rAsiMyYGFFQ
 qL9PYJby/abfg==
Subject: Re: [PATCH] erofs: clean up file headers & footers
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20210602160634.10757-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <b06f2b88-98ca-6714-4959-a1430254f2bd@kernel.org>
Date: Mon, 7 Jun 2021 22:02:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210602160634.10757-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/6/3 0:06, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
>   - Remove my outdated misleading email address;
> 
>   - Get rid of all unnecessary trailing newline by accident.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
