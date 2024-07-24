Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77293AB5B
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 04:45:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DftudeNq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WTJKL04Hsz3chL
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 12:45:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DftudeNq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WTJKF0xqyz3bwL
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2024 12:45:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721789115; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UncQ0rYfgkpA5fLsd9G82bNMqodLN9BEWnby9Sjuo1s=;
	b=DftudeNq7OPDjKAMS1Y/5JVx3nTPKQ9rh7DzGAFaRbtA4yp8It0gNG38QRTXf6OoKnpYtwlvDKxvZL6yxsGMuCnCEBVLYKyYlulJlDQH5KeVdlQornwJaGPt1bkyJTP2y5JKXcrjJBbFB/bE7yt8vRt0GsRbJIf5l3hI3l/IuXo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WBC4A2E_1721789112;
Received: from 30.97.48.195(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBC4A2E_1721789112)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 10:45:13 +0800
Message-ID: <96238616-071e-43f8-9a14-5d4beab64217@linux.alibaba.com>
Date: Wed, 24 Jul 2024 10:45:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com
References: <20240724020721.2389738-1-nichen@iscas.ac.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240724020721.2389738-1-nichen@iscas.ac.cn>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/24 10:07, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: 84a2ceefff99 ("erofs: tidy up stream decompressors")

I think typos are bugfixes, so I will drop this label.

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Will apply, thanks.

Thanks,
Gao Xiang
