Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350924818E0
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 04:15:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JPYLC0cjrz305W
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 14:15:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iIhu4vDC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iIhu4vDC; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JPYL35XZmz2ypX
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Dec 2021 14:15:07 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E0174B817AB;
 Thu, 30 Dec 2021 03:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73644C36AEA;
 Thu, 30 Dec 2021 03:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640834102;
 bh=EV4iXMF9x7LPsunktdUPpK6ZYJIRaiwC7eAQJyy1MTQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iIhu4vDCkM75mbyN+d9MH19q04FQtb8KF+1I4aZ5z0n4lwceyJB/m4K6tERKBasuF
 YYdYFUKLwxY6S1gI9a5pTs5SRmkuZuBchbU8D+GwjE1nWxTckqbzQ35UjufH2ejOk2
 4VzkoZ0HB2BY5MlbePOvjDG+ck7kAUjRDQ3F25U0x4Cy3m2Ze3c+8Q2d7vggzC9HW7
 Uf0/4QDLfza0zCsiadNOpEfAfMkxiu8t88ZdIT7EqlphpWUw86z2jN3lw2X/pPi66+
 dq4+GOVMa3mV8Sirm00QpJsvfjlSCU3wH1C1LvCzw/oqndtccURHvfal90rBv1hwGb
 du09IakoUC7kg==
Message-ID: <424807d2-17ce-70be-586b-70c642dcbc14@kernel.org>
Date: Thu, 30 Dec 2021 11:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 3/5] erofs: support unaligned data decompression
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
 <20211228054604.114518-4-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211228054604.114518-4-hsiangkao@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/12/28 13:46, Gao Xiang wrote:
> Previously, compressed data was assumed as block-aligned. This
> should be changed due to in-block tail-packing inline data.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
