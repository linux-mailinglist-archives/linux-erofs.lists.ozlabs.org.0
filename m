Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D84FA1A87B9
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2020 19:41:11 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491t7n0Kl2zDr6S
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 03:41:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=RqNIZMy/; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491t7Y15BszDr4h
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 03:40:54 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37F852054F;
 Tue, 14 Apr 2020 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586886052;
 bh=wifdIhHBXcBKo+z7JFNY3dNgAxQamyKVML4OkIclRLk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RqNIZMy/CJO8IlBNaoE4yafQcughMM/ou6rFRxyye6ssQ/QDZgQ4r46N+Rgrjf8Rh
 vMQq3+DYkSW7ymX04fjQI3hftHodeNJlFR7Lj24O0RGIPDD50Tx8yn6Vbaf7xAozjZ
 jm9sVOMz6gvdEIhu+509DvGCKsGXKgv073jbk3K0=
Date: Tue, 14 Apr 2020 19:40:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH 4.19.y] erofs: correct the remaining shrink objects
Message-ID: <20200414174049.GA1035385@kroah.com>
References: <20200414153820.29012-1-hsiangkao.ref@aol.com>
 <20200414153820.29012-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414153820.29012-1-hsiangkao@aol.com>
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
Cc: Gao Xiang <gaoxiang25@huawei.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 14, 2020 at 11:38:20PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> commit 9d5a09c6f3b5fb85af20e3a34827b5d27d152b34 upstream.
> 
> The remaining count should not include successful
> shrink attempts.
> 
> Fixes: e7e9a307be9d ("staging: erofs: introduce workstation for decompression")
> Cc: <stable@vger.kernel.org> # 4.19+
> Link: https://lore.kernel.org/r/20200226081008.86348-1-gaoxiang25@huawei.com
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> 
> trivial adaption, build verified.

Both backports now queued up, thanks.

greg k-h
