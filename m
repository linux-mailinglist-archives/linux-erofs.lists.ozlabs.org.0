Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4C8AFCA6
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 01:34:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aXt6OTPW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPJP66Nwxz3dK9
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 09:34:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aXt6OTPW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPJNw1zXSz3d39
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 09:34:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713915257; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9Gxowe4obBcWj3O95wnWmGmXXcjuigIjukpVqtM1i1k=;
	b=aXt6OTPWyYrpLbsEa+631Y0jWlD/JbA9P0MpqIuK4DRMhtQwFXO1GmIe2QVBt6RhTWAMInxE2RsiSZle3ngfuZPMTsYKXKxhwMzHSrpIgo3Sjq4VLmZ17MiOSkDBs927tYiGx9AaKlS4W3GqRTlZz6n139nJYkoMyVnNsZ8A5gw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W5ACaKE_1713915254;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5ACaKE_1713915254)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 07:34:15 +0800
Message-ID: <4ac3f6e8-9801-473e-85e0-405a4283dc2a@linux.alibaba.com>
Date: Wed, 24 Apr 2024 07:34:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] BUG: using smp_processor_id() in preemptible
 code in z_erofs_get_gbuf
To: syzbot <syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000035775f0615b72d01@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <00000000000035775f0615b72d01@google.com>
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



On 2024/4/10 13:19, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:


#syz invalid

Since
https://lore.kernel.org/r/20240408215231.3376659-1-dhavale@google.com
has been folded into the original patch and this issue is only in -next.

Thanks,
Gao Xiang
