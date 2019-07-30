Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 336677A217
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2019 09:20:17 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ySct5NXLzDqNC
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2019 17:20:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RdwyT9ZG"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45yScn4KzlzDqDf
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jul 2019 17:20:08 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 47BE8205F4;
 Tue, 30 Jul 2019 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564471205;
 bh=9y/PgAzXo/m4joi54xT8C0Iz0DdA8XYDsZHcV0xUO/g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RdwyT9ZG7X9tDjx/BvLfCtHEWCuoh0oEvIRDutVVHHYuqo4FMoW7f4cjet4QQHQ1Y
 Pyu0SYue2LwM4uZG8/c6zuyy076SrXJYnKcEViTbzumnG/beEhJFGWZuFQOvKYOnF3
 0ISVore9s6e7RACEyqeWKiBMFsIZVKWf6wkxbX0A=
Date: Tue, 30 Jul 2019 09:20:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 01/22] staging: erofs: update source file headers
Message-ID: <20190730072003.GA31548@kroah.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-2-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729065159.62378-2-gaoxiang25@huawei.com>
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
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 29, 2019 at 02:51:38PM +0800, Gao Xiang wrote:
> - Use the correct style for all SPDX License Identifiers;
> - Get rid of the unnecessary license boilerplate;
> - Use "GPL-2.0-only" instead of "GPL-2.0" suggested-by Stephen.

Note, either tag works just fine, they are identical.  I'll take this,
but just be aware of this in the future please.

thanks,

greg k-h
