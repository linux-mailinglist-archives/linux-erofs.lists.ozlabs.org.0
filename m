Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3310243F748
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 08:35:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgXk16XpJz2yNG
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 17:35:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QwfsIJwd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QwfsIJwd; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgXjw5QVbz2y7M
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 17:35:32 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACD37610D2;
 Fri, 29 Oct 2021 06:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635489329;
 bh=6L9d1Ezd7kwg1IfsoMHgf5b33hOvvWq/PQqAlZkeHGQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QwfsIJwdYqVryW06h3c2Cl2KR/HVsN9j2EldZP6281F0uToZh5uk6lc+bcpKBdg4q
 W21CAt06HgStIj1Xm/xdTNy5lmVF3rcFKL6QtezOKJT8uSLWrt6ccTjeP+uf0+zf2D
 TpMLWOVsDeJiJya8ecwnITd7ZksWTXZvY4jgY4f96+VYNxejUKMu/GkS272g1hfSP8
 yfKquY1PkIrOkVyfzv7BkNWvDZSOLqV0hXfHz2UqUWKzSr4KAQF0JqGALs5ybUimpi
 PROFyblGoPfChL6TWRp9O+uhs4TGTGMv8qC9J3iqx65LnMtqZB3cICYQDelyr/aB5G
 9Z5vB7q0l2LAQ==
Message-ID: <b169d1ba-54c9-7195-6190-9d10ffb44530@kernel.org>
Date: Fri, 29 Oct 2021 14:35:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] erofs: don't trigger WARN() when decompression fails
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20211025074311.130395-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211025074311.130395-1-hsiangkao@linux.alibaba.com>
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
Cc: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com,
 LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/10/25 15:43, Gao Xiang wrote:
> syzbot reported a WARNING [1] due to corrupted compressed data.
> 
> As Dmitry said, "If this is not a kernel bug, then the code should
> not use WARN. WARN if for kernel bugs and is recognized as such by
> all testing systems and humans."
> 
> [1] https://lore.kernel.org/r/000000000000b3586105cf0ff45e@google.com
> Reported-by: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
