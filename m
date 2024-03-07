Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350E87456E
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 02:05:08 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZiH6G+ET;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tqrgj5jbkz3bw2
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 12:05:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZiH6G+ET;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tqrgf3g1Lz3bmy
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 12:05:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 03C75CE1CB0;
	Thu,  7 Mar 2024 01:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B37C433F1;
	Thu,  7 Mar 2024 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709773497;
	bh=KRNYnI2A/lUFgun5k7wE4UrYIdybMwijj6R/qDSCeZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZiH6G+ETOyZM0VO7hul+UjqZ0cYMlFKz+QsJhq3ppKDKymEUXtDnBLms4P7OCsC2M
	 5sUs/ok9+Ksl4YgYSKgO7CEjCVpchJJXXYE9rSym7HaIJplf6NDjspxxs3rIR+X4io
	 c7SOh5NfSnUypMyoRfXH2Rmi284It9KRuhEr8Yg2Djrbk5wa3JW21Y2pLjsU7Gdfwx
	 ISIJC9idx9S2Q5cEKgCvC6+qv5ge8F0byi1sTF9479I6p5rql+vXlT0pUWZ5LFN3oU
	 uchyWcXWEidmNjniEptrGgPjucWdG6FhYpWjaQss5S34drn9FYgBtjQJYDW8cGIr91
	 /SOUdWPc7iBew==
Message-ID: <b0c76d40-7cd0-46da-b4fb-1ee3f9fdd0e1@kernel.org>
Date: Thu, 7 Mar 2024 09:04:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
 <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
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
Cc: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/3/4 11:53, Gao Xiang wrote:
> syzbot reports a KMSAN reproducer [1] which generates a crafted
> filesystem image and causes IMA to read uninitialized page cache.
> 
> Later, (rq->outputsize > rq->inputsize) will be formally supported
> after either large uncompressed pclusters (> block size) or big
> lclusters are landed.  However, currently there is no way to generate
> such filesystems by using mkfs.erofs.
> 
> Thus, let's mark this condition as unsupported for now.
> 
> [1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com
> 
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
> Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
