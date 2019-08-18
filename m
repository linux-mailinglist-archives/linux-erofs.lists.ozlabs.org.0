Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4C916BC
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 15:17:25 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BHfB547zzDrJJ
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 23:17:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=chao@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="p2XTujf7"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BHf345Z8zDqfZ
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 23:17:14 +1000 (AEST)
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6765C20673;
 Sun, 18 Aug 2019 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566134232;
 bh=EHAg19dhuoUw2RPhHf/01UOmpOQq9u8V/sPWJh9P9hk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=p2XTujf78t56CPTrbS/mPW6FtvPSuulqBnBLybpc47xapTQsH7RHTZNEh5x9Hs3WY
 bdhzAJdyXH/ZTbYGePHEJR7izYevxiOfdnS/3HAjoG8JqTIh4E6c5Z3CCcXUPcBjjZ
 fpILNq8whh9b+0a+7i80xIqSt1pqAEnYExspt+8s=
Subject: Re: [PATCH] staging: erofs: refuse to mount images with malformed
 volume name
To: Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
 Richard Weinberger <richard@nod.at>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 linux-fsdevel@vger.kernel.org
References: <20190818102824.22330-1-hsiangkao@aol.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <d8bca74f-62db-29c2-1165-48b491ad4118@kernel.org>
Date: Sun, 18 Aug 2019 21:17:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190818102824.22330-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019-8-18 18:28, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Richard reminder [1], A valid volume name should be
> ended in NIL terminator within the length of volume_name.
> 
> Since this field currently isn't really used, let's fix
> it to avoid potential bugs in the future.
> 
> [1] https://lore.kernel.org/r/1133002215.69049.1566119033047.JavaMail.zimbra@nod.at/
> 
> Reported-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
