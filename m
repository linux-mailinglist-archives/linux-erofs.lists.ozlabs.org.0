Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6088F8A390B
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 02:09:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t9PdcoK4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VGYh10BPgz3dVq
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 10:09:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t9PdcoK4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VGYgw2fw0z3cGK
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Apr 2024 10:08:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712966936; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=faQ4iAgZtQ6GPVfq/970m/sbwd+bu2o8LaONO7xAdPo=;
	b=t9PdcoK4Hpg0Kr2Kp08Vvhk2S1eCu3BSThWZ+BsrBkCZOw9DGntGghYs0aHBBS76h8dW6yVbbozRbd84/FP8bAoNE7VgLIg96nhQDAoHR1T+0atr1WTHpY5GS5bfIymmCZmukOHuayOsJfnLHuLVbguy5GwFjggKImGAQYIUAcQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W4PH-z5_1712966933;
Received: from 30.25.221.111(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4PH-z5_1712966933)
          by smtp.aliyun-inc.com;
          Sat, 13 Apr 2024 08:08:55 +0800
Message-ID: <2f1c9a66-7fe2-4df3-8025-4f8075bc06a1@linux.alibaba.com>
Date: Sat, 13 Apr 2024 08:08:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs-utils: dump: print filesystem blocksize
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20240412225107.1240188-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240412225107.1240188-1-dhavale@google.com>
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
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/4/13 06:51, Sandeep Dhavale wrote:
> mkfs.erofs supports creating filesystem images with different
> blocksizes. Add filesystem blocksize in super block dump so
> its easier to inspect the filesystem.
> 
> The filed is added at last, so the output now looks like:
> 
> Filesystem magic number:                      0xE0F5E1E2
> Filesystem blocks:                            21
> Filesystem inode metadata start block:        0
> Filesystem shared xattr metadata start block: 0
> Filesystem root nid:                          36
> Filesystem lz4_max_distance:                  65535
> Filesystem sb_extslots:                       0
> Filesystem inode count:                       10
> Filesystem created:                           Fri Apr 12 15:43:40 2024
> Filesystem features:                          sb_csum mtime 0padding
> Filesystem UUID:                              a84a2acc-08d8-4b72-8b8c-b811a815fa07
> Filesystem blocksize:                         65536
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Just a minor nit:
Could we move "Filesystem blocksize:" between the line of
"Filesystem magic number:" and "Filesystem blocks:" ?

Otherwise it looks good to me, thanks for this!

Thanks,
Gao Xiang
