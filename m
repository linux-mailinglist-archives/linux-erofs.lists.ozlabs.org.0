Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 767474527E3
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 03:46:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HtVng33F5z2xh0
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 13:46:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X/bXi4gv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=X/bXi4gv; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HtVnc1GYqz2x9Z
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 13:46:44 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09EB76187F;
 Tue, 16 Nov 2021 02:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637030800;
 bh=JwtqBvtIdTtreln/fqbBKVJNpiqNLWTVDMUeJTaVJwI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X/bXi4gvLRZEPVOt+x/8ee7QlKcJVJM4NwBb80QNyzd/GQNNQF+QxXl5Cj6UdsY4N
 rwB5qo1LBVhaxCPxdCOHE6wJMTZZyah0A+BgdWUHFG7WN83Dz8/GvcTuIc6pN8XF7Z
 b55zVYoSXwJGLB3a8WBDkGGDtxjWaTXUdedDbWmkBFg0Fh96E+ZZfsHHBYi/4/mdJl
 DW9nejvvN0rNBGiT4SyRrOk7wzvL5Lziup1+6w4d+eDa5U1bAqedo+WXBwz0ejjz83
 EbVE2BosN8QDBEDkwoIkurNZWIUwABEwqjyw0QAEUZ9LOfgMocbKjOWa6L4Xeqmkn7
 yH/gXGT6TS9PQ==
Message-ID: <30b7b345-8632-ab2b-f201-f5159e52c785@kernel.org>
Date: Tue, 16 Nov 2021 10:46:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v6 1/3] erofs: rename lz4_0pading to zero_padding
Content-Language: en-US
To: Huang Jianan <jnhuang95@gmail.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20211112160935.19394-1-jnhuang95@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211112160935.19394-1-jnhuang95@gmail.com>
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
Cc: zhangshiming@oppo.co, yh@oppo.com, guoweichao@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/11/13 0:09, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Renaming lz4_0padding to zero_padding globally since LZMA and later
> algorithms also need that.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
