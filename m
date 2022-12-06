Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42D6447B3
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 16:12:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRP6F5GqKz3cFP
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 02:12:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dOw7DB1r;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dOw7DB1r;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRP2p4PcQz3flc
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 02:09:22 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B7574B80DF3;
	Tue,  6 Dec 2022 15:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1741CC433C1;
	Tue,  6 Dec 2022 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670339358;
	bh=+JcHD2fgJ20Y5Ga8vP9xc8ZWJSsLdzLTyYcLglXSHoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dOw7DB1rthod/ATG10j7eSN1i1cwE4kYqTn501nuEHEErFUTP/4wH/NNQZRONz+ov
	 q+f1d9dDjIzLec3ukh0piDqRovFVZLIvfwTfBI7G1/id5BOBqxlO631NACMvEr7VJm
	 Ewz744z33wjCJGRW+1Qe9WDQQw9S/CuPXYysYLZ5VXNHsGPM3CY53KIJw16neNGxna
	 b9jHqhRI08YNB3FukZeYU9u7TX8bfiG/J8z2VPzlaUf2W/QytC6icBlRsKWUooP6Nc
	 KtqBLU7iXbBGGnCGyfGdorFJJ8G9fU/xo8anxiGtetDbSoJY3JsaPfRx8vBPkeOynn
	 jxMj4adJb2cHA==
Message-ID: <3f0b9ff1-eea5-150c-c57e-4e1d0a06e220@kernel.org>
Date: Tue, 6 Dec 2022 23:09:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] erofs: validate the extent length for uncompressed
 pclusters
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
 <20221205150050.47784-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221205150050.47784-2-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/12/5 23:00, Gao Xiang wrote:
> syzkaller reported a KASAN use-after-free:
> https://syzkaller.appspot.com/bug?extid=2ae90e873e97f1faf6f2
> 
> The referenced fuzzed image actually has two issues:
>   - m_pa == 0 as a non-inlined pcluster;
>   - The logical length is longer than its physical length.
> 
> The first issue has already been addressed.  This patch addresses
> the second issue by checking the extent length validity.
> 
> Reported-by: syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
> Fixes: 02827e1796b3 ("staging: erofs: add erofs_map_blocks_iter")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
