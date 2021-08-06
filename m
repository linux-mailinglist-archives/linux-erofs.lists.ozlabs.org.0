Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E63E26F1
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Aug 2021 11:12:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gh0B51hHxz3cQq
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Aug 2021 19:12:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y+v10eWW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Y+v10eWW; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gh0B20vt9z3cHQ
 for <linux-erofs@lists.ozlabs.org>; Fri,  6 Aug 2021 19:12:41 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECDA16113C;
 Fri,  6 Aug 2021 09:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628241158;
 bh=gVfakN+vVEJEkHVwWBvwIWcsbdvB9+grIspJr8mNPEU=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Y+v10eWW1J89wUgq2yYaMGLzvwigXh/mmmmi9nVT//xG34nNrbe1IZkeBEVWz/8dI
 rToriWczbHQ6NH3KF8P375IE+zqapbU12B+we/ctGGbTy0nRUFtUsY6+d+7uKsmKKw
 w5Y4b4iEE7Ux/SwRRxl8iO/ES3cYyuv5n/Dei1BTtb8jZBXB+Mre5aVWMhermYLoRH
 0Tk3sfqfsvGChV2RseF5eF3vuewwbE/wqJO3N516fpFY5zJ7dgJzuVwoGCrezscflH
 U+NA4mkpd2cg1WsjaNztiAF1bOHjOT5ytPU2Ia9O7lFU9vIPBj1YhnO2lxo/Thbmhj
 y2MDDAqyFA01A==
Subject: Re: [PATCH v3 2/3] erofs: dax support for non-tailpacking regular file
To: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Jiang
 <gerry@linux.alibaba.com>, Huang Jianan <huangjianan@oppo.com>,
 Tao Ma <boyu.mt@taobao.com>
References: <20210805003601.183063-1-hsiangkao@linux.alibaba.com>
 <20210805003601.183063-3-hsiangkao@linux.alibaba.com>
 <7aa650b8-a853-368d-7a81-f435194eec33@kernel.org>
 <YQtZ+CtvB3P+7Xim@B-P7TQMD6M-0146.local>
From: Chao Yu <chao@kernel.org>
Message-ID: <2bdaab77-c219-3f42-f50d-2af856386006@kernel.org>
Date: Fri, 6 Aug 2021 17:12:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQtZ+CtvB3P+7Xim@B-P7TQMD6M-0146.local>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Xiang,

On 2021/8/5 11:24, Gao Xiang wrote:
> Thanks, it originally inherited from filesystems/ext2.rst, I will update
> this into
> dax, dax={always,never}      .....

Above change looks fine to me, thanks.

> 
> Since for such image vm-shared memory scenario, no need to add per-file
> DAX (at least for now.)

Agreed.

Thanks,
