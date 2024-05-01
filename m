Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10308B8504
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 06:32:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hcR5PeCY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTkgX1rhKz3cQX
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 14:32:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hcR5PeCY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTkgQ63zgz3cBK
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 14:32:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714537930; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4HI4t/wyKkr2k+kOlbTEZC54W8K6kyN2IX9gNuMMTcI=;
	b=hcR5PeCYFsOjDSxOwHM9YxXctdknuUgjvr7hpARHC7x+qpOMtI1Zk52tAYJwvCFR+8oo+NE9UeINalxWiIu1lcuw3DRwW5FRIEwVFseD59UJI+RZVEKe9ucUmfmabjyRwK3017p/Mxx4444FWSmcm23MMZsh+8gunN7bdBPUNEA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5dp5-6_1714537926;
Received: from 30.25.220.213(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5dp5-6_1714537926)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 12:32:08 +0800
Message-ID: <f96dcaa2-a22b-4fa1-a615-26df23c57228@linux.alibaba.com>
Date: Wed, 1 May 2024 12:32:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: optimize pthread_cond_signal calling
To: Noboru Asai <asai@sijam.com>
References: <20240501022420.1881305-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240501022420.1881305-1-asai@sijam.com>
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



On 2024/5/1 10:24, Noboru Asai wrote:
> Call pthread_cond_signal once per file.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
