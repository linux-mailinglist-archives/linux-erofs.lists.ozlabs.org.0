Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1689F662340
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 11:35:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nr9M26NNDz3c4Y
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 21:35:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t4U47ptg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t4U47ptg;
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nr9Ly2zr9z2ypJ
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Jan 2023 21:35:22 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id DE1EDCE0F1F;
	Mon,  9 Jan 2023 10:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1FFC433D2;
	Mon,  9 Jan 2023 10:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673260516;
	bh=YmOTwEg410xLry6JPtWUVue+KxFnjS0fs4qiJfMqPn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t4U47ptgIoaLdfE+zHI0kATbQY0S6DflXlbgdgW/lTXMo1nFa4mJ1oXvx1jpZ2K1Z
	 TxATEvh2KtoECvYtsn1WfOhPkYqo5FxMxlOHPpUL+s3ZDmYaGceBENP+BNtP1Jdx6X
	 i5EPcLOZOF3WNHgkJnVunnwkL3TDLK1N7W4TJw9e5vOC697Mi1Js+EQUYKJqZDdt3K
	 m9zodUU9vaB4Q0EaPo4QpbVXTyGA5HJMe/jNfH2k7okhju6/X75p3OiL2zNx/r1375
	 rrXqR/wFqWlL2hfwOwiWZy+1qcsK2iAF5dd38dHw9/7j3zLPtKE08urje/hdxh6t1s
	 faa5jrMbpguiQ==
Message-ID: <ee7bb35d-aa28-48b0-9877-c6d0881dbe64@kernel.org>
Date: Mon, 9 Jan 2023 18:35:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] erofs/zmap.c: Fix incorrect offset calculation
Content-Language: en-US
To: Siddh Raman Pant <code@siddh.me>, Gao Xiang
 <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20221209102151.311049-1-code@siddh.me>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221209102151.311049-1-code@siddh.me>
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
Cc: linux-erofs <linux-erofs@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/12/9 18:21, Siddh Raman Pant wrote:
> Effective offset to add to length was being incorrectly calculated,
> which resulted in iomap->length being set to 0, triggering a WARN_ON
> in iomap_iter_done().
> 
> Fix that, and describe it in comments.
> 
> This was reported as a crash by syzbot under an issue about a warning
> encountered in iomap_iter_done(), but unrelated to erofs.
> 
> C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1037a6b2880000
> Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2021a61197ebe02
> Dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
> 
> Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
