Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3D894886
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 02:46:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CgQ5I/Jm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V7q206ZS2z3cVG
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 11:46:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CgQ5I/Jm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V7q1t6g0Hz3bsX
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 11:46:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712018764; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N+sabjCEwa704M2BmDGTJCw/At3vN1ynjj204Qasdyg=;
	b=CgQ5I/Jmha8Y8aP0ucW0KFVVkx1rRByIuG+YPAWJ2MeDn7s9efWYOGtWKlYcoSV/kB6g9DCTqKlCO7UzxdGJbafefTBvFACiv+r2ycSiIWYIRez6ZaSMtPAsgO63GNO1qszz3P2LuPL6hSCHMwh3pAKAJ9Gm6hCoBYiLwf29dnA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W3m9fRr_1712018761;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3m9fRr_1712018761)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 08:46:03 +0800
Message-ID: <928d39ae-6400-43af-a7a8-54735def2e97@linux.alibaba.com>
Date: Tue, 2 Apr 2024 08:46:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: rename utils.c to zutil.c
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240401135550.2550043-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240401135550.2550043-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/1 21:55, Chunhai Guo wrote:
> Currently, utils.c is only useful if CONFIG_EROFS_FS_ZIP is on.
> So let's rename as zutil.c as well as avoid its inclusion if
> CONFIG_EROFS_FS_ZIP is explicitly disabled.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> Suggested-by: Gao Xiang <xiang@kernel.org>

Looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
