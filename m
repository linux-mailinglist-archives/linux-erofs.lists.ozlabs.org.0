Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E392CEE7
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 12:15:53 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=brL7QmJI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJtzV0rLwz3cXd
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 20:15:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=brL7QmJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJtzP32XXz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 20:15:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720606538; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kSB0JMAl7NqtwqFfA5JiRzpuxD65/SMsRdP1V89Cf4g=;
	b=brL7QmJIKk0AXmAsY9yryNAJ9bkJ+5ZHzUCl4bqWg55CFcNFbxryMAxLH70iKp0tqajA5v3Rl9wm1Yg06BAQGW07GNI5LS0IAPEh11V4GWZWE6Pt1WZH0j269wfsPp7dV7m3Z4QR8QYJ9yYPu0O8QsFHUwL2oVwd44Rjp2SzWUo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAFH2BN_1720606534;
Received: from 30.97.48.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAFH2BN_1720606534)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 18:15:35 +0800
Message-ID: <0465981f-7936-4390-bc96-28b126ccef6a@linux.alibaba.com>
Date: Wed, 10 Jul 2024 18:15:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: get rid of z_erofs_map_blocks_iter_* tracepoints
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240710083459.208362-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240710083459.208362-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/10 16:34, Hongzhen Luo wrote:
> Consolidate them under erofs_map_blocks_* for simplicity since we
> have many other ways to know if a given inode is compressed or not.
> 
> 

Redundant blank line.  I will remove it manually.

> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Otherwise it looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
