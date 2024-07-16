Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC22F931F42
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 05:27:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iosflr3X;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WNPdy6MDHz3cBd
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 13:27:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iosflr3X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WNPd95FMfz3cYx
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2024 13:27:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721100424; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=snXbxlGrpI5soGZAgNNwOjs3bk91mqG3nSKbkacYhUg=;
	b=iosflr3XK1nSccm5d+v5FdVj0pIHOM804Dt/HNsw4/fK7qrpOzE+aRQ4dcZSSFhbmpcW0RCKBE7Cylgn0XS/XNZBTVcHrxH/ldQntEjcU6htsBrdCKTh9NGpPuix4onYdPD0PE/PcWWywYhK9rjSuTXhF6Pbdv41yEV7vjC0V9I=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAfwII1_1721100421;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAfwII1_1721100421)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 11:27:03 +0800
Message-ID: <0941509e-b746-4914-b8d0-e8dabbd7ecbd@linux.alibaba.com>
Date: Tue, 16 Jul 2024 11:27:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Addition of zstd compression to erofs release?
To: Ian Kent <raven@themaw.net>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <61ae7e16-5b98-4b8e-93ab-d796b5fa9149@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <61ae7e16-5b98-4b8e-93ab-d796b5fa9149@themaw.net>
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



On 2024/7/16 11:02, Ian Kent wrote:
> Hi,
> 
> 
> I see zstd compression is present in the experimental branch.
> 
> Just wondering when it's likely to be available in a release or is it to soon to know?
Yes, it will be in the erofs-utils 1.8 release.
I'm doing some final tests these days.

Thanks,
Gao Xiang

> 
> 
> Ian
