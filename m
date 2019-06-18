Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EA805498B7
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2019 07:47:26 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ScY82l2kzDqZR
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2019 15:47:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="siWcg5jv"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ScY16Sj7zDqYK
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2019 15:47:15 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F1F6C213F2;
 Tue, 18 Jun 2019 05:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560836832;
 bh=2ugJ+4jbEDNf3IaKlqSNtduwn51MkrS5VDiaJCRhmYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=siWcg5jv7S7enP/dNIGa2avKBd20kFJLLKKmDQOd50TmtgVpdF/ODiH9jSweJauM4
 nNPzX4HXmKyOyAqer94mO0tPqUW5raXp9pZaSocIvPrazoQm2xEnZMfxq9gCL/zAqe
 yPvtYsSUnHMEpRz+yzv515R9CO3+aPiZgySE+QsE=
Date: Tue, 18 Jun 2019 07:47:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [RFC PATCH 0/8] staging: erofs: decompression inplace approach
Message-ID: <20190618054709.GA4271@kroah.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
 <20190617203609.GA22034@kroah.com>
 <c86d3fc0-8b4a-6583-4309-911960fbe862@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c86d3fc0-8b4a-6583-4309-911960fbe862@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
 linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jun 18, 2019 at 09:47:08AM +0800, Gao Xiang wrote:
> 
> 
> On 2019/6/18 4:36, Greg Kroah-Hartman wrote:
> > On Sat, Jun 15, 2019 at 02:16:11AM +0800, Gao Xiang wrote:
> >> At last, this is RFC patch v1, which means it is not suitable for
> >> merging soon... I'm still working on it, testing its stability
> >> these days and hope these patches get merged for 5.3 LTS
> >> (if 5.3 is a LTS version).
> > 
> > Why would 5.3 be a LTS kernel?
> > 
> > curious as to how you came up with that :)
> 
> My personal thought is about one LTS kernel one year...
> Usually 5 versions after the previous kernel...(4.4 -> 4.9 -> 4.14 -> 4.19),
> which is not suitable for all historical LTSs...just prepare for 5.3...

I try to pick the "last" kernel that is released each year, which
sometimes is 5 kernels, sometimes 4, sometimes 6, depending on the
release cycle.

So odds are it will be 5.4 for the next LTS kernel, but we will not know
more until it gets closer to release time.

thanks,

greg k-h
