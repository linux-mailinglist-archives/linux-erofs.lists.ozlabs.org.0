Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC859945FF
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 13:03:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNCmx48G0z2ygy
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 22:03:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728385407;
	cv=none; b=n7iCD56oTma1PUcC7X2PrPKZ1n+2VeZ8iPTR+iZ/GzAmq5DVCBh4yocA5nXo9IiMIf+hrC8pYA4pAho4cyc8Vb4gUZ9BUh4bTgvo/wixICE4UqJBl8ngUBXC8s2a9tzB/1NquQzrt6OqDSX2r2NExIiA8+gCV0jIpP1gJZN9yUMMPPOvJXZeTN94jZUrEQnpNm79i95zIg+Vl8UKeXZy+tK5WLPJZ4Y4rh/cR1+U3Gb3cdmj4gvHgC0xqdcTMT3yCNl2Ie0HOVFWz2V2kwlzPMLQKxFk7WkEn/JWqpmUgRASH/oCYMjuPwFhLhbJ6MHoNQLhquISEHeRBIoNZd1U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728385407; c=relaxed/relaxed;
	bh=BhEeEmz5Ayr7UdeKSQa+kZhHdOTpdr9AhSIJbiGT5Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPqmnb0emER/Fn00YDIYNIrnbW16PghowsXbEk3f7Lab/Sa5t6Apz4hdbpdXjw1CL1kCNNvRJJI4fvExBs5aQZ/15PYlv6tvYmIej7/LSS94C7SGYP5ueeZbjijdozHdAwXhhiZ4UB5Qrb4Jl7lVAYGt8rgoEC7SMFSeDuNvC7DoOtGPw+djafd+I4ALRB2bzZpUswGPtKlwznw7KfFfJ7dJ8Y7Xf4GpTcovQ1knD7DFnVLXx0ovUQqxsP/Ef0D5Ns+ZNdyvL1vg4feVum5pK71NJeMPaYlEx8ZhMlcJunBxllvlUiy0WUkY6iFZQ9L6eT4b3Wy1oU480kKTxQXiJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jNu5FZfz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jNu5FZfz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNCml4sygz2yMX
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 22:03:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728385389; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BhEeEmz5Ayr7UdeKSQa+kZhHdOTpdr9AhSIJbiGT5Vg=;
	b=jNu5FZfza7bm06qo46RkFurdO2aFi9FtQxsoWJ9NKTKpJfjCuio8FHevMWsoCpSABHp6wHr1eCzWkz1AJGyyTIp32K15xCzwUBhbSOodcv0tmyokDvpiasmNtTKWIqZ3GNIt0KgHGv+TWZDNXwtpmxG9ry0GcY2ZlRRG2eAtCl0=
Received: from 30.221.129.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGeblGu_1728385386)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 19:03:07 +0800
Message-ID: <4276433b-976e-4e27-9568-ab02e6759905@linux.alibaba.com>
Date: Tue, 8 Oct 2024 19:03:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 1/5] erofs: get rid of erofs_inode_datablocks()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
 <2024100829-unplowed-vending-675b@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024100829-unplowed-vending-675b@gregkh>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/8 18:26, Greg Kroah-Hartman wrote:
> On Tue, Oct 08, 2024 at 02:57:04PM +0800, Gao Xiang wrote:
>> commit 4efdec36dc9907628e590a68193d6d8e5e74d032 upstream.
>>
>> erofs_inode_datablocks() has the only one caller, let's just get
>> rid of it entirely.  No logic changes.
>>
>> Reviewed-by: Yue Hu <huyue2@coolpad.com>
>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>> Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
>> Link: https://lore.kernel.org/r/20230204093040.97967-1-hsiangkao@linux.alibaba.com
>> [ Gao Xiang: apply this to 6.6.y to avoid further backport twists
>>               due to obsoleted EROFS_BLKSIZ. ]
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Obsoleted EROFS_BLKSIZ impedes efforts to backport
>>   9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
>>   9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
>>
>> To avoid further bugfix conflicts due to random EROFS_BLKSIZs
>> around the whole codebase, just backport the dependencies for 6.1.y.
> 
> all now queued up, thanks.

Thanks Greg, I'd like to avoid obsoleted EROFS_BLKSIZ
conflicts for 6.1.y anymore (and just a few dependencies
to avoid this), so that will save the future bugfix
backport efforts around the 6.1.y codebase.

For more older stable versions, I will manually handle
conflicts later since more non-trivial dependencies need
otherwise but I think bugfixes for older stable versions
will become fewer and fewer...

Thanks,
Gao Xiang

> 
> greg k-h

