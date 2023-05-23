Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE83670D3ED
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 08:25:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQPSr5l1nz3cNJ
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 16:25:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gw3Wxa7W;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gw3Wxa7W;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQPSl3tlZz3bgr
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 16:25:27 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0681562F55;
	Tue, 23 May 2023 06:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272FFC433D2;
	Tue, 23 May 2023 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684823123;
	bh=hAj2m2Dt0UOHATVzNL8YUz4SIC5ygDHcCMyKr8UTkcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gw3Wxa7WUB/ZQ8B/NhvDOOj0ETRn8v1trv1+nWoDMJ81Ij0VZceFA9QlpyyJGOmFH
	 zf/vLWvdYtU/MOlHV/YRpTRva7PR+eGNaFBYqHY61BbP0mmH9hKXG7XQKQNDBv7jNt
	 pWdMp4XJYiBK3od94vZlzvi+sf/5p8zFOPRLkJfqnT22RcbGNdPsS3ZubDcvf3RbUT
	 JxXrLMDhdybPJ+WhhZV3OAdtr593EevEBTZzA9UgOHFghRHpD1aLBITlOrB3q9hpxN
	 0VijNurvR//HQHiHUtlL2vU7X4lGm/9ruVFA4rQt69rnNJYhpa15CQRL70j4yBGBHk
	 SA0eAyhAQrhig==
Message-ID: <161736a2-1a79-b30a-002c-61ef9c237a22@kernel.org>
Date: Tue, 23 May 2023 14:25:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] erofs: fix null-ptr-deref caused by
 erofs_xattr_prefixes_init
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230515103941.129784-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230515103941.129784-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/5/15 18:39, Jingbo Xu wrote:
> Fragments and dedupe share one feature bit, and thus packed inode may not
> exist when fragment feature bit (dedupe feature bit exactly) is set, e.g.
> when deduplication feature is in use while fragments feature is not.  In
> this case, sbi->packed_inode could be NULL while fragments feature bit
> is set.
> 
> Fix this by accessing packed inode only when it exists.
> 
> Reported-by: syzbot+902d5a9373ae8f748a94@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=902d5a9373ae8f748a94
> Fixes: 9e382914617c ("erofs: add helpers to load long xattr name prefixes")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
