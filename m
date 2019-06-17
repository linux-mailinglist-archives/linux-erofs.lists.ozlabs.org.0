Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A6249175
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jun 2019 22:36:25 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45SNKL2cbDzDqW8
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2019 06:36:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ii0V8rWo"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45SNKD4pZmzDqVy
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2019 06:36:14 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EA4532084B;
 Mon, 17 Jun 2019 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560803771;
 bh=RBEoU7K4ZyXjT/BPfVR3ydSkkFVBWSYhZLSbBJZIwnE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ii0V8rWo4jEGHSK7qh1pFdLGpxHb2Hv219ILGasyXFoTZazQP6oCwgztS3yHEs1P2
 XyAUH9b7y+2Edk6GIYsLYLsn/4FzQIFDG5rF8iJmQ3RSzDK4jEiX/8AoEb8yMGpEXE
 Zy71RMbIL59ib2in0pJ2SNuk/itNAXD/1eOMafqU=
Date: Mon, 17 Jun 2019 22:36:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [RFC PATCH 0/8] staging: erofs: decompression inplace approach
Message-ID: <20190617203609.GA22034@kroah.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614181619.64905-1-gaoxiang25@huawei.com>
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
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jun 15, 2019 at 02:16:11AM +0800, Gao Xiang wrote:
> At last, this is RFC patch v1, which means it is not suitable for
> merging soon... I'm still working on it, testing its stability
> these days and hope these patches get merged for 5.3 LTS
> (if 5.3 is a LTS version).

Why would 5.3 be a LTS kernel?

curious as to how you came up with that :)

thanks,

greg k-h
