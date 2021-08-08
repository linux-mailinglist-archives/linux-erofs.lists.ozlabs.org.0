Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116A3E3D44
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Aug 2021 01:57:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GjbjN5VRMz30CG
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Aug 2021 09:56:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=owPGImm1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=owPGImm1; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GjbjG2zn8z2yxX
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 Aug 2021 09:56:50 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4068C60F42;
 Sun,  8 Aug 2021 23:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628467005;
 bh=BTc4DtYp5H2rXf9tQCGYzW//v9wT9ZrLk0Jk8h7+Sdo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=owPGImm1CC+yBVqAIvTZ58u5gOOBQH9bFiLIpZSOAH87GDkCFyvgz0J3RVrAiDbFS
 V67MgaFc91xx2e+AMcQ/yoUFAU4vPBlyaYIkweD/GF5ZaAFgW72V5sfJM4ac/DsNxP
 48q9jHUlseAVnVwrOJABhIMH3nCAtMsNurljUe2y9LI3/H1cW43Mb4rR0DKVlendl6
 WzxHB1G7ZA4KhnPavn50efw5vGhlj2NNTILIqbbXOFx04YJo/yFHYxKwqDSNFh/ZYF
 B0QEyszhp2JoZg9hjW7Z57fQ51uwL8D3/qYYpxwN/JcvgMyYCb/yfT4DnGFdDvVd6R
 4ysXgLg7ZmUpA==
Subject: Re: [PATCH -next] erofs: make symbol 'erofs_iomap_ops' static
To: Wei Yongjun <weiyongjun1@huawei.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210808063343.255817-1-weiyongjun1@huawei.com>
 <YQ/ZxZkNCtWGO6X4@B-P7TQMD6M-0146.local>
From: Chao Yu <chao@kernel.org>
Message-ID: <4ddfb962-97fc-28b0-0006-197574a1ec00@kernel.org>
Date: Mon, 9 Aug 2021 07:56:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ/ZxZkNCtWGO6X4@B-P7TQMD6M-0146.local>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hulk Robot <hulkci@huawei.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/8/8 21:19, Gao Xiang wrote:
> On Sun, Aug 08, 2021 at 06:33:43AM +0000, Wei Yongjun wrote:
>> The sparse tool complains as follows:
>>
>> fs/erofs/data.c:150:24: warning:
>>   symbol 'erofs_iomap_ops' was not declared. Should it be static?
>>
>> This symbol is not used outside of data.c, so marks it static.

Thanks for the patch, I guess it will be better to fix in original patch
if you don't mind.

Thanks,

>>
>> Fixes: 3e9ce908c114 ("erofs: iomap support for non-tailpacking DIO")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Thanks,
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang
> 
