Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BC902EE6
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 05:10:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ufCxbMNi;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VytwH1fLzz3c9r
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 13:10:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ufCxbMNi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VytwB43WRz2ysf
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jun 2024 13:10:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718075427; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ynaU+pJELs9AX7Up504OKhYtFWTcuFHch9Gr+ARcixg=;
	b=ufCxbMNinbcEW381+G3isGbECKPD69plSObJXRW48Bpt/3S1K5W5pQbXoOq09c3jyvEChz+rlydm/Vjal2f9lrMHVjLYgmsCS7urfArFi6sX5QwMa0yRdDuhYfBYP1x04xUU0kFs+QTQfKNv9cvT570wuOFb3Ef5IjNN6gqf3NM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W8ErjDc_1718075425;
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8ErjDc_1718075425)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 11:10:26 +0800
Message-ID: <97816659-1e55-4f5e-9bfd-8927ddea0926@linux.alibaba.com>
Date: Tue, 11 Jun 2024 11:10:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can mkfs.erofs keep specified files uncompressed?
To: Keiichi Watanabe <keiichiw@chromium.org>, linux-erofs@lists.ozlabs.org
References: <CAD90Vcbzx_Qz_V3CLJXHkvEfRX=E3Rkf-nHoTc=NDQPZDesJQw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAD90Vcbzx_Qz_V3CLJXHkvEfRX=E3Rkf-nHoTc=NDQPZDesJQw@mail.gmail.com>
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
Cc: sarthakkukreti@google.com, Junichi Uekawa <uekawa@chromium.org>, Jae Hoon Kim <kimjae@chromium.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Keiichi,

On 2024/6/11 10:58, Keiichi Watanabe wrote:
> Hi,
> 
> Is it possible to exclude specific files from compression when running
> mkfs.erofs?
> I found The --compress-hints option allows me to specify different
> algorithms for files thanks to [1]. It would be great if I could
> specify "uncompress" in the hint file.

I think it's already supported by specifying pclusterblks as 0
to leave these files uncompressed like:
0 0 .*

You could try if it works for your use cases..

Thanks,
Gao Xiang

> 
> [1]: https://github.com/erofs/erofs-utils/commit/dac31f7eb228601c457c6338e6df8dabfcbb039b
> 
> Best regards,
> Keiichi
