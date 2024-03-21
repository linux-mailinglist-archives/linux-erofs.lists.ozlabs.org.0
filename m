Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E40881CBD
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 08:09:44 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MrHjlFlc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V0c5y3kRYz3dHV
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 18:09:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MrHjlFlc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V0c5s6L2Dz3bs0
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 18:09:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711004970; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ihTFB/Cfnlwh8bdbGfG+HMCy0sztUkBKf4r6pgKPIvc=;
	b=MrHjlFlc65Z8MoepEQoWpuyfqjXnzcA3ixlSqYPukoy1m0+8n2FoVQayc52nrPLHKd8ga0M6XDLADGgJgofggG/OTNbxCsPyFysEhSrmqMw/mUMMrcOztJN9NOB/j5UvrK2A3e6X3isrI5P3wGM9MxsF+plKTjBOZ121HRpdwA4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W2zkXq8_1711004968;
Received: from 30.97.48.205(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2zkXq8_1711004968)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 15:09:29 +0800
Message-ID: <581ac8bf-a0b1-4687-9f64-09cec1299b21@linux.alibaba.com>
Date: Thu, 21 Mar 2024 15:09:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: move pclustersize to struct
 z_erofs_compress_sctx
To: Noboru Asai <asai@sijam.com>, zhaoyifan@sjtu.edu.cn
References: <20240321070236.2396573-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240321070236.2396573-1-asai@sijam.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/21 15:02, Noboru Asai wrote:
> With -E(all-)fragments, pclustersize has a different value per segment,
> so move it to struct z_erofs_compress_sctx.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>

Thanks, I think it's a good change for the later fragment multi-threaded
compression.

Thanks,
Gao XIang
