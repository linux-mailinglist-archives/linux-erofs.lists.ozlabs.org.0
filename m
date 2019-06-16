Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD447394
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Jun 2019 09:14:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45RQZy2sPrzDqv6
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Jun 2019 17:14:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nM3sukd6"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45RQZt03X9zDqDP
 for <linux-erofs@lists.ozlabs.org>; Sun, 16 Jun 2019 17:14:44 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 95789216C8;
 Sun, 16 Jun 2019 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560669282;
 bh=TsEIfqrLetJOZ1J+ofJiABOKfbOjLk50JJQme18BgQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nM3sukd611tDM48gnQkh0krGzYijVO4UchfAxNp5bo89tXxJ7mkqsgZ688zODdf7J
 hBrV7qnyTvk86W4otao3xudQX+G6dQc7mTSbjWL8c3kzfFAxb9MNZT0On+7vI05b4h
 +JMSHwCs3TYT2HwFk5MzFR/hPqPB8LWPSvaRZhSQ=
Date: Sun, 16 Jun 2019 09:14:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v3 1/2] staging: erofs: add requirements field in
 superblock
Message-ID: <20190616071439.GA11880@kroah.com>
References: <20190611024220.86121-1-gaoxiang25@huawei.com>
 <20190613083541.67091-1-gaoxiang25@huawei.com>
 <a4d587eb-c4f0-b9e5-7ece-1ac38c2735f3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d587eb-c4f0-b9e5-7ece-1ac38c2735f3@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
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
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 weidu.du@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Jun 16, 2019 at 03:00:38PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> Sorry for annoying... Could you help merge these two fixes? Thanks in advance...

It was only 3 days, please give me at the very least, a week or so for
staging patches.

> decompression inplace optimization needs these two patches and I will integrate
> erofs decompression inplace optimization later for linux-next 5.3, and try to start 
> making effort on moving to fs/ directory on kernel 5.4...

You can always send follow-on patches, I apply them in the correct
order.  I will get to these next week, thanks.

greg k-h
