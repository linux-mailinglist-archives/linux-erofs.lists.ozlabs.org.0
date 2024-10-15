Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF899DCFF
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 05:47:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSKmr5Js3z3cGb
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 14:47:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728964058;
	cv=none; b=iga1wnoBzEYpZFd3zaff/sQjlogtV6G2MEB5ZKqh8JNXkIAC5AAbHqdM67cHclr0UylhHcjL1vu7tq5Gql3aPE0ZsuSXSL6Riq1hExbsIRMlRmuNlj24uX7fpf00zh9MLHW6GGBcmCsZXj/WOh4F9FnW7ntpWQuNa1syzm2tkY/eiPWpvKPxDv8xIesZToylHrEXkZMi+RCEsodXiUZ9ngIZQ2utsE4Yi56jgfx6arOsHHYK4Lzt43ddo8VwTkIQ8vfVTDFZiZXdYooBk0qIQMEUmOGn8jpTI+XZ7pHD/2TWNY8kwbBwXxR/gqTy0Pn9m0MITu1AHmFwRuOlYcs0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728964058; c=relaxed/relaxed;
	bh=CwxB1Vthx8aMmA8+rN/HOXJXgXbO9JZ2ug4RUwzvkh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHfARfqrOdyuCTa/JSqKwmz3Rh4+ajV/a91AyIORkEI9EXpxWK8YAqkPQeZt6ZIDwn/uHiXFNwyHgCk2ihfgP4oWEYWLcY6+F833BEt4o299Efjt6UyHt5zJI77nnnwNup44MBAn8bxMdnxhL0OP3FhloRbO3nyKR/UWMzvNYd/cey2BF36sb9uyzKwNEH3vuG0Xk8J7AnE2tZxoGeb4VtcPaz8sZb5dVlqitYqcvwlMxcJ0V05lG4LQ2Z/lCE5ZZzRmF+Q/kw8WyWCwBNBxcxRAFrT6tT7R5J7B/3FcvMZiSv8VGtM3aiSvA4OqC59jczuw5S1j+tZqiBzjoCNVBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NlP2IHtH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NlP2IHtH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSKmk65flz2yNR
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 14:47:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728964047; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CwxB1Vthx8aMmA8+rN/HOXJXgXbO9JZ2ug4RUwzvkh4=;
	b=NlP2IHtHLckrbf/so0ZTRDmpH3pXsn4CVz6xdAEXyY7g2TiLL23EHRkECUi6g8W0u1oBHsDqpDkZW2j+gbTheUtzxmerCLosdQ+Va73fa4KW6boC1gMES/GFUQ9B18zTSdCzPLZdE3HVWZc4GP6UI4nVuOxPBY04c7RHqNTM7DI=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHBmJiK_1728964045 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 11:47:26 +0800
Message-ID: <231e17e3-82c1-49f4-9cc1-b376b89205b3@linux.alibaba.com>
Date: Tue, 15 Oct 2024 11:47:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unsupported blksize in fileio mode
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241015033601.3206952-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241015033601.3206952-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Hi Hongzhen,

On 2024/10/15 11:36, Hongzhen Luo wrote:
> In fileio mode, when blcksize is not equal to PAGE_SIZE,
> erofs will attempt to set the block size of sb->s_bdev,
> which will trigger a panic. This patch fixes this.
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

File-backed mounts should support < PAGE_SIZE sizes.
You should just fix these cases instead.

Thanks,
Gao Xiang
