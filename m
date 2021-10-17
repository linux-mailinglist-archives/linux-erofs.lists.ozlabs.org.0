Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D6B4309ED
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Oct 2021 17:00:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXNVJ1SNyz2yp1
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 02:00:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=joOfFlaW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=joOfFlaW; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXNV91fBhz2yZf
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 02:00:33 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5E2860C4D;
 Sun, 17 Oct 2021 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634482829;
 bh=CZmDICCzhkLK1KqmUZwDtCRFPPI+j7qhJXvlQjcBucg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=joOfFlaWsD0EXuPnkTu8K4hBQDmSPKsg+zGvTOIf1Rvk7cBGUZx4wstFzG1b0JlA/
 VR6TzH8mqygi009HKbyo2GYrL9Fl9R/7PK0WYdpDHaXSp0gwWdLqJ+HA30qdq91FKS
 FBtfoe69HJM1UvEF/0fH4WwB4vmDAigRmy8X4TqDP312q1t24dWsJZxONuwWABGNCR
 yhjGCu8QRMiEmimPsf3FYspEluZge4iQfslvvc8DZGr/WEaTPkYtOKlBYVCzG9pvKV
 oGqDf/fJG/tY/JmvhJZY3aZv0awmlAgxoKeO1Ru2WpwjhpAfrzH7CWXcJb7P9+2gYI
 Iguqp442JncKg==
Message-ID: <ab239c64-2d3b-f41b-aac4-d1825a75c594@kernel.org>
Date: Sun, 17 Oct 2021 23:00:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 2/2] erofs: add multiple device support
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Liu Bo <bo.liu@linux.alibaba.com>, Yan Song <imeoer@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Changwei Ge
 <chge@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>
References: <20211010063345.28183-1-xiang@kernel.org>
 <20211014081010.43485-1-hsiangkao@linux.alibaba.com>
 <b5f8c41f-d781-a9d2-6ee1-77f2692f9461@kernel.org>
 <20211017041523.GA15116@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211017041523.GA15116@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/10/17 12:15, Gao Xiang wrote:
> Hi Chao,
> 
> On Sun, Oct 17, 2021 at 10:10:15AM +0800, Chao Yu wrote:
>> File won't locate in multidevices, right? otherwise it needs to shrink mapped length
>> as well.
> 
> Thanks for your review.
> 
> File can be located in multi-devices. But it's intended as I mentioned in the commit
> message, each extent won't cross devices, which is guaranteed by mkfs seriously.
> Otherwise, it's more complicated to handle (especially for the compression side) and
> has no more benefits.

Thanks for the explanation.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
